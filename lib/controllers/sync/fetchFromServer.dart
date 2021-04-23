import 'package:hasura_connect/hasura_connect.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class ServerFetchController {
  HasuraConnect gqlConnect;
  final Isar isar = Get.find<Isar>();

  ServerFetchController({required this.gqlConnect});

  Future<dynamic> fetch() async {
    // fetch last time any project was revisioned server side
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
    dynamic result;
    try {
      result = await gqlConnect.query(
        r'''
        query allDataQuery($projectsServerRevAt: timestamptz) {
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
    return result;

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
  }
}