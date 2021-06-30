import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/store.dart';

class WidgetTypeOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  WidgetTypeOperation({required this.gqlConnect, required this.operation}) {
    run();
  }

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertWidgetTypes($update_columns: [widget_types_update_column!]!, $object: widget_types_insert_input!) {
              insert_widget_types_one(object: $object, on_conflict: {constraint: widget_types_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'value',
            'needs_list',
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
      if (e.toString().contains('JWTExpired')) {
        print('jwt expired');
        // re-connect
        authController.value = AuthController();
      } else {
        Get.snackbar(
          'Error writing widget type to server',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    return;
  }
}
