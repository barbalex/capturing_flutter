import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/table.dart';

part 'field.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

@Collection()
class Field {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? tableId;

  @Index(
    composite: [CompositeIndex('tableId')],
  )
  String? name;

  String? label;

  @Index()
  int? ord;

  bool? isInternalId;

  String? fieldType;

  String? widgetType;

  String? optionsTable;

  String? standardValue;

  // used only locally
  // goal: remember last value entered, enable setting it in new rows
  String? lastValue;

  DateTime? clientRevAt;
  String? clientRevBy;

  @Index()
  late DateTime serverRevAt;

  @Index()
  late bool deleted;

  Field({
    this.tableId,
    this.name,
    this.label,
    this.ord,
    this.isInternalId,
    this.fieldType,
    this.widgetType,
    this.optionsTable,
    this.standardValue,
    this.lastValue,
    this.clientRevAt,
    this.clientRevBy,
  }) {
    id = uuid.v1();
    label = label ?? this.name ?? null;
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now();
    clientRevBy = clientRevBy ?? _authController.userEmail ?? '';
    serverRevAt = DateTime.parse('1970-01-01 01:00:00.000');
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'table_id': this.tableId,
        'name': this.name,
        'label': this.label,
        'ord': this.ord,
        'is_internal_id': this.isInternalId,
        'field_type': this.fieldType,
        'widget_type': this.widgetType,
        'options_table': this.optionsTable,
        'standard_value': this.standardValue,
        'client_rev_at': this.clientRevAt?.toIso8601String(),
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt.toIso8601String(),
        'deleted': this.deleted,
      };

  Field.fromJson(Map p)
      : id = p['id'],
        tableId = p['table_id'],
        name = p['name'],
        label = p['label'],
        ord = p['ord'],
        isInternalId = p['is_internal_id'],
        fieldType = p['field_type'],
        widgetType = p['widget_type'],
        optionsTable = p['options_table'],
        standardValue = p['standard_value'],
        clientRevAt = DateTime.tryParse(p['client_rev_at']),
        clientRevBy = p['client_rev_by'],
        serverRevAt = DateTime.parse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation = DbOperation(table: 'fields').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.fields.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    if (this.ord == null && this.tableId != null) {
      int? highestOrd = await isar.fields
          .where()
          .tableIdEqualTo(this.tableId)
          .ordProperty()
          .max();
      this.ord = highestOrd != null ? highestOrd + 1 : 0;
    }
    DbOperation operation = DbOperation(table: 'fields').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.fields.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    // 1. update other fields
    this.clientRevAt = DateTime.now();
    this.clientRevBy = _authController.userEmail ?? '';
    Map operationData = this.toMap();
    DbOperation dbOperation =
        DbOperation(table: 'fields').setData(operationData);
    // 2. update isar and server
    await isar.writeTxn((isar) async {
      await isar.fields.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  Future<void> saveData() async {
    await this.save();
    return;
  }

  String getLabel() {
    return this.label ?? this.name ?? ''.tr;
  }

  List<String> getUrl() {
    final Isar isar = Get.find<Isar>();
    Ctable? table =
        isar.ctables.where().idEqualTo(tableId ?? '').findFirstSync();
    if (table == null) return [].toList() as List<String>;

    List<String> url = table.getUrl();
    url.add('/fields/');
    url.add(this.id);
    return url.toList();
  }
}
