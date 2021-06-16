import 'package:hasura_connect/hasura_connect.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/relType.dart';
import 'package:capturing/models/roleType.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/models/widgetType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServerSubscriptionController {
  HasuraConnect gqlConnect;
  final Isar isar = Get.find<Isar>();
  final FirebaseStorage fbStorage = FirebaseStorage.instance;

  ServerSubscriptionController({required this.gqlConnect});

  Future<void> run() async {
    print('ServerSubscriptionController running');

    Snapshot<dynamic> accountSnapshot;

    // fetch last time any project was revisioned server side
    String? accountsLastServerRevAt = isar.accounts
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? fieldsLastServerRevAt = isar.fields
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? fieldTypesLastServerRevAt = isar.fieldTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? filesLastServerRevAt = isar.cfiles
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? optionTypesLastServerRevAt = isar.optionTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? projectsLastServerRevAt = isar.projects
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? projectUsersLastServerRevAt = isar.projectUsers
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? rowsLastServerRevAt = isar.crows
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? ctablesLastServerRevAt = isar.ctables
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? relTypesLastServerRevAt = isar.relTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? roleTypesLastServerRevAt = isar.relTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? usersLastServerRevAt = isar.cUsers
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? widgetTypesLastServerRevAt = isar.widgetTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? widgetsForFieldsLastServerRevAt = isar.widgetsForFields
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';

    print(
        'ServerSubscriptionController, accountsLastServerRevAt: $accountsLastServerRevAt');
    // accounts
    // try {
    print(
        'ServerSubscriptionController, will subscribe to accounts, gqlConnect: ${gqlConnect.toString()}');
    accountSnapshot = await gqlConnect.subscription(
      r'''
        subscription accountsSubscription($accountsLastServerRevAt: timestamptz) {
          accounts(where: {server_rev_at: {_gt: $accountsLastServerRevAt}}) {
            id
            service_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
        }

      ''',
      variables: {
        'accountsLastServerRevAt': accountsLastServerRevAt,
      },
      key: 'accountsSubscription',
    );
    print('ServerSubscriptionController, accountSnapshot: $accountSnapshot');
    accountSnapshot.listen((data) async {
      print('account data: $data');
      List<dynamic> serverAccountsData = (data?['accounts'] ?? []);
      print('account serverAccountsData: $serverAccountsData');
      List<dynamic> serverAccountsDataNew = (data?['data']?['accounts'] ?? []);
      print('account serverAccountsDataNew: $serverAccountsDataNew');
      List<Account> serverAccounts = List.from(
        serverAccountsData.map((p) => Account.fromJson(p)),
      );
      await isar.writeTxn((isar) async {
        await Future.forEach(serverAccounts, (Account serverAccount) async {
          Account? localAccount = await isar.accounts
              .where()
              .idEqualTo(serverAccount.id)
              .findFirst();
          if (localAccount != null) {
            // unfortunately need to delete
            // because when updating this is not registered and ui does not update
            await isar.accounts.delete(localAccount.isarId ?? 0);
          }
          await isar.accounts.put(serverAccount);
        });
      });
    });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error fetching server data for accounts',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // fields
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription fieldsSubscription($fieldsLastServerRevAt: timestamptz) {
          fields(where: {server_rev_at: {_gt: $fieldsLastServerRevAt}}) {
            id
            table_id
            name
            label
            ord
            is_internal_id
            field_type
            widget_type
            options_table
            standard_value
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'fieldsLastServerRevAt': fieldsLastServerRevAt,
        },
        key: 'fieldsSubscription',
      );
      snapshot.listen((data) async {
        print('fields data: $data');
        List<dynamic> serverFieldsData = (data['fields'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for fields',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // fieldTypes
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription fieldTypesSubscription($fieldTypesLastServerRevAt: timestamptz) {
          field_types(where: {server_rev_at: {_gt: $fieldTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'fieldTypesLastServerRevAt': fieldTypesLastServerRevAt,
        },
        key: 'fieldTypesSubscription',
      );
      snapshot.listen((data) async {
        print('field types data: $data');
        List<dynamic> serverFieldTypesData = (data['field_types'] ?? []);
        List<FieldType> serverFieldTypes = List.from(
          serverFieldTypesData.map((p) => FieldType.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverFieldTypes,
              (FieldType serverFieldType) async {
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for field types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // files
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription filesSubscription($filesLastServerRevAt: timestamptz) {
          files(where: {server_rev_at: {_gt: $filesLastServerRevAt}}) {
            id
            row_id
            field_id
            filename
            url
            version
            client_rev_at
            client_rev_by
            server_rev_at
            rev
            parent_rev
            revisions
            depth
            deleted
            conflicts
          }
        }

      ''',
        variables: {
          'filesLastServerRevAt': filesLastServerRevAt,
        },
        key: 'filesSubscription',
      );
      snapshot.listen((data) async {
        print('files data: $data');
        List<dynamic> serverFilesData = (data['files'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for files',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // optionTypes
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription optionTypesSubscription($optionTypesLastServerRevAt: timestamptz) {
          option_types(where: {server_rev_at: {_gt: $optionTypesLastServerRevAt}}) {
            id
            value
            save_id
            sort
            comment
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'optionTypesLastServerRevAt': optionTypesLastServerRevAt,
        },
        key: 'optionTypesSubscription',
      );
      snapshot.listen((data) async {
        print('option types data: $data');
        List<dynamic> serverOptionTypesData = (data['option_types'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for option types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // projects
    try {
      print('will subscribe to projects');
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription projectsSubscription($projectsLastServerRevAt: timestamptz) {
          projects(where: {server_rev_at: {_gt: $projectsLastServerRevAt}}) {
            id
            label
            name
            account_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
            srs_id
          }
        }

      ''',
        variables: {
          'projectsLastServerRevAt': projectsLastServerRevAt,
        },
        key: 'projectsSubscription',
      );
      print('projects snapshot: $snapshot');
      snapshot.listen((data) async {
        print('projects data: $data');
        List<dynamic> serverProjectsData = (data['projects'] ?? []);
        List<Project> serverProjects = List.from(
          serverProjectsData.map((p) => Project.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverProjects, (Project serverProject) async {
            Project? localProject = await isar.projects
                .where()
                .idEqualTo(serverProject.id)
                .findFirst();
            if (localProject != null) {
              // unfortunately need to delete
              // because when updating this is not registered and ui does not update
              await isar.projects.delete(localProject.isarId ?? 0);
            }
            await isar.projects.put(serverProject);
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for projects',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // projectUsers
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription projectUsersSubscription($projectUsersLastServerRevAt: timestamptz) {
          project_users(where: {server_rev_at: {_gt: $projectUsersLastServerRevAt}}) {
            id
            project_id
            user_email
            role
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'projectUsersLastServerRevAt': projectUsersLastServerRevAt,
        },
        key: 'projectUsersSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverProjectUsersData = (data['project_users'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for project users',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // rows
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription rowsSubscription($rowsLastServerRevAt: timestamptz) {
          rows(where: {server_rev_at: {_gt: $rowsLastServerRevAt}}) {
            id
            table_id
            parent_id
            geometry
            geometry_n
            geometry_e
            geometry_s
            geometry_w
            data
            client_rev_at
            client_rev_by
            server_rev_at
            rev
            parent_rev
            revisions
            depth
            deleted
            conflicts
          }
        }

      ''',
        variables: {
          'rowsLastServerRevAt': rowsLastServerRevAt,
        },
        key: 'rowsSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverRowsData = (data['rows'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for rows',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // relTypes
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription relTypesSubscription($relTypesLastServerRevAt: timestamptz) {
          rel_types(where: {server_rev_at: {_gt: $relTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'relTypesLastServerRevAt': relTypesLastServerRevAt,
        },
        key: 'relTypesSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverRelTypesData = (data['rel_types'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for rel types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // roleTypes
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription roleTypesSubscription($roleTypesLastServerRevAt: timestamptz) {
          role_types(where: {server_rev_at: {_gt: $roleTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'roleTypesLastServerRevAt': roleTypesLastServerRevAt,
        },
        key: 'roleTypesSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverRoleTypesData = (data['role_types'] ?? []);
        List<RoleType> serverRoleTypes = List.from(
          serverRoleTypesData.map((p) => RoleType.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverRoleTypes,
              (RoleType serverRoleType) async {
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for role types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // ctables
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription tablesSubscription($ctablesLastServerRevAt: timestamptz) {
          tables(where: {server_rev_at: {_gt: $ctablesLastServerRevAt}}) {
            id
            name
            label
            ord
            label_fields
            label_fields_separator
            rel_type
            option_type
            project_id
            parent_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'ctablesLastServerRevAt': ctablesLastServerRevAt,
        },
        key: 'tablesSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverCtablesData = (data['tables'] ?? []);
        //print('updateFromServer: serverCtablesData: $serverCtablesData');
        List<Ctable> serverCtables = List.from(
          serverCtablesData.map((p) => Ctable.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverCtables, (Ctable serverCtable) async {
            Ctable? localCtable = await isar.ctables
                .where()
                .idEqualTo(serverCtable.id)
                .findFirst();
            if (localCtable != null) {
              // unfortunately need to delete
              // because when updating this is not registered and ui does not update
              await isar.ctables.delete(localCtable.isarId ?? 0);
            }
            await isar.ctables.put(serverCtable);
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for tables',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // users
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription usersSubscription($usersLastServerRevAt: timestamptz) {
          users(where: {server_rev_at: {_gt: $usersLastServerRevAt}}) {
            id
            name
            email
            account_id
            auth_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'usersLastServerRevAt': usersLastServerRevAt,
        },
        key: 'usersSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverUsersData = (data['users'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for users',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // widgetTypes
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription widgetTypesSubscription($widgetTypesLastServerRevAt: timestamptz) {
          widget_types(where: {server_rev_at: {_gt: $widgetTypesLastServerRevAt}}) {
            value
            needs_list
            sort
            comment
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'widgetTypesLastServerRevAt': widgetTypesLastServerRevAt,
        },
        key: 'widgetTypesSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverWidgetTypesData = (data['widget_types'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for widget types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // widgetsForFields
    try {
      Snapshot<dynamic> snapshot = await gqlConnect.subscription(
        r'''
        subscription widgetsForFieldsSubscription($widgetsForFieldsLastServerRevAt: timestamptz) {
          widgets_for_fields(where: {server_rev_at: {_gt: $widgetsForFieldsLastServerRevAt}}) {
            field_value
            widget_value
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'widgetsForFieldsLastServerRevAt': widgetsForFieldsLastServerRevAt
        },
        key: 'widgetsForFieldsSubscription',
      );
      snapshot.listen((data) async {
        List<dynamic> serverWidgetsForFieldsData =
            (data['widgets_for_fields'] ?? []);
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data for widgets for fields',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return;

    // does not work in local dev, see: https://github.com/Flutterando/hasura_connect/issues/96
    // Snapshot snapshot = await wsConnect.subscription('''
    //   subscription allDataSubscription {
    //     projects {
    //       id
    //       label
    //       name
    //       account_id
    //     }
    //   }
    //   ''');
    //
    // TODO: need to refetch token after one hour when firebase token expires
    // see: https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-669650467
    // and solution: https://gist.github.com/osaxma/141d6be2b522f8bfe8673af14eb20bd1
    //
    // snapshot.listen((data) {
    //   print('graphqlController, data from subscription: $data');
    // });
  }
}
