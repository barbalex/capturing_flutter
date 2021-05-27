import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

class TableOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  TableOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    print(
        'table operation, operation: $operation, data: ${operation.getData()}');
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertTables($update_columns: [tables_update_column!]!, $object: tables_insert_input!) {
              insert_tables_one(object: $object, on_conflict: {constraint: tables_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'name',
            'label',
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
      );
      // remove this operation
      await isar.writeTxn((_) async {
        await isar.dbOperations.delete(operation.id ?? 0);
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error writing table to server',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return;
  }
}
