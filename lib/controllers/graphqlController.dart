import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:capturing/models/project.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

class GraphqlController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  HasuraConnect gqlConnect = HasuraConnect(graphQlUri);
  final Isar isar = Get.find<Isar>();

  void initGraphql() async {
    // HasuraConnect wsConnect = HasuraConnect(wsGraphQlUri,
    //     headers: {'authorization': 'Bearer ${authController.token}'});
    //HasuraConnect wsConnect = HasuraConnect(wsGraphQlUri);

    // need to refresh token when it expires
    // use interceptor, see:
    // https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-732187377
    //
    // the following is using this solution: https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-669650467
    // but does not work?
    // HasuraConnect gqlConnect = HasuraConnect(graphQlUri, headers: {
    //   "X-Hasura-Role": "user",
    // }, token: (isError) async {
    //   final token = await authController.getIdToken();
    //   return "Bearer ${token}";
    // });

    String? projectsLastServerRevAt = await isar.projects
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    // Errors. see: https://github.com/isar/isar/issues/83
    // String? projectsLastServerRevAtMaxxed =
    //     await isar.projects.where().serverRevAtProperty().max() ??
    //         '1900-01-01T00:00:00+01:00';
    print(projectsLastServerRevAt);
    var result;
    try {
      result = await gqlConnect.query(
        r'''
        query allDataSubscription($projectsServerRevAt: timestamptz) {
          projects(where: {server_rev_at: {_gt: $projectsServerRevAt}}) {
            id
            label
            name
            account_id
            client_rev_at
            client_rev_by
            deleted
            server_rev_at
            srs_id
          }
        }
      ''',
        variables: {'projectsServerRevAt': projectsLastServerRevAt},
      );
    } catch (e) {
      print('graphqlController, error fetching server data: $e');
    }
    print('result: $result');

    // does not work in local dev, see: https://github.com/Flutterando/hasura_connect/issues/96
    // Snapshot snapshot = await wsConnect.subscription('''
    //   subscription allDataSubscription {
    //     projects {
    //       id
    //       label
    //       name
    //       account_id
    //     }
    //   }
    //   ''');
    //
    // TODO: need to refetch token after one hour when firebase token expires
    // see: https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-669650467
    // and solution: https://gist.github.com/osaxma/141d6be2b522f8bfe8673af14eb20bd1
    //
    // snapshot.listen((data) {
    //   print('graphqlController, data from subscription: $data');
    // });

    // TODO: token updates every hour > how to catch?
    // TODO: start subscriptions
    // TODO: start syncing
    //
    // Syncing concept without subscriptions
    //
    // 1 incoming
    // 1.1 Send pending operations first (server solves conflicts)
    // 1.2 per table
    //     fetch and process all data with server_rev_at > most recent server_rev_at ✓
    //     on startup (subscriptions: on every change) ✓
    List<dynamic> projectsData = (result?['data']?['projects'] ?? []);
    List<Project> projects = List.from(
      projectsData.map((p) => Project.fromJson(p)),
    );
    print('projects: $projects');
    print('project names: ${projects.map((e) => e.name)}');
    List<Project> projectsToUpdate = [];
    // I would like to iterate over projectsData
    // to avoid having to build projects
    // but due to typing that seems not possible
    await Future.forEach(projects, (Project p) async {
      Project? isarProject =
          await isar.projects.where().idEqualTo(p.id).findFirst();
      // 1 does not exist
      if (isarProject == null) return projectsToUpdate.add(p);
      // 2 is not equal
      if (!isarProject.isEqual(p)) return projectsToUpdate.add(p);
    });
    print('projectsToUpdate: $projectsToUpdate');
    await isar.writeTxn((isar) async {
      await isar.projects.putAll(projectsToUpdate);
    });

    // 2 Outgoing, when local object is edited:
    // 2.1 Write operation into locally saved pending operations collection in isar
    //     There is a SINGLE array: need to keep sequence of operations!
    //     Also: Every operation contains the data at the time the operation occured: to never break references.
    //     Every edit is an upsert. Deletion is handled by updating the "deleted" field.
    //     So: pending operations array is array of objects with fields: "table", "id" and "data".
    //     Can I have a dynamic map in the data field?
    //     Versioned tables: New version is written to revision table. Type is always insert.
    //     Unversioned tables: write directly to table.
    // 2.2 Try to immediately execute all pending operations.
    isar.operations.isar.operations.watchLazy().listen((_) async {
      print('graphqlController watching operations - something changed');
      // TODO: write all pending operations to server
      List<Operation> operations =
          await isar.operations.where().sortByTime().findAll();
      // clone list because need to delete items inside the loop
      [...operations].forEach((operation) async {
        print('operation: $operation');

        var result;
        try {
          result = await gqlConnect.mutation(
            r'''
            mutation upsertProjects($update_columns: [projects_update_column!]!, $object: projects_insert_input!) {
              insert_projects_one(object: $object, on_conflict: {constraint: projects_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
            variables: {
              'update_columns': [
                'account_id',
                'client_rev_at',
                'client_rev_by',
                'deleted',
                'label',
                'name',
                'srs_id'
              ],
              'object': operation.getData()
            },
          );
          // remove this operation
          await isar.writeTxn((_) async {
            await isar.operations.delete(operation.id ?? 0);
          });
        } catch (e) {
          print('graphqlController, error fetching server data: $e');
        }
        print('result from upserting: $result');
      });
    });
    // 2.3 Every successfull operation is removed from the pending_operations array.
    // 2.3 Retry on:
    //     - startup
    //     - next edit
    //     - connection change (https://stackoverflow.com/a/49648870/712005)
    //       Check for connection + availability of healthz on connection change
  }
}
