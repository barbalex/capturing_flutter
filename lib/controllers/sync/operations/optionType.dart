import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

class OptionTypeOperation {
  HasuraConnect gqlConnect;
  Operation operation;
  final Isar isar = Get.find<Isar>();

  OptionTypeOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertOptionTypes($update_columns: [option_types_update_column!]!, $object: option_types_insert_input!) {
              insert_option_types_one(object: $object, on_conflict: {constraint: option_types_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
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
      );
      // remove this operation
      await isar.writeTxn((_) async {
        await isar.operations.delete(operation.id ?? 0);
      });
    } catch (e) {
      print('graphqlController, error mutating data: $e');
      Get.snackbar(
        'Error writing to server',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return;
  }
}
