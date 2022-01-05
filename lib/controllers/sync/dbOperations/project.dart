import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProjectOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  ProjectOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation upsertProjects($update_columns: [projects_update_column!]!, $object: projects_insert_input!) {
              insert_projects_one(object: $object, on_conflict: {constraint: projects_pkey, update_columns: $update_columns}) {
                id
              }
            }
          '''),
          variables: {
            'update_columns': [
              'account_id',
              'client_rev_at',
              'client_rev_by',
              'deleted',
              'label',
              'name',
              'crs'
            ],
            'object': operation.getData()
          },
        ),
      );
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('JWTExpired')) {
        print('project operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing project to server',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return;
    }
    // remove this operation
    await isar.writeTxn((_) async {
      await isar.dbOperations.delete(operation.id ?? 0);
    });
    return;
  }
}
