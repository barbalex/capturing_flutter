import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

class RowOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  RowOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      var object = operation.getData();
      while (object['data'].runtimeType == String) {
        object['data'] = json.decode(object['data']);
      }
      // TODO: need to set rev, depth etc
      //print('row operation, object: ${object}');
      await gqlConnect.mutation(
        r'''
            mutation insertRow($depth: Int, $clientRevAt: timestamptz, $clientRevBy: String, $data: jsonb, $geometry: geometry, $parentRev: String, $revisions: _text, $rev: String, $rowId: uuid, $tableId: uuid, $deleted: Boolean) {
              insert_row_revs_one(object: {client_rev_at: $clientRevAt, client_rev_by: $clientRevBy, data: $data, deleted: $deleted, depth: $depth, geometry: $geometry, parent_rev: $parentRev, rev: $rev, revisions: $revisions, row_id: $rowId, table_id: $tableId}) {
                id
              }
            }
          ''',
        variables: {
          'rowId': object['row_id'],
          'tableId': object['table_id'],
          'geometry': object['geometry'],
          'data': object['data'],
          'clientRevAt': object['client_rev_at'],
          'clientRevBy': object['client_rev_by'],
          'rev': object['rev'],
          'parentRev': object['parent_rev'],
          'revisions': object['revisions'],
          'depth': object['depth'],
          'deleted': object['deleted']
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
