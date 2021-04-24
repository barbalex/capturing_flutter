import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

class ProjectOperation {
  HasuraConnect gqlConnect;
  Operation operation;
  final Isar isar = Get.find<Isar>();

  ProjectOperation({required this.gqlConnect, required this.operation});

  Future<void> run() async {
    try {
      await gqlConnect.mutation(
        r'''
            mutation upsertProjects($update_columns: [projects_update_column!]!, $object: projects_insert_input!) {
              insert_projects_one(object: $object, on_conflict: {constraint: projects_pkey, update_columns: $update_columns}) {
                id
              }
            }
          ''',
        variables: {
          'update_columns': [
            'account_id',
            'client_rev_at',
            'client_rev_by',
            'deleted',
            'label',
            'name',
            'srs_id'
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
