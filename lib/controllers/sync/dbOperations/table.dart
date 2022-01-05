import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TableOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  TableOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation upsertTables($update_columns: [tables_update_column!]!, $object: tables_insert_input!) {
              insert_tables_one(object: $object, on_conflict: {constraint: tables_pkey, update_columns: $update_columns}) {
                id
              }
            }
          '''),
          variables: {
            'update_columns': [
              'name',
              'label',
              'single_label',
              'ord',
              'label_fields',
              'label_fields_separator',
              'rel_type',
              'option_type',
              'project_id',
              'parent_id',
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
        print('table operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing table to server',
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
