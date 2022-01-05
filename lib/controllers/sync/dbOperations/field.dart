import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FieldOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  FieldOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation upsertFields($update_columns: [fields_update_column!]!, $object: fields_insert_input!) {
              insert_fields_one(object: $object, on_conflict: {constraint: fields_pkey, update_columns: $update_columns}) {
                id
              }
            }
          '''),
          variables: {
            'update_columns': [
              'table_id',
              'name',
              'label',
              'ord',
              'is_internal_id',
              'field_type',
              'widget_type',
              'options_table',
              'standard_value',
              'client_rev_at',
              'client_rev_by',
              'deleted'
            ],
            'object': operation.getData()
          },
        ),
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('field operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing field to server',
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
