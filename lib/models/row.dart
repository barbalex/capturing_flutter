import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/field.dart';
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
    clientRevAt = DateTime.now().toIso8601String();
    clientRevBy = authController.userEmail ?? '';
    depth = 1;
    parentRev = null;
    rev = '1-${md5.convert(utf8.encode('')).toString()}';
    revisions = ['1-${md5.convert(utf8.encode('')).toString()}'];
    // TODO: function that sets data if standardValues exist in field definition
    // 1. get list of fields for this table
    // 2. for each set standard value if defined
    // 3. set null if no standard values exist
    data = getStandardData();
  }

  // used to create data for pending operations
  Map<String, dynamic> toMapFromServer() => {
        'id': this.id,
        'table_id': this.tableId,
        'data': this.data,
        'geometry': this.geometry,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'rev': this.rev,
        'parent_rev': this.parentRev,
        'revisions': this.revisions,
        'depth': this.depth,
        'deleted': this.deleted,
        'conflicts': this.conflicts,
      };

  Map<String, dynamic> toMapForServer() => {
        // id is set on server
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
        // conflicts are set on server
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
      var data = json.decode(this.data ?? '{}');
      // needs double or even tripple decoding when read from server
      while (data.runtimeType == String) {
        data = json.decode(data ?? '{}');
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

  String? getStandardData() {
    // TODO: function that sets data if standardValues exist in field definition
    // 0 only run if tableId is set
    if (this.tableId == null) return null;
    // 1. get list of fields with standard values for this table
    final Isar isar = Get.find<Isar>();
    List<Field> fieldsWithStandardValue = isar.fields
        .where()
        .filter()
        .tableIdEqualTo(this.tableId ?? '')
        .and()
        .not()
        .standardValueIsNull()
        .findAllSync();
    if (fieldsWithStandardValue.length == 0) return null;
    // 2. for each set standard value
    //    respecting instructions (last(), now())
    //    and converting it to the correct type
    Map map = {};
    fieldsWithStandardValue.forEach((f) {
      // there needs to be a field type
      if (f.fieldType == null) return;
      String fieldType = f.fieldType ?? '';
      // there needs to be a name
      String fieldName = f.name ?? '';
      if (f.name == null) return;
      if (fieldType.contains('time') && f.standardValue == 'now()') {
        map[fieldName] = DateTime.now();
        return;
      }
      if (f.standardValue == 'last()' && f.lastValue != null) {
        map[fieldName] = f.lastValue;
      }
    });
    // 3. set null if no standard values exist
    return null;
  }

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'rows').setData(this.toMapForServer());
    isar.writeTxn((isar) async {
      await isar.crows.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.crows.put(this);
      DbOperation operation =
          DbOperation(table: 'rows').setData(this.toMapForServer());
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> rowMap = this.toMapForServer();
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

  Future<void> save({required String field, dynamic value}) async {
    // 0 refuse saving if no field passed
    if (field == '') return;
    // 1. update data
    Map<String, dynamic> data = this.getData();
    // save null for ''
    data['$field'] = value != '' ? value : null;
    this.data = json.encode(data);
    // 2. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = authController.userEmail ?? '';
    int newDepth = (this.depth ?? 0) + 1;
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
      await isar.dbOperations
          .put(DbOperation(table: 'rows').setData(this.toMapForServer()));
    });
  }
}
