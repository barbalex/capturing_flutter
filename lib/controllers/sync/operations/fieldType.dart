import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

class FieldTypeOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  FieldTypeOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertFieldTypes($update_columns: [field_types_update_column!]!, $object: field_types_insert_input!) {
              insert_field_types_one(object: $object, on_conflict: {constraint: field_types_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'value',
            'sort',
            'comment',
            'deleted',
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
