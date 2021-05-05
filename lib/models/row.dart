import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';
import 'dart:convert';
import 'package:capturing/utils/toPgArray.dart';
import 'package:crypto/crypto.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

// the name "Table" is used by a flutter widget which is bad when isar.g.dart is built!!
@Collection()
class Crow {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? tableId;

  String? geometry;

  String? data;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  String? rev;

  String? parentRev;

  List<String>? revisions;

  int? depth;

  List<String>? conflicts;

  Crow({
    this.tableId,
    this.data,
    this.geometry,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
    this.rev,
    this.parentRev,
    this.revisions,
    this.depth,
    this.conflicts,
  }) {
    id = uuid.v1();
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
    depth = depth ?? 0;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMapFromServer() => {
        'id': this.id,
        'table_id': this.tableId,
        'data': this.data,
        'geometry': null,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'rev': this.rev,
        'parent_rev': this.parentRev,
        'revisions': null,
        'depth': this.depth,
        'deleted': this.deleted,
        'conflicts': null,
      };

  Map<String, dynamic> toMapFromModel() => {
        //'id': uuid.v1(),
        'row_id': this.id,
        'table_id': this.tableId,
        'data': this.data,
        'geometry':
            this.geometry == null ? null : json.decode(this.geometry ?? ''),
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'rev': this.rev,
        'parent_rev': this.parentRev,
        'revisions': toPgArray(this.revisions),
        'depth': this.depth,
        'deleted': this.deleted,
        //'conflicts': toPgArray(this.conflicts),
      };

  Crow.fromJson(Map p)
      : id = p['id'],
        tableId = p['table_id'],
        data = p['data'] != null ? json.encode(p['data']) : null,
        geometry = p['geometry'] != null ? json.encode(p['geometry']) : null,
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        rev = p['rev'],
        parentRev = p['parent_rev'],
        revisions = p['revisions']?.cast<String>(),
        depth = p['depth'],
        deleted = p['deleted'],
        conflicts = p['conflicts']?.cast<String>();

  String getLabel(List<String> labelFields) {
    String label = this.id;
    if (labelFields.length > 0) {
      label = '';
      Map<String, dynamic> rowMap = this.toMapFromModel();
      var data;
      // needs double or even tripple decoding when read from server
      while (data.runtimeType == String) {
        data = json.decode(rowMap['data']);
      }
      labelFields.forEach((f) {
        var val = data?[f];
        if (val != null) {
          label = label + val;
        }
      });
    }
    if (label == '') label = this.id;
    return label;
  }

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    Operation operation =
        Operation(table: 'rows').setData(this.toMapFromServer());
    isar.writeTxn((isar) async {
      await isar.crows.put(this);
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.crows.put(this);
      Operation operation =
          Operation(table: 'rows').setData(this.toMapFromServer());
      await isar.operations.put(operation);
    });
    return;
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> rowMap = this.toMapFromServer();
    Map<String, dynamic> _data = {};
    // somehow
    // when fetched from server data is encoded TWICE
    // but not when saved in app...
    if (rowMap['data'] != null) {
      var temp = rowMap['data'];
      while (temp.runtimeType == String) {
        temp = json.decode(temp);
      }
      _data = temp;
    }

    Map<String, dynamic> data = Map<String, dynamic>.from(_data);
    return data;
  }

  Future<void> save({required String field, required dynamic value}) async {
    // 1. update data
    Map<String, dynamic> data = this.getData();
    data['$field'] = value != '' ? value : null;
    this.data = json.encode(data);
    // 2. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = authController.userEmail ?? '';
    int newDepth = this.depth ?? 0 + 1;
    String newParentRev = this.rev ?? '';
    data['deleted'] = this.deleted;
    data['depth'] = newDepth;
    data['parent_rev'] = newParentRev;
    String newHash = md5.convert(utf8.encode(data.toString())).toString();
    String newRev = '$newDepth-$newHash';
    this.depth = newDepth;
    this.parentRev = newParentRev;
    this.rev = newRev;
    this.revisions = [...this.revisions ?? [], newRev];
    // 3. update isar and server
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((_) async {
      await isar.crows.put(this);
      await isar.operations
          .put(Operation(table: 'rows').setData(this.toMapFromModel()));
    });
  }
}
