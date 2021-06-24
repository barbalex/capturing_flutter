import 'dart:io';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/relType.dart';
import 'package:capturing/models/roleType.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/models/widgetType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'package:capturing/models/tileLayer.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class UpdateFromServerController {
  dynamic result;
  final Isar isar = Get.find<Isar>();
  final FirebaseStorage fbStorage = FirebaseStorage.instance;

  UpdateFromServerController({required this.result});

  Future<void> update() async {
    // accounts
    List<dynamic> serverAccountsData = (result?['data']?['accounts'] ?? []);
    List<Account> serverAccounts = List.from(
      serverAccountsData.map((p) => Account.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverAccounts, (Account serverAccount) async {
        Account? localAccount =
            await isar.accounts.where().idEqualTo(serverAccount.id).findFirst();
        if (localAccount != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.accounts.delete(localAccount.isarId ?? 0);
        }
        await isar.accounts.put(serverAccount);
      });
    });

    // fields
    List<dynamic> serverFieldsData = (result?['data']?['fields'] ?? []);
    List<Field> serverFields = List.from(
      serverFieldsData.map((p) => Field.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverFields, (Field serverField) async {
        Field? localField =
            await isar.fields.where().idEqualTo(serverField.id).findFirst();
        if (localField != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.fields.delete(localField.isarId ?? 0);
        }
        await isar.fields.put(serverField);
      });
    });

    // fieldTypes
    List<dynamic> serverFieldTypesData =
        (result?['data']?['field_types'] ?? []);
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

    // files
    List<dynamic> serverFilesData = (result?['data']?['files'] ?? []);
    List<Cfile> serverFiles = List.from(
      serverFilesData.map((p) => Cfile.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverFiles, (Cfile serverFile) async {
        Cfile? localFile =
            await isar.cfiles.where().idEqualTo(serverFile.id).findFirst();
        // if serverFile does not have url yet
        // do not create local file yet - wait for next sync
        if (localFile == null && serverFile.url != null) {
          // download file, 1: get ref
          Crow? row;
          Ctable? table;
          Project? project;
          try {
            row = await isar.crows
                .where()
                .filter()
                .idEqualTo(serverFile.rowId ?? '')
                .findFirst();
            table = await isar.ctables
                .where()
                .filter()
                .idEqualTo(row?.tableId ?? '')
                .findFirst();
            project = await isar.projects
                .where()
                .filter()
                .idEqualTo(table?.projectId ?? '')
                .findFirst();
          } catch (e) {
            print(e);
            return;
          }
          if (project == null || table == null || row == null) {
            // one of these has not been synced yet - happens on first login
            // print(
            //     'syncing files: not updating because project, table or row was null');
            return;
          }
          String ref =
              '${project.accountId ?? 'account'}/${project.id}/${row.tableId ?? 'table'}/${row.id}/${serverFile.fieldId ?? 'field'}/${serverFile.filename ?? 'name'}';
          // download file, 2: download
          Directory appDocDir = await getApplicationDocumentsDirectory();
          // need to create directories
          await Directory(
                  '${appDocDir.path}/${project.accountId ?? 'account'}/${project.id}/${row.tableId ?? 'table'}/${row.id}/${serverFile.fieldId ?? 'field'}')
              .create(recursive: true);
          String localPath = '${appDocDir.path}/${ref}';
          File downloadToFile = File(localPath);
          try {
            await fbStorage.ref(ref).writeToFile(downloadToFile);
          } on FirebaseException catch (e) {
            // e.g, e.code == 'canceled'
            print('Error syncing to local file: $e');
            return;
          }
          // download file, 3: set localPath and put file into isar
          serverFile.localPath = localPath;
          await isar.cfiles.put(serverFile);
        } else {
          // no need to update local file, because files are only created and deleted
          if (serverFile.deleted) {
            localFile?.deleted = true;
          }
        }
      });
    });

    // optionTypes
    List<dynamic> serverOptionTypesData =
        (result?['data']?['option_types'] ?? []);
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

    // projects
    List<dynamic> serverProjectsData = (result?['data']?['projects'] ?? []);
    List<Project> serverProjects = List.from(
      serverProjectsData.map((p) => Project.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverProjects, (Project serverProject) async {
        Project? localProject =
            await isar.projects.where().idEqualTo(serverProject.id).findFirst();
        if (localProject != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.projects.delete(localProject.isarId ?? 0);
        }
        await isar.projects.put(serverProject);
      });
    });

    // projectUsers
    List<dynamic> serverProjectUsersData =
        (result?['data']?['project_users'] ?? []);
    List<ProjectUser> serverProjectUsers = List.from(
      serverProjectUsersData.map((p) => ProjectUser.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverProjectUsers,
          (ProjectUser serverProjectUser) async {
        ProjectUser? localProjectUser = await isar.projectUsers
            .where()
            .idEqualTo(serverProjectUser.id)
            .findFirst();
        if (localProjectUser != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.projectUsers.delete(localProjectUser.isarId ?? 0);
        }
        await isar.projectUsers.put(serverProjectUser);
      });
    });

    // rows
    List<dynamic> serverRowsData = (result?['data']?['rows'] ?? []);
    List<Crow> serverRows = List.from(
      serverRowsData.map((p) => Crow.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverRows, (Crow serverRow) async {
        Crow? localRow =
            await isar.crows.where().idEqualTo(serverRow.id).findFirst();
        if (localRow != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.crows.delete(localRow.isarId ?? 0);
        }
        await isar.crows.put(serverRow);
      });
    });

    // relTypes
    List<dynamic> serverRelTypesData = (result?['data']?['rel_types'] ?? []);
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
    List<dynamic> serverRoleTypesData = (result?['data']?['role_types'] ?? []);
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

    // ctables
    List<dynamic> serverCtablesData = (result?['data']?['tables'] ?? []);
    //print('updateFromServer: serverCtablesData: $serverCtablesData');
    List<Ctable> serverCtables = List.from(
      serverCtablesData.map((p) => Ctable.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverCtables, (Ctable serverCtable) async {
        Ctable? localCtable =
            await isar.ctables.where().idEqualTo(serverCtable.id).findFirst();
        if (localCtable != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.ctables.delete(localCtable.isarId ?? 0);
        }
        await isar.ctables.put(serverCtable);
      });
    });

    // users
    List<dynamic> serverUsersData = (result?['data']?['users'] ?? []);
    List<CUser> serverUsers = List.from(
      serverUsersData.map((p) => CUser.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverUsers, (CUser serverUser) async {
        CUser? localUser =
            await isar.cUsers.where().idEqualTo(serverUser.id).findFirst();
        if (localUser != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.cUsers.delete(localUser.isarId ?? 0);
        }
        await isar.cUsers.put(serverUser);
      });
    });

    // widgetTypes
    List<dynamic> serverWidgetTypesData =
        (result?['data']?['widget_types'] ?? []);
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
        (result?['data']?['widgets_for_fields'] ?? []);
    List<WidgetsForField> serverWidgetsForFields = List.from(
      serverWidgetsForFieldsData.map((p) => WidgetsForField.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverWidgetsForFields,
          (WidgetsForField serverWidgetType) async {
        WidgetsForField? localWidgetType = await isar.widgetsForFields
            .where()
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

    // tileLayers
    List<dynamic> serverTileLayersData = (result?['data']?['tileLayers'] ?? []);
    List<CtileLayer> serverTileLayers = List.from(
      serverTileLayersData.map((p) => CtileLayer.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverTileLayers,
          (CtileLayer serverTileLayer) async {
        CtileLayer? localTileLayer = await isar.ctileLayers
            .where()
            .idEqualTo(serverTileLayer.id)
            .findFirst();
        if (localTileLayer != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.ctileLayers.delete(localTileLayer.isarId ?? 0);
        }
        await isar.ctileLayers.put(serverTileLayer);
      });
    });

    // projectTileLayers
    List<dynamic> serverProjectTileLayersData =
        (result?['data']?['projectTileLayers'] ?? []);
    List<ProjectTileLayer> serverProjectTileLayers = List.from(
      serverProjectTileLayersData.map((p) => ProjectTileLayer.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverProjectTileLayers,
          (ProjectTileLayer serverProjectTileLayer) async {
        ProjectTileLayer? localProjectTileLayer = await isar.projectTileLayers
            .where()
            .idEqualTo(serverProjectTileLayer.id)
            .findFirst();
        if (localProjectTileLayer != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.projectTileLayers
              .delete(localProjectTileLayer.isarId ?? 0);
        }
        await isar.projectTileLayers.put(serverProjectTileLayer);
      });
    });

    return;
  }
}
