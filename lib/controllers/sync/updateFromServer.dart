import 'dart:io';

import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/relType.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/models/widgetType.dart';
import 'package:capturing/models/widgetsForField.dart';
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
        Account newAccount = Account.fromJson(serverAccount.toMap());
        await isar.accounts.put(newAccount);
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
        Field newField = Field.fromJson(serverField.toMap());
        await isar.fields.put(newField);
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
        FieldType newFieldType = FieldType.fromJson(serverFieldType.toMap());
        await isar.fieldTypes.put(newFieldType);
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
            // one of these has not been synced yet
            return;
          }
          String ref =
              '${project.accountId ?? 'account'}/${project.id}/${row.tableId ?? 'table'}/${row.id}/${serverFile.fieldId ?? 'field'}/${serverFile.filename ?? 'name'}';
          // download file, 2: download
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String localPath =
              '${appDocDir.path}/${serverFile.filename ?? 'name'}';
          File downloadToFile = File(localPath);
          try {
            await fbStorage.ref(ref).writeToFile(downloadToFile);
          } on FirebaseException catch (e) {
            // e.g, e.code == 'canceled'
            print(e);
            return;
          }
          // download file, 3: set localPath and put file into isar
          Cfile newFile = Cfile.fromJson(serverFile.toMapFromServer());
          newFile.localPath = localPath;
          await isar.cfiles.put(newFile);
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
        OptionType newOptionType =
            OptionType.fromJson(serverOptionType.toMap());
        await isar.optionTypes.put(newOptionType);
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
        Project newProject = Project.fromJson(serverProject.toMap());
        await isar.projects.put(newProject);
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
        ProjectUser newProjectUser =
            ProjectUser.fromJson(serverProjectUser.toMap());
        await isar.projectUsers.put(newProjectUser);
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
        Crow newRow = Crow.fromJson(serverRow.toMapFromServer());
        await isar.crows.put(newRow);
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
        RelType newRelType = RelType.fromJson(serverRelType.toMap());
        await isar.relTypes.put(newRelType);
      });
    });

    // ctables
    List<dynamic> serverCtablesData = (result?['data']?['tables'] ?? []);
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
        Ctable newCtable = Ctable.fromJson(serverCtable.toMap());
        await isar.ctables.put(newCtable);
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
        CUser newUser = CUser.fromJson(serverUser.toMap());
        await isar.cUsers.put(newUser);
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
        WidgetType newWidgetType =
            WidgetType.fromJson(serverWidgetType.toMap());
        await isar.widgetTypes.put(newWidgetType);
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
        WidgetsForField newWidgetType =
            WidgetsForField.fromJson(serverWidgetType.toMap());
        await isar.widgetsForFields.put(newWidgetType);
      });
    });

    return;
  }
}
