import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OptionTypeOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  OptionTypeOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation upsertOptionTypes($update_columns: [option_types_update_column!]!, $object: option_types_insert_input!) {
              insert_option_types_one(object: $object, on_conflict: {constraint: option_types_pkey, update_columns: $update_columns}) {
                id
              }
            }
          '''),
          variables: {
            'update_columns': [
              'id',
              'value',
              'save_id',
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
        print('option type operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing option type to server',
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
