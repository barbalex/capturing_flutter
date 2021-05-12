import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

class FileOperation {
  HasuraConnect gqlConnect;
  Operation operation;
  final Isar isar = Get.find<Isar>();

  FileOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      var object = operation.getData();
      while (object['data'].runtimeType == String) {
        object['data'] = json.decode(object['data']);
      }
      // TODO: need to set rev, depth etc
      print('file operation, object: ${object}');
      await gqlConnect.mutation(
        r'''
            mutation insertFile($depth: Int, $clientRevAt: timestamptz, $clientRevBy: String, $parentRev: String, $revisions: _text, $rev: String, $fileId: uuid, $rowId: uuid, $fieldId: uuid, $filename: String, $hash: String, $version: Int, $deleted: Boolean) {
              insert_file_revs_one(object: {client_rev_at: $clientRevAt, client_rev_by: $clientRevBy, deleted: $deleted, depth: $depth, parent_rev: $parentRev, rev: $rev, revisions: $revisions, file_id: $fileId, row_id: $rowId, field_id: $fieldId, filename: $filename, hash: $hash, version: $version}) {
                id
              }
            }
          ''',
        variables: {
          'fileId': object['file_id'],
          'rowId': object['row_id'],
          'fieldId': object['field_id'],
          'filename': object['filename'],
          'hash': object['hash'],
          'version': object['version'],
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
        await isar.operations.delete(operation.id ?? 0);
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
