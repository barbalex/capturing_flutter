import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RelTypeOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  RelTypeOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation upsertRelTypes($update_columns: [rel_types_update_column!]!, $object: rel_types_insert_input!) {
              insert_rel_types_one(object: $object, on_conflict: {constraint: rel_types_pkey, update_columns: $update_columns}) {
                id
              }
            }
          '''),
          variables: {
            'update_columns': [
              'value',
              'sort',
              'comment',
              'deleted',
            ],
            'object': operation.getData()
          },
        ),
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('rel type operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing rel type to server',
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
