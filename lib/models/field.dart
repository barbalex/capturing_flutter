import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

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

  bool? isInternalId;

  String? fieldType;

  String? widgetType;

  String? optionsTable;

  String? standardValue;

  // used only locally
  // goal: remember last value entered, enable setting it in new rows
  String? lastValue;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  Field({
    this.tableId,
    this.name,
    this.label,
    this.isInternalId,
    this.fieldType,
    this.widgetType,
    this.optionsTable,
    this.standardValue,
    this.lastValue,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    label = label ?? this.name ?? null;
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'table_id': this.tableId,
        'name': this.name,
        'label': this.label,
        'is_internal_id': this.isInternalId,
        'field_type': this.fieldType,
        'widget_type': this.widgetType,
        'options_table': this.optionsTable,
        'standard_value': this.standardValue,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Field.fromJson(Map p)
      : id = p['id'],
        tableId = p['table_id'],
        name = p['name'],
        label = p['label'],
        isInternalId = p['is_internal_id'],
        fieldType = p['field_type'],
        widgetType = p['widget_type'],
        optionsTable = p['options_table'],
        standardValue = p['standard_value'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation = DbOperation(table: 'fields').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.fields.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.fields.put(this);
      DbOperation operation =
          DbOperation(table: 'fields').setData(this.toMap());
      await isar.dbOperations.put(operation);
    });
    return;
  }
}
