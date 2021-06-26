import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

class TileLayerOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  TileLayerOperation({required this.gqlConnect, required this.operation}) {
    run();
  }

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertTileLayers($update_columns: [tile_layers_update_column!]!, $object: tile_layers_insert_input!) {
              insert_tile_layers_one(object: $object, on_conflict: {constraint: tile_layers_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'label',
            'url_template',
            'subdomains',
            'max_zoom',
            'min_zoom',
            'opacity',
            'wms_base_url',
            'wms_format',
            'wms_layers',
            'wms_parameters',
            'wms_request',
            'wms_service',
            'wms_styles',
            'wms_transparent',
            'wms_version',
            'client_rev_at',
            'client_rev_by',
            'server_rev_at',
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
        'Error writing tile layer to server',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return;
  }
}
