import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/store.dart';

class AccountOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  AccountOperation({required this.gqlConnect, required this.operation}) {
    run();
  }

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertAccounts($update_columns: [accounts_update_column!]!, $object: accounts_insert_input!) {
              insert_accounts_one(object: $object, on_conflict: {constraint: accounts_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'service_id',
            'client_rev_at',
            'client_rev_by',
            'deleted'
          ],
          'object': operation.getData()
        },
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('account operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing account to server',
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
