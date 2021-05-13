import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

class FileMutation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  FileMutation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      var data = operation.getData();
      await gqlConnect.mutation(
        r'''
            mutation insertFile($depth: Int, $clientRevAt: timestamptz, $clientRevBy: String, $parentRev: String, $revisions: _text, $rev: String, $fileId: uuid, $rowId: uuid, $fieldId: uuid, $filename: String, $url: String, $version: Int, $deleted: Boolean) {
              insert_file_revs_one(object: {client_rev_at: $clientRevAt, client_rev_by: $clientRevBy, deleted: $deleted, depth: $depth, parent_rev: $parentRev, rev: $rev, revisions: $revisions, file_id: $fileId, row_id: $rowId, field_id: $fieldId, filename: $filename, url: $url, version: $version}) {
                id
              }
            }
          ''',
        variables: {
          'fileId': data['file_id'],
          'rowId': data['row_id'],
          'fieldId': data['field_id'],
          'filename': data['filename'],
          'url': data['url'],
          'version': data['version'],
          'clientRevAt': data['client_rev_at'],
          'clientRevBy': data['client_rev_by'],
          'rev': data['rev'],
          'parentRev': data['parent_rev'],
          'revisions': data['revisions'],
          'depth': data['depth'],
          'deleted': data['deleted']
        },
      );
      // remove this operation
      await isar.writeTxn((_) async {
        await isar.dbOperations.delete(operation.id ?? 0);
      });
    } catch (e) {
      print(e);
      if (e.toString().contains('files_row_field_filename_idx')) {
        // on pg uniqueness violation when same filename is choosen twice, return user understandable message
        Get.snackbar(
          'Error saving file',
          'This row already contains a file with this name in this field. You can\'t choose the same file twice',
          snackPosition: SnackPosition.BOTTOM,
        );
        // remove cfile from isar
        var data = operation.getData();
        isar.writeTxn((isar) async {
          await isar.cfiles.delete(data['isar_id'] ?? 0);
        });
        // remove this operation
        await isar.writeTxn((_) async {
          await isar.dbOperations.delete(operation.id ?? 0);
        });
      } else {
        Get.snackbar(
          'Error writing to server',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    return;
  }
}
