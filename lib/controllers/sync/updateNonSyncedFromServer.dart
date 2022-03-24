import 'package:capturing/models/relType.dart';
import 'package:capturing/models/roleType.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/models/widgetType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// only updating non synced tables here

class UpdateNonSyncedFromServerController {
  QueryResult result;
  final Isar isar = Get.find<Isar>();
  final FirebaseStorage fbStorage = FirebaseStorage.instance;

  UpdateNonSyncedFromServerController({required this.result});

  Future<void> update() async {
    // fieldTypes
    List<dynamic> serverFieldTypesData = (result.data?['field_types'] ?? []);
    List<FieldType> serverFieldTypes = List.from(
      serverFieldTypesData.map((p) => FieldType.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverFieldTypes, (FieldType serverFieldType) async {
        FieldType? localFieldType = await isar.fieldTypes
            .where()
            .valueEqualTo(serverFieldType.value)
            .findFirst();
        if (localFieldType != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.fieldTypes.delete(localFieldType.isarId ?? 0);
        }
        await isar.fieldTypes.put(serverFieldType);
      });
    });

    // optionTypes
    List<dynamic> serverOptionTypesData = (result.data?['option_types'] ?? []);
    List<OptionType> serverOptionTypes = List.from(
      serverOptionTypesData.map((p) => OptionType.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverOptionTypes,
          (OptionType serverOptionType) async {
        OptionType? localOptionType = await isar.optionTypes
            .where()
            .valueEqualTo(serverOptionType.value)
            .findFirst();
        if (localOptionType != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.optionTypes.delete(localOptionType.isarId ?? 0);
        }
        await isar.optionTypes.put(serverOptionType);
      });
    });

    // relTypes
    List<dynamic> serverRelTypesData = (result.data?['rel_types'] ?? []);
    List<RelType> serverRelTypes = List.from(
      serverRelTypesData.map((p) => RelType.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverRelTypes, (RelType serverRelType) async {
        RelType? localRelType = await isar.relTypes
            .where()
            .valueEqualTo(serverRelType.value)
            .findFirst();
        if (localRelType != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.relTypes.delete(localRelType.isarId ?? 0);
        }
        await isar.relTypes.put(serverRelType);
      });
    });

    // roleTypes
    List<dynamic> serverRoleTypesData = (result.data?['role_types'] ?? []);
    List<RoleType> serverRoleTypes = List.from(
      serverRoleTypesData.map((p) => RoleType.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverRoleTypes, (RoleType serverRoleType) async {
        RoleType? localRoleType = await isar.roleTypes
            .where()
            .valueEqualTo(serverRoleType.value)
            .findFirst();
        if (localRoleType != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.roleTypes.delete(localRoleType.isarId ?? 0);
        }
        await isar.roleTypes.put(serverRoleType);
      });
    });

    // widgetTypes
    List<dynamic> serverWidgetTypesData = (result.data?['widget_types'] ?? []);
    List<WidgetType> serverWidgetTypes = List.from(
      serverWidgetTypesData.map((p) => WidgetType.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverWidgetTypes,
          (WidgetType serverWidgetType) async {
        WidgetType? localWidgetType = await isar.widgetTypes
            .where()
            .valueEqualTo(serverWidgetType.value)
            .findFirst();
        if (localWidgetType != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.widgetTypes.delete(localWidgetType.isarId ?? 0);
        }
        await isar.widgetTypes.put(serverWidgetType);
      });
    });

    // widgetsForFields
    List<dynamic> serverWidgetsForFieldsData =
        (result.data?['widgets_for_fields'] ?? []);
    List<WidgetsForField> serverWidgetsForFields = List.from(
      serverWidgetsForFieldsData.map((p) => WidgetsForField.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverWidgetsForFields,
          (WidgetsForField serverWidgetType) async {
        WidgetsForField? localWidgetType = await isar.widgetsForFields
            .filter()
            .widgetValueEqualTo(serverWidgetType.widgetValue)
            .and()
            .fieldValueEqualTo(serverWidgetType.fieldValue)
            .findFirst();
        if (localWidgetType != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.widgetsForFields.delete(localWidgetType.isarId ?? 0);
        }
        await isar.widgetsForFields.put(serverWidgetType);
      });
    });

    return;
  }
}
