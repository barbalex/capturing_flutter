import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

class RowOperation {
  HasuraConnect gqlConnect;
  Operation operation;
  final Isar isar = Get.find<Isar>();

  RowOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      var object = operation.getData();
      object['data'] = json.decode(object['data']);
      print('row operation, object: ${object}');
      await gqlConnect.mutation(
        r'''
            mutation upsertRows($update_columns: [rows_update_column!]!, $object: rows_insert_input!) {
              insert_rows_one(object: $object, on_conflict: {constraint: rows_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'table_id',
            'geometry',
            'data',
            'client_rev_at',
            'client_rev_by',
            'rev',
            'parent_rev',
            'revisions',
            'depth',
            'deleted',
            'conflicts',
          ],
          'object': object
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
