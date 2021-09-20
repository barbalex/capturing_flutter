import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';

class WidgetsForFieldOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  WidgetsForFieldOperation(
      {required this.gqlConnect, required this.operation}) {
    run();
  }

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertWidgetsForFields($update_columns: [rel_types_update_column!]!, $object: rel_types_insert_input!) {
              insert_rel_types_one(object: $object, on_conflict: {constraint: rel_types_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'widget_value',
            'field_value',
            'deleted',
          ],
          'object': operation.getData()
        },
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('widgets for field operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing widgets for field to server',
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
