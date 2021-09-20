import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';

class ProjectTileLayerOperation {
  HasuraConnect gqlConnect;
  DbOperation operation;
  final Isar isar = Get.find<Isar>();

  ProjectTileLayerOperation(
      {required this.gqlConnect, required this.operation}) {
    run();
  }

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertProjectTileLayers($update_columns: [project_tile_layers_update_column!]!, $object: project_tile_layers_insert_input!) {
              insert_project_tile_layers_one(object: $object, on_conflict: {constraint: project_tile_layers_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'project_id',
            'label',
            'ord',
            'active',
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
            'active',
          ],
          'object': operation.getData()
        },
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('project tile layer operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing project tile layer to server',
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
