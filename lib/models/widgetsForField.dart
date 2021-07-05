import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

@Collection()
class WidgetsForField {
  @Id()
  int? isarId; // auto increment id

  @Index()
  String? fieldValue;

  @Index()
  String? widgetValue;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  WidgetsForField({
    this.fieldValue,
    this.widgetValue,
    this.serverRevAt,
  }) {
    deleted = false;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'field_value': this.fieldValue,
        'widget_value': this.widgetValue,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  WidgetsForField.fromJson(Map p)
      : fieldValue = p['field_value'],
        widgetValue = p['widget_value'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'widgetsForFields').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.widgetsForFields.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    DbOperation operation =
        DbOperation(table: 'widgetsForFields').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.widgetsForFields.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }
}
