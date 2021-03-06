import 'dart:convert';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RowOperation {
  DbOperation operation;
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  RowOperation(this.operation) {
    run();
  }

  Future<void> run() async {
    var object = operation.getData();
    while (object['data'].runtimeType == String) {
      object['data'] = json.decode(object['data']);
    }
    print('dbOperation for row');
    print(object);
    try {
      await graphqlClient.mutate(
        MutationOptions(
          document: gql(r'''
            mutation insertRow($depth: Int, $clientRevAt: timestamptz, $clientRevBy: String, $data: jsonb, $geometry: geometry, $geometryN: Float, $geometryE: Float, $geometryS: Float, $geometryW: Float, $parentRev: String, $revisions: _text, $rev: String, $rowId: uuid, $tableId: uuid, $parentId: uuid, $deleted: Boolean) {
              insert_row_revs_one(object: {client_rev_at: $clientRevAt, client_rev_by: $clientRevBy, data: $data, deleted: $deleted, depth: $depth, geometry: $geometry, geometry_n: $geometryN, geometry_e: $geometryE, geometry_s: $geometryS, geometry_w: $geometryW, parent_rev: $parentRev, rev: $rev, revisions: $revisions, row_id: $rowId, table_id: $tableId, parent_id: $parentId}) {
                id
              }
            }
          '''),
          variables: {
            'rowId': object['row_id'],
            'tableId': object['table_id'],
            'parentId': object['parent_id'],
            'geometry': object['geometry'],
            'geometryN': object['geometry_n'],
            'geometryE': object['geometry_e'],
            'geometryS': object['geometry_s'],
            'geometryW': object['geometry_w'],
            'data': object['data'],
            'clientRevAt': object['client_rev_at'],
            'clientRevBy': object['client_rev_by'],
            'rev': object['rev'],
            'parentRev': object['parent_rev'],
            'revisions': object['revisions'],
            'depth': object['depth'],
            'deleted': object['deleted']
          },
        ),
      );
    } catch (e) {
      print(e);
      if (e.toString().contains('JWTExpired')) {
        print('row operation: jwt expired');
        AuthController().reLogin();
      } else {
        Get.snackbar(
          'Error writing row to server',
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
