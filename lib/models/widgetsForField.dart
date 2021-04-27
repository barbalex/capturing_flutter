import 'package:isar/isar.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

final AuthController authController = Get.find<AuthController>();

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
    Operation operation =
        Operation(table: 'widgetsForFields').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.widgetsForFields.put(this);
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.widgetsForFields.put(this);
      Operation operation =
          Operation(table: 'widgetsForFields').setData(this.toMap());
      await isar.operations.put(operation);
    });
    return;
  }
}
