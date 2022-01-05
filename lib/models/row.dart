import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/utils/toPgArray.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

part 'row.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

// the name "Table" is used by a flutter widget which is bad when isar.g.dart is built!!
@Collection()
class Crow {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? tableId;

  String? parentId;

  String? geometry;

  double? geometryN;

  double? geometryE;

  double? geometryS;

  double? geometryW;

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
    this.parentId,
    this.data,
    this.geometry,
    this.geometryN,
    this.geometryE,
    this.geometryS,
    this.geometryW,
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
    clientRevBy = _authController.userEmail ?? '';
    depth = 1;
    parentRev = null;
    rev = '1-${md5.convert(utf8.encode('')).toString()}';
    revisions = ['1-${md5.convert(utf8.encode('')).toString()}'];
    // set data for fields where standardValues exist in field definition
    data = getStandardData();
  }

  // used to create data for pending operations
  Map<String, dynamic> toMapFromServer() => {
        'id': this.id,
        'table_id': this.tableId,
        'parent_id': this.parentId,
        'data': this.data,
        'geometry': this.geometry,
        'geometry_n': this.geometryN,
        'geometry_e': this.geometryE,
        'geometry_s': this.geometryS,
        'geometry_w': this.geometryW,
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
        'parent_id': this.parentId,
        'data': this.data,
        'geometry':
            this.geometry == null ? null : json.decode(this.geometry ?? ''),
        'geometry_n': this.geometryN,
        'geometry_e': this.geometryE,
        'geometry_s': this.geometryS,
        'geometry_w': this.geometryW,
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
        parentId = p['parent_id'],
        data = p['data'] != null ? json.encode(p['data']) : null,
        geometry = p['geometry'] != null ? json.encode(p['geometry']) : null,
        geometryN = p['geometry_n']?.toDouble(),
        geometryE = p['geometry_e']?.toDouble(),
        geometryS = p['geometry_s']?.toDouble(),
        geometryW = p['geometry_w']?.toDouble(),
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        rev = p['rev'],
        parentRev = p['parent_rev'],
        revisions = p['revisions']?.cast<String>(),
        depth = p['depth'],
        deleted = p['deleted'],
        conflicts = p['conflicts']?.cast<String>();

  List<String> getUrl() {
    final Isar isar = Get.find<Isar>();
    Ctable? table =
        isar.ctables.where().idEqualTo(tableId ?? '').findFirstSync();

    List<Crow> rowAncestry = [this];
    Crow? parentRow =
        isar.crows.where().idEqualTo(parentId ?? '').findFirstSync();
    while (parentRow != null) {
      rowAncestry.add(parentRow);
      parentRow = isar.crows
          .where()
          .idEqualTo(parentRow.parentId ?? '')
          .findFirstSync();
    }

    List<String> url = [];
    rowAncestry.forEach((row) {
      url.add(row.id);
      url.add('/rows/');
      url.add(row.tableId ?? '');
      url.add('/tables/');
    });
    url.add(table?.projectId ?? '');
    url.add('/projects/');
    return url.reversed.toList();
  }

  List<String> getSort() {
    final Isar isar = Get.find<Isar>();
    Ctable? table =
        isar.ctables.where().idEqualTo(tableId ?? '').findFirstSync();

    List<Crow> rowAncestry = [this];
    Crow? parentRow =
        isar.crows.where().idEqualTo(parentId ?? '').findFirstSync();
    while (parentRow != null) {
      rowAncestry.add(parentRow);
      parentRow = isar.crows
          .where()
          .idEqualTo(parentRow.parentId ?? '')
          .findFirstSync();
    }

    List<String> url = [];
    rowAncestry.forEach((row) {
      url.add(row.getLabel());
      url.add('/rows/');
      Ctable? table =
          isar.ctables.where().idEqualTo(row.tableId ?? '').findFirstSync();
      url.add(table?.getLabel() ?? '');
      url.add('/tables/');
    });
    Project? project =
        isar.projects.where().idEqualTo(table?.projectId ?? '').findFirstSync();
    url.add(project?.getLabel() ?? '');
    url.add('/projects/');
    return url.reversed.toList();
  }

  String getLabel() {
    final Isar isar = Get.find<Isar>();
    Ctable? table =
        isar.ctables.where().filter().idEqualTo(tableId ?? '').findFirstSync();
    List<String> labelFields = table?.labelFields ?? [];
    if (labelFields.length > 0) {
      Map<String, dynamic> data = this.getData();
      // need to get fieldType
      // if time: parse
      // if date: parse
      // use separator
      List<String> labelParts = labelFields.where((fieldId) {
        String? fieldName = isar.fields
            .where()
            .idEqualTo(fieldId)
            .nameProperty()
            .findFirstSync();
        return data[fieldName] != null;
      }).map((fieldId) {
        String? fieldName = isar.fields
            .where()
            .idEqualTo(fieldId)
            .nameProperty()
            .findFirstSync();
        dynamic val = data[fieldName];
        String? fieldType = isar.fields
            .where()
            .filter()
            .tableIdEqualTo(this.tableId)
            .and()
            .nameEqualTo(fieldName)
            .fieldTypeProperty()
            .findFirstSync();
        bool isDate = fieldType == 'date';
        bool isTime = fieldType == 'date-time';
        if (isDate) {
          val = DateFormat.yMd().format(DateTime.parse(val));
        }
        if (isTime) {
          val = DateFormat.yMd().add_jms().format(DateTime.parse(val));
        }
        return val as String;
      }).toList();
      String separator = isar.ctables
              .where()
              .filter()
              .idEqualTo(this.tableId ?? '')
              .labelFieldsSeparatorProperty()
              .findFirstSync() ??
          ', ';
      return labelParts.join(separator);
    }
    return this.id;
  }

  String? getStandardData() {
    // sets data if standardValues exist in field definition
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
      dynamic value;
      bool isDate = fieldType.contains('date');
      if (isDate && f.standardValue == 'now()') {
        value = DateTime.now().toIso8601String();
      } else if (f.standardValue == 'last()') {
        // will be null if not set
        value = f.lastValue;
      } else {
        value = f.standardValue;
      }
      // need to convert integers, decimals and booleans to their type
      if (value.runtimeType == String) {
        if (fieldType == 'integer') value = int.parse(value);
        if (fieldType == 'decimal') value = double.parse(value);
        if (fieldType == 'boolean') value = value.toLowerCase() == 'true';
      }
      map[fieldName] = value;
    });
    if (map.isNotEmpty) {
      return json.encode(map);
    }
    // 3. set null if no standard values exist
    return null;
  }

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'rows').setData(this.toMapForServer());
    await isar.writeTxn((isar) async {
      await isar.crows.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    DbOperation operation =
        DbOperation(table: 'rows').setData(this.toMapForServer());
    await isar.writeTxn((isar) async {
      await isar.crows.put(this);
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

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    Map<String, dynamic> data = this.getData();
    // 1. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = _authController.userEmail ?? '';
    int newDepth = (this.depth ?? 0) + 1;
    String newParentRev = this.rev ?? '';
    data['depth'] = newDepth;
    data['parent_rev'] = newParentRev;
    String newHash = md5.convert(utf8.encode(data.toString())).toString();
    String newRev = '$newDepth-$newHash';
    this.depth = newDepth;
    this.parentRev = newParentRev;
    this.rev = newRev;
    this.revisions = [...this.revisions ?? [], newRev];
    DbOperation dbOperation =
        DbOperation(table: 'rows').setData(this.toMapForServer());
    // 2. update isar and server
    await isar.writeTxn((_) async {
      await isar.crows.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  Future<void> saveData({required String fieldName, dynamic value}) async {
    final Isar isar = Get.find<Isar>();
    // 0 refuse saving if no field passed
    if (fieldName == '') return;
    Field? field = await isar.fields
        .where()
        .filter()
        .tableIdEqualTo(this.tableId ?? '')
        .and()
        .nameEqualTo(fieldName)
        .findFirst();
    // 1. update data
    Map<String, dynamic> data = this.getData();
    // save null for ''
    if (value == '') value = null;
    // convert data depending on fieldType
    if (value != null && value.runtimeType == String) {
      // need to convert integers, decimals and booleans to their type
      String? fieldType = field?.fieldType;
      if (fieldType == 'integer') value = int.parse(value);
      if (fieldType == 'decimal') value = double.parse(value);
      if (fieldType == 'boolean') value = value.toLowerCase() == 'true';
    }
    data[fieldName] = value;
    this.data = json.encode(data);
    // 2. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = _authController.userEmail ?? '';
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
    Map operationData = this.toMapForServer();
    DbOperation newDbOperation =
        DbOperation(table: 'rows').setData(operationData);
    // 3. update isar and server
    await isar.writeTxn((_) async {
      await isar.crows.put(this);
      await isar.dbOperations.put(newDbOperation);
      // 4. update lastValue
      try {
        // beware: lastValue is string but value can be boolean, integer...
        field?.lastValue =
            value?.toString() != null ? value?.toString() : value;
      } catch (e) {
        print(e);
      }
      await isar.fields.put(field as Field);
    });
  }
}
