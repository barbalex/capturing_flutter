import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/tileLayer.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/auth.dart';

void checkForException({
  OperationException? exception,
  required String subscriptionName,
}) {
  if (exception != null) {
    // print(
    //     'originalException: ${exception.linkException?.originalException.toString()}');
    print(
        'originalException.payload.message: ${exception.linkException?.originalException?.payload['message']}');
    print(
        'is jwk exception: ${exception.linkException?.originalException?.payload['message'].contains('JWTExpired')}');

    // catch JWTExpired, then re-authorize
    if (exception.linkException?.originalException?.payload['message']
        .contains('JWTExpired')) {
      print('will re-authenticate');
      // store.authController.value.reLogin();
      AuthController().reLogin();

      return;
    }
    Get.snackbar(
      'Error listening to server data for ${subscriptionName}',
      exception.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class ServerSubscriptionController {
  // see: https://github.com/zino-app/graphql-flutter/issues/902#issuecomment-847869946
  final HttpLink httpLink = HttpLink(wsGraphQlUri);
  final AuthController authController = Get.find<AuthController>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  final Isar isar = Get.find<Isar>();
  final FirebaseStorage fbStorage = FirebaseStorage.instance;

  StreamSubscription<dynamic>? accountsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? fieldsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? filesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? projectsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? projectUsersSnapshotStreamSubscription;
  StreamSubscription<dynamic>? rowsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? tablesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? usersSnapshotStreamSubscription;
  StreamSubscription<dynamic>? tileLayersSnapshotStreamSubscription;
  StreamSubscription<dynamic>? projectTileLayersSnapshotStreamSubscription;

  void dispose() {
    accountsSnapshotStreamSubscription?.cancel();
    fieldsSnapshotStreamSubscription?.cancel();
    filesSnapshotStreamSubscription?.cancel();
    projectsSnapshotStreamSubscription?.cancel();
    projectUsersSnapshotStreamSubscription?.cancel();
    rowsSnapshotStreamSubscription?.cancel();
    tablesSnapshotStreamSubscription?.cancel();
    usersSnapshotStreamSubscription?.cancel();
    tileLayersSnapshotStreamSubscription?.cancel();
    projectTileLayersSnapshotStreamSubscription?.cancel();
  }

  ServerSubscriptionController() {
    // fetch last time any project was revisioned server side
    DateTime accountsLastServerRevAt =
        isar.accounts.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime fieldsLastServerRevAt =
        isar.fields.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime filesLastServerRevAt =
        isar.cfiles.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime projectsLastServerRevAt =
        isar.projects.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime projectUsersLastServerRevAt =
        isar.projectUsers.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime? rowsLastServerRevAt =
        isar.crows.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime ctablesLastServerRevAt =
        isar.ctables.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime usersLastServerRevAt =
        isar.cUsers.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime tileLayersLastServerRevAt =
        isar.ctileLayers.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime projectTileLayersLastServerRevAt =
        isar.projectTileLayers.where().serverRevAtProperty().maxSync() ??
            DateTime.fromMicrosecondsSinceEpoch(0);

    // accounts
    try {
      print(
          'Subscribing to accounts. Last server_rev: $accountsLastServerRevAt');
      Stream<QueryResult> accountsSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {
            'accountsLastServerRevAt': accountsLastServerRevAt.toIso8601String()
          },
        ),
      );
      accountsSnapshotStreamSubscription =
          accountsSubscription.listen((result) async {
        print('result from accounts: $result');
        checkForException(
          subscriptionName: 'accounts',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverAccountsData = (result.data?['accounts'] ?? []);
        if (serverAccountsData.length == 0) return;

        print('will read serverAccounts');
        List<Account> serverAccounts = List.from(
          serverAccountsData.map((p) => Account.fromJson(p)),
        );
        print('serverAccounts: $serverAccounts');
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
    } catch (e) {
      print('error when subscribing to accounts');
      print(e);
      Get.snackbar(
        'Error subscribing to server data for accounts',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // fields
    try {
      print('Subscribing to fields. Last server_rev: $fieldsLastServerRevAt');
      Stream<QueryResult> fieldsSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {
            'fieldsLastServerRevAt': fieldsLastServerRevAt.toIso8601String()
          },
        ),
      );
      fieldsSnapshotStreamSubscription =
          fieldsSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'fields',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverFieldsData = (result.data?['fields'] ?? []);
        if (serverFieldsData.length == 0) return;

        List<Field> serverFields = List.from(
          serverFieldsData.map((p) => Field.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverFields, (Field serverField) async {
            Field? localField =
                await isar.fields.where().idEqualTo(serverField.id).findFirst();
            if (localField == null) return await isar.fields.put(serverField);

            // unfortunately need to delete
            // because when updating this is not registered and ui does not update
            await isar.fields.delete(localField.isarId ?? 0);
            Map<String, dynamic> localFieldMap = localField.toMap();
            Map<String, dynamic> serverFieldMap = serverField.toMap();

            localFieldMap.keys.forEach((key) {
              if (key == 'server_rev_at') return;

              dynamic localFieldValue = localFieldMap[key];
              dynamic serverFieldValue = serverFieldMap[key];
              if (localFieldValue != serverFieldValue) {
                print(
                    'fields id "${localFieldMap['id']}": field "${key}" changes from "${localFieldValue}" to "${serverFieldValue}"');
              }
            });

            await isar.fields.put(serverField);
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for fields',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // files
    try {
      print('Subscribing to files. Last server_rev: $filesLastServerRevAt');
      Stream<QueryResult> filesSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {
            'filesLastServerRevAt': filesLastServerRevAt.toIso8601String()
          },
        ),
      );
      filesSnapshotStreamSubscription =
          filesSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'files',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverFilesData = (result.data?['files'] ?? []);
        //print('syncing files: serverFilesData: $serverFilesData');
        if (serverFilesData.length == 0) return;

        List<Cfile> serverFiles = List.from(
          serverFilesData.map((p) => Cfile.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverFiles, (Cfile serverFile) async {
            //print('syncing files: serverFile: ${serverFile.toMapForServer()}');
            Cfile? localFile =
                await isar.cfiles.where().idEqualTo(serverFile.id).findFirst();
            //print('syncing files: localFile: ${localFile?.toMapForServer()}');

            // if serverFile does not have url yet
            // do not create local file yet - wait for next sync
            if ((localFile == null || localFile.url != serverFile.url) &&
                serverFile.url != null) {
              // download file, 1: get ref
              Crow? row;
              Ctable? table;
              Project? project;
              try {
                row = await isar.crows
                    .filter()
                    .idEqualTo(serverFile.rowId ?? '')
                    .findFirst();
                table = await isar.ctables
                    .filter()
                    .idEqualTo(row?.tableId ?? '')
                    .findFirst();
                project = await isar.projects
                    .filter()
                    .idEqualTo(table?.projectId ?? '')
                    .findFirst();
              } catch (e) {
                print(e);
                return;
              }
              if (project == null || table == null || row == null) {
                // one of these has not been synced yet - happens on first login
                print(
                    'syncing files: not updating because project, table or row was null, serverFile: ${serverFile.filename}');
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
              try {
                await isar.crows.delete(localFile?.isarId ?? 0);
              } catch (e) {}
              await isar.cfiles.put(serverFile);
            }
            // no need to update local file, because files are only created and deleted
            if (serverFile.deleted == true) {
              print('this serverFile is deleted: ${serverFile.filename}');
              serverFile.localPath = localFile?.localPath;
              await isar.crows.delete(localFile?.isarId ?? 0);
              await isar.cfiles.put(serverFile);
            }
            // print('syncing files: localFile at end: $localFile');
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for files',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // projects
    try {
      // print(
      //     'Subscribing to projects. Last server_rev: $projectsLastServerRevAt');
      Stream<QueryResult> projectsSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
                crs
              }
            }
      '''),
          variables: {
            'projectsLastServerRevAt': projectsLastServerRevAt.toIso8601String()
          },
        ),
      );
      projectsSnapshotStreamSubscription =
          projectsSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'projects',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverProjectsData = (result.data?['projects'] ?? []);
        if (serverProjectsData.length == 0) return;

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

              Map<String, dynamic> localProjectMap = localProject.toMap();
              Map<String, dynamic> serverProjectMap = serverProject.toMap();

              localProjectMap.keys.forEach((key) {
                if (key == 'server_rev_at') return;

                dynamic localProjectValue = localProjectMap[key];
                dynamic serverProjectValue = serverProjectMap[key];
                if (localProjectValue != serverProjectValue) {
                  print(
                      'fields id "${localProjectMap['id']}": field "${key}" changes from "${localProjectValue}" to "${serverProjectValue}"');
                }
              });
            }

            await isar.projects.put(serverProject);
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for projects',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // projectUsers
    try {
      // print(
      //     'Subscribing to projectUsers. Last server_rev: $projectUsersLastServerRevAt');
      Stream<QueryResult> projectUsersSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {
            'projectUsersLastServerRevAt':
                projectUsersLastServerRevAt.toIso8601String()
          },
        ),
      );
      projectUsersSnapshotStreamSubscription =
          projectUsersSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'projectUsers',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverProjectUsersData =
            (result.data?['project_users'] ?? []);
        if (serverProjectUsersData.length == 0) return;

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
        'Error subscribing to server data for project users',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // rows
    try {
      //print('Subscribing to rows. Last server_rev: $rowsLastServerRevAt');
      Stream<QueryResult> rowsSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {
            'rowsLastServerRevAt': rowsLastServerRevAt.toIso8601String()
          },
        ),
      );
      rowsSnapshotStreamSubscription = rowsSubscription.listen((result) async {
        //print('rows subscription result: $result');
        checkForException(
          subscriptionName: 'rows',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverRowsData = (result.data?['rows'] ?? []);
        if (serverRowsData.length == 0) return;

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

              // Map<String, dynamic> localRowMap = localRow.toMapForServer();
              // Map<String, dynamic> serverRowMap = serverRow.toMapForServer();

              // localRowMap.keys.forEach((key) {
              //   if (key == 'server_rev_at') return;

              //   dynamic localProjectValue = localRowMap[key];
              //   dynamic serverProjectValue = serverRowMap[key];
              //   if (localProjectValue != serverProjectValue) {
              //     print(
              //         'rows id "${localRowMap['id']}": field "${key}" changes from "${localProjectValue}" to "${serverProjectValue}"');
              //   }
              // });
            }
            await isar.crows.put(serverRow);
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for rows',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // ctables
    try {
      //print('Subscribing to tables. Last server_rev: $ctablesLastServerRevAt');
      Stream<QueryResult> tablesSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
            subscription tablesSubscription($ctablesLastServerRevAt: timestamptz) {
              tables(where: {server_rev_at: {_gt: $ctablesLastServerRevAt}}) {
                id
                name
                label
                single_label
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
      '''),
          variables: {
            'ctablesLastServerRevAt': ctablesLastServerRevAt.toIso8601String()
          },
        ),
      );
      tablesSnapshotStreamSubscription =
          tablesSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'tables',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverCtablesData = (result.data?['tables'] ?? []);
        if (serverCtablesData.length == 0) return;

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
            if (localCtable is Ctable) {
              // unfortunately need to delete
              // because when updating this is not registered and ui does not update
              await isar.ctables.delete(localCtable.isarId ?? 0);

              Map<String, dynamic> localTableMap = localCtable.toMap();
              Map<String, dynamic> serverTableMap = serverCtable.toMap();

              localTableMap.keys.forEach((key) {
                if (key == 'server_rev_at') return;

                dynamic localProjectValue = localTableMap[key];
                dynamic serverProjectValue = serverTableMap[key];
                if (localProjectValue != serverProjectValue) {
                  print(
                      'tables id "${localTableMap['id']}": field "${key}" changes from "${localProjectValue}" to "${serverProjectValue}"');
                }
              });
            }
            await isar.ctables.put(serverCtable);
          });
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for tables',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // users
    try {
      // print(
      //     'Subscribing to users. Last server_rev: $usersLastServerRevAt');
      Stream<QueryResult> usersSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {
            'usersLastServerRevAt': usersLastServerRevAt.toIso8601String()
          },
        ),
      );
      usersSnapshotStreamSubscription =
          usersSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'users',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverUsersData = (result.data?['users'] ?? []);
        if (serverUsersData.length == 0) return;

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
        'Error subscribing to server data for users',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // tileLayers
    try {
      // print(
      //     'Subscribing to tileLayers. Last server_rev: $tileLayersLastServerRevAt');
      Stream<QueryResult> tileLayersSubscription = graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
            subscription tileLayersSubscription($tileLayersLastServerRevAt: timestamptz) {
              tile_layers(where: {server_rev_at: {_gt: $tileLayersLastServerRevAt}}) {
                id
                label
                url_template
                subdomains
                max_zoom
                min_zoom
                opacity
                wms_base_url
                wms_format
                wms_layers
                wms_parameters
                wms_request
                wms_service
                wms_styles
                wms_transparent
                wms_version
                client_rev_at
                client_rev_by
                server_rev_at
                deleted
              }
            }
      '''),
          variables: {
            'tileLayersLastServerRevAt':
                tileLayersLastServerRevAt.toIso8601String()
          },
        ),
      );
      tileLayersSnapshotStreamSubscription =
          tileLayersSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'tileLayers',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverTileLayersData =
            (result.data?['tile_layers'] ?? []);
        if (serverTileLayersData.length == 0) return;

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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for widgets for fields',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // projectTileLayers
    try {
      // print(
      //     'Subscribing to projectTileLayers. Last server_rev: $projectTileLayersLastServerRevAt');
      Stream<QueryResult> projectTileLayersSubscription =
          graphqlClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
            subscription projectTileLayersSubscription($projectTileLayersLastServerRevAt: timestamptz) {
              project_tile_layers(where: {server_rev_at: {_gt: $projectTileLayersLastServerRevAt}}) {
                id
                project_id
                label
                ord
                active
                url_template
                subdomains
                max_zoom
                min_zoom
                opacity
                wms_base_url
                wms_format
                wms_layers
                wms_parameters
                wms_request
                wms_service
                wms_styles
                wms_transparent
                wms_version
                client_rev_at
                client_rev_by
                server_rev_at
                deleted
              }
            }
      '''),
          variables: {
            'projectTileLayersLastServerRevAt':
                projectTileLayersLastServerRevAt.toIso8601String()
          },
        ),
      );
      projectTileLayersSnapshotStreamSubscription =
          projectTileLayersSubscription.listen((result) async {
        checkForException(
          subscriptionName: 'projectTileLayers',
          exception: result.exception,
        );
        // update db
        List<dynamic> serverProjectTileLayersData =
            (result.data?['project_tile_layers'] ?? []);
        if (serverProjectTileLayersData.length == 0) return;

        List<ProjectTileLayer> serverProjectTileLayers = List.from(
          serverProjectTileLayersData.map((p) => ProjectTileLayer.fromJson(p)),
        );
        await isar.writeTxn((isar) async {
          await Future.forEach(serverProjectTileLayers,
              (ProjectTileLayer serverProjectTileLayer) async {
            ProjectTileLayer? localProjectTileLayer = await isar
                .projectTileLayers
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
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for widgets for fields',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // fieldTypes
    // try {
    //   print(
    //       'Subscribing to fieldTypes. Last server_rev: $fieldTypesLastServerRevAt');
    //   Stream<QueryResult> fieldTypesSubscription = wsClient.subscribe(
    //     SubscriptionOptions(
    //       document: gql(r'''
    //         subscription fieldTypesSubscription($fieldTypesLastServerRevAt: timestamptz) {
    //           field_types(where: {server_rev_at: {_gt: $fieldTypesLastServerRevAt}}) {
    //             value
    //             sort
    //             comment
    //             server_rev_at
    //             deleted
    //           }
    //         }
    //   '''),
    //       variables: {'fieldTypesLastServerRevAt': fieldTypesLastServerRevAt},
    //     ),
    //   );
    //   fieldTypesSnapshotStreamSubscription =
    //       fieldTypesSubscription.listen((result) async {
    //     if (result.exception != null) {
    //       print('exception from fieldTypesSubscription: ${result.exception}');
    //       // TODO: catch JWT: JWTExpired, then re-authorize
    //       Get.snackbar(
    //         'Error listening to server data for fieldTypes',
    //         result.exception.toString(),
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     }
    //     if (result.data?['fieldTypes']?.length != null) {
    //       // update db
    //       List<dynamic> serverFieldTypesData =
    //           (result.data?['field_types'] ?? []);
    //       List<FieldType> serverFieldTypes = List.from(
    //         serverFieldTypesData.map((p) => FieldType.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverFieldTypes,
    //             (FieldType serverFieldType) async {
    //           FieldType? localFieldType = await isar.fieldTypes
    //               .where()
    //               .valueEqualTo(serverFieldType.value)
    //               .findFirst();
    //           if (localFieldType != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.fieldTypes.delete(localFieldType.isarId ?? 0);
    //           }
    //           await isar.fieldTypes.put(serverFieldType);
    //         });
    //       });
    //     }
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for field types',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // optionTypes
    // try {
    //   print(
    //       'Subscribing to optionTypes. Last server_rev: $optionTypesLastServerRevAt');
    //   Stream<QueryResult> optionTypesSubscription = wsClient.subscribe(
    //     SubscriptionOptions(
    //       document: gql(r'''
    //         subscription optionTypesSubscription($optionTypesLastServerRevAt: timestamptz) {
    //           option_types(where: {server_rev_at: {_gt: $optionTypesLastServerRevAt}}) {
    //             id
    //             value
    //             save_id
    //             sort
    //             comment
    //             server_rev_at
    //             deleted
    //           }
    //         }
    //   '''),
    //       variables: {'optionTypesLastServerRevAt': optionTypesLastServerRevAt},
    //     ),
    //   );
    //   optionTypesSnapshotStreamSubscription =
    //       optionTypesSubscription.listen((result) async {
    //     if (result.exception != null) {
    //       print('exception from optionTypesSubscription: ${result.exception}');
    //       // TODO: catch JWT: JWTExpired, then re-authorize
    //       Get.snackbar(
    //         'Error listening to server data for optionTypes',
    //         result.exception.toString(),
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     }
    //     if (result.data?['optionTypes']?.length != null) {
    //       // update db
    //       List<dynamic> serverOptionTypesData =
    //           (result.data?['option_types'] ?? []);
    //       List<OptionType> serverOptionTypes = List.from(
    //         serverOptionTypesData.map((p) => OptionType.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverOptionTypes,
    //             (OptionType serverOptionType) async {
    //           OptionType? localOptionType = await isar.optionTypes
    //               .where()
    //               .valueEqualTo(serverOptionType.value)
    //               .findFirst();
    //           if (localOptionType != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.optionTypes.delete(localOptionType.isarId ?? 0);
    //           }
    //           await isar.optionTypes.put(serverOptionType);
    //         });
    //       });
    //     }
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for option types',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // relTypes
    // try {
    //   print(
    //       'Subscribing to relTypes. Last server_rev: $relTypesLastServerRevAt');
    //   Stream<QueryResult> relTypesSubscription = wsClient.subscribe(
    //     SubscriptionOptions(
    //       document: gql(r'''
    //         subscription relTypesSubscription($relTypesLastServerRevAt: timestamptz) {
    //           rel_types(where: {server_rev_at: {_gt: $relTypesLastServerRevAt}}) {
    //             value
    //             sort
    //             comment
    //             server_rev_at
    //             deleted
    //           }
    //         }
    //   '''),
    //       variables: {'relTypesLastServerRevAt': relTypesLastServerRevAt},
    //     ),
    //   );
    //   relTypesSnapshotStreamSubscription =
    //       relTypesSubscription.listen((result) async {
    //     if (result.exception != null) {
    //       print('exception from relTypesSubscription: ${result.exception}');
    //       // TODO: catch JWT: JWTExpired, then re-authorize
    //       Get.snackbar(
    //         'Error listening to server data for relTypes',
    //         result.exception.toString(),
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     }
    //     if (result.data?['relTypes']?.length != null) {
    //       // update db
    //       List<dynamic> serverRelTypesData = (result.data?['rel_types'] ?? []);
    //       List<RelType> serverRelTypes = List.from(
    //         serverRelTypesData.map((p) => RelType.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverRelTypes, (RelType serverRelType) async {
    //           RelType? localRelType = await isar.relTypes
    //               .where()
    //               .valueEqualTo(serverRelType.value)
    //               .findFirst();
    //           if (localRelType != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.relTypes.delete(localRelType.isarId ?? 0);
    //           }
    //           await isar.relTypes.put(serverRelType);
    //         });
    //       });
    //     }
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for rel types',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // roleTypes
    // try {
    //   print(
    //       'Subscribing to roleTypes. Last server_rev: $roleTypesLastServerRevAt');
    //   Stream<QueryResult> roleTypesSubscription = wsClient.subscribe(
    //     SubscriptionOptions(
    //       document: gql(r'''
    //         subscription roleTypesSubscription($roleTypesLastServerRevAt: timestamptz) {
    //           role_types(where: {server_rev_at: {_gt: $roleTypesLastServerRevAt}}) {
    //             value
    //             sort
    //             comment
    //             server_rev_at
    //             deleted
    //           }
    //         }
    //   '''),
    //       variables: {'roleTypesLastServerRevAt': roleTypesLastServerRevAt},
    //     ),
    //   );
    //   roleTypesSnapshotStreamSubscription =
    //       roleTypesSubscription.listen((result) async {
    //     if (result.exception != null) {
    //       print('exception from roleTypesSubscription: ${result.exception}');
    //       // TODO: catch JWT: JWTExpired, then re-authorize
    //       Get.snackbar(
    //         'Error listening to server data for roletypes',
    //         result.exception.toString(),
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     }
    //     if (result.data?['roletypes']?.length != null) {
    //       // update db
    //       List<dynamic> serverRoleTypesData =
    //           (result.data?['role_types'] ?? []);
    //       List<RoleType> serverRoleTypes = List.from(
    //         serverRoleTypesData.map((p) => RoleType.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverRoleTypes,
    //             (RoleType serverRoleType) async {
    //           RoleType? localRoleType = await isar.roleTypes
    //               .where()
    //               .valueEqualTo(serverRoleType.value)
    //               .findFirst();
    //           if (localRoleType != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.roleTypes.delete(localRoleType.isarId ?? 0);
    //           }
    //           await isar.roleTypes.put(serverRoleType);
    //         });
    //       });
    //     }
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for role types',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // widgetTypes
    // try {
    //   print(
    //       'Subscribing to widgetTypes. Last server_rev: $widgetTypesLastServerRevAt');
    //   Stream<QueryResult> widgetTypesSubscription = wsClient.subscribe(
    //     SubscriptionOptions(
    //       document: gql(r'''
    //         subscription widgetTypesSubscription($widgetTypesLastServerRevAt: timestamptz) {
    //           widget_types(where: {server_rev_at: {_gt: $widgetTypesLastServerRevAt}}) {
    //             value
    //             needs_list
    //             sort
    //             comment
    //             server_rev_at
    //             deleted
    //           }
    //         }
    //   '''),
    //       variables: {'widgetTypesLastServerRevAt': widgetTypesLastServerRevAt},
    //     ),
    //   );
    //   widgetTypesSnapshotStreamSubscription =
    //       widgetTypesSubscription.listen((result) async {
    //     if (result.exception != null) {
    //       print('exception from widgetTypesSubscription: ${result.exception}');
    //       // TODO: catch JWT: JWTExpired, then re-authorize
    //       Get.snackbar(
    //         'Error listening to server data for widgetTypes',
    //         result.exception.toString(),
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     }
    //     if (result.data?['widgetTypes']?.length != null) {
    //       // update db
    //       List<dynamic> serverWidgetTypesData =
    //           (result.data?['widget_types'] ?? []);
    //       List<WidgetType> serverWidgetTypes = List.from(
    //         serverWidgetTypesData.map((p) => WidgetType.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverWidgetTypes,
    //             (WidgetType serverWidgetType) async {
    //           WidgetType? localWidgetType = await isar.widgetTypes
    //               .where()
    //               .valueEqualTo(serverWidgetType.value)
    //               .findFirst();
    //           if (localWidgetType != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.widgetTypes.delete(localWidgetType.isarId ?? 0);
    //           }
    //           await isar.widgetTypes.put(serverWidgetType);
    //         });
    //       });
    //     }
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for widget types',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // widgetsForFields
    // try {
    //   print(
    //       'Subscribing to widgetsForFields. Last server_rev: $widgetsForFieldsLastServerRevAt');
    //   Stream<QueryResult> widgetsForFieldsSubscription = wsClient.subscribe(
    //     SubscriptionOptions(
    //       document: gql(r'''
    //         subscription widgetsForFieldsSubscription($widgetsForFieldsLastServerRevAt: timestamptz) {
    //           widgets_for_fields(where: {server_rev_at: {_gt: $widgetsForFieldsLastServerRevAt}}) {
    //             field_value
    //             widget_value
    //             server_rev_at
    //             deleted
    //           }
    //         }
    //   '''),
    //       variables: {
    //         'widgetsForFieldsLastServerRevAt': widgetsForFieldsLastServerRevAt
    //       },
    //     ),
    //   );
    //   widgetsForFieldsSnapshotStreamSubscription =
    //       widgetsForFieldsSubscription.listen((result) async {
    //     if (result.exception != null) {
    //       print(
    //           'exception from widgetsForFieldsSubscription: ${result.exception}');
    //       // TODO: catch JWT: JWTExpired, then re-authorize
    //       Get.snackbar(
    //         'Error listening to server data for widgetsForFields',
    //         result.exception.toString(),
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     }
    //     if (result.data?['widgetsForFields']?.length != null) {
    //       // update db
    //       List<dynamic> serverWidgetsForFieldsData =
    //           (result.data?['widgets_for_fields'] ?? []);
    //       List<WidgetsForField> serverWidgetsForFields = List.from(
    //         serverWidgetsForFieldsData.map((p) => WidgetsForField.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverWidgetsForFields,
    //             (WidgetsForField serverWidgetType) async {
    //           WidgetsForField? localWidgetType = await isar.widgetsForFields
    //               .where()
    //               .filter()
    //               .widgetValueEqualTo(serverWidgetType.widgetValue)
    //               .and()
    //               .fieldValueEqualTo(serverWidgetType.fieldValue)
    //               .findFirst();
    //           if (localWidgetType != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.widgetsForFields.delete(localWidgetType.isarId ?? 0);
    //           }
    //           await isar.widgetsForFields.put(serverWidgetType);
    //         });
    //       });
    //     }
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for widgets for fields',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    return;
  }
}
