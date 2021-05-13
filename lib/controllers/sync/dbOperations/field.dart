import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

class FieldOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  FieldOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertFields($update_columns: [fields_update_column!]!, $object: fields_insert_input!) {
              insert_fields_one(object: $object, on_conflict: {constraint: fields_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'table_id',
            'name',
            'label',
            'is_internal_id',
            'field_type',
            'widget_type',
            'options_table',
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
        'Error writing to server',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return;
  }
}
