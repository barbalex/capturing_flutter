import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProjectUserOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  ProjectUserOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation upsertProjectUsers($update_columns: [project_users_update_column!]!, $object: project_users_insert_input!) {
              insert_project_users_one(object: $object, on_conflict: {constraint: project_users_pkey, update_columns: $update_columns}) {
                id
              }
            }
          '''),
          variables: {
            'update_columns': [
              'project_id',
              'user_email',
              'role',
              'client_rev_at',
              'client_rev_by',
              'deleted',
            ],
            'object': operation.getData()
          },
        ),
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('project user operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing project user to server',
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
