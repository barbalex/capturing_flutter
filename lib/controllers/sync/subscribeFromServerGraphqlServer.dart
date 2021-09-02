import 'dart:async';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
import 'package:capturing/models/tileLayer.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:web_socket_channel/io.dart';

class ServerSubscriptionController {
  // see: https://github.com/zino-app/graphql-flutter/issues/902#issuecomment-847869946
  final HttpLink httpLink = HttpLink(wsGraphQlUri);
  final AuthController authController = Get.find<AuthController>();

  final Isar isar = Get.find<Isar>();
  final FirebaseStorage fbStorage = FirebaseStorage.instance;

  StreamSubscription<dynamic>? accountsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? fieldsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? fieldTypesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? filesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? optionTypesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? projectsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? projectUsersSnapshotStreamSubscription;
  StreamSubscription<dynamic>? rowsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? relTypesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? roleTypesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? tablesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? usersSnapshotStreamSubscription;
  StreamSubscription<dynamic>? widgetTypesSnapshotStreamSubscription;
  StreamSubscription<dynamic>? widgetsForFieldsSnapshotStreamSubscription;
  StreamSubscription<dynamic>? tileLayersSnapshotStreamSubscription;
  StreamSubscription<dynamic>? projectTileLayersSnapshotStreamSubscription;

  void dispose() {
    accountsSnapshotStreamSubscription?.cancel();
    fieldsSnapshotStreamSubscription?.cancel();
    fieldTypesSnapshotStreamSubscription?.cancel();
    filesSnapshotStreamSubscription?.cancel();
    optionTypesSnapshotStreamSubscription?.cancel();
    projectsSnapshotStreamSubscription?.cancel();
    projectUsersSnapshotStreamSubscription?.cancel();
    rowsSnapshotStreamSubscription?.cancel();
    relTypesSnapshotStreamSubscription?.cancel();
    roleTypesSnapshotStreamSubscription?.cancel();
    tablesSnapshotStreamSubscription?.cancel();
    usersSnapshotStreamSubscription?.cancel();
    widgetTypesSnapshotStreamSubscription?.cancel();
    widgetsForFieldsSnapshotStreamSubscription?.cancel();
    tileLayersSnapshotStreamSubscription?.cancel();
    projectTileLayersSnapshotStreamSubscription?.cancel();
  }

  ServerSubscriptionController() {
    //print('ServerSubscriptionController initiating');
    final AuthLink authLink = AuthLink(
      getToken: () => "Bearer ${authController.token}",
    );
    final WebSocketLink wsLink = WebSocketLink(
      wsGraphQlUri,
      config: SocketClientConfig(
        //inactivityTimeout: Duration(minutes: 30),
        //delayBetweenReconnectionAttempts: Duration(seconds: 1),
        //autoReconnect: true,
        initialPayload: () => {
          'X-Hasura-Role': 'user',
          'Authorization': 'Bearer ${authController.token}'
        },
        connect: (url, protocols) => IOWebSocketChannel.connect(
          url,
          protocols: protocols,
          headers: {
            'X-Hasura-Role': 'user',
            'Authorization': 'Bearer ${authController.token}'
          },
        ),
      ),
    );
    //print('subscribing, token: ${authController.token}');
    final link = Link.split(
        (request) => request.isSubscription, wsLink, authLink.concat(httpLink));
    GraphQLClient wsClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );

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
    String? tileLayersLastServerRevAt = isar.ctileLayers
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';
    String? projectTileLayersLastServerRevAt = isar.projectTileLayers
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';

    // print(
    //     'ServerSubscriptionController, accountsLastServerRevAt: $accountsLastServerRevAt');
    // accounts
    try {
      print(
          'ServerSubscriptionController, will subscribe to accounts. accountsLastServerRevAt: $accountsLastServerRevAt');
      Stream<QueryResult> accountsSubscription = wsClient.subscribe(
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
          variables: {'accountsLastServerRevAt': accountsLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'accountsSubscription',
        ),
      );
      accountsSnapshotStreamSubscription =
          accountsSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from accountsSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for accounts',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['accounts']?.length != null) {
          // update db
          List<dynamic> serverAccountsData = (result.data?['accounts'] ?? []);
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
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for accounts',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // fields
    try {
      print(
          'ServerSubscriptionController, will subscribe to fields. fieldsLastServerRevAt: $fieldsLastServerRevAt');
      Stream<QueryResult> fieldsSubscription = wsClient.subscribe(
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
          variables: {'fieldsLastServerRevAt': fieldsLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'fieldsSubscription',
        ),
      );
      fieldsSnapshotStreamSubscription =
          fieldsSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from fieldsSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for fields',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['fields']?.length != null) {
          // update db
          List<dynamic> serverFieldsData = (result.data?['fields'] ?? []);
          List<Field> serverFields = List.from(
            serverFieldsData.map((p) => Field.fromJson(p)),
          );
          await isar.writeTxn((isar) async {
            await Future.forEach(serverFields, (Field serverField) async {
              Field? localField = await isar.fields
                  .where()
                  .idEqualTo(serverField.id)
                  .findFirst();
              if (localField != null) {
                // unfortunately need to delete
                // because when updating this is not registered and ui does not update
                await isar.fields.delete(localField.isarId ?? 0);
              }
              await isar.fields.put(serverField);
            });
          });
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for fields',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // fieldTypes
    try {
      print(
          'ServerSubscriptionController, will subscribe to fieldTypes. fieldTypesLastServerRevAt: $fieldTypesLastServerRevAt');
      Stream<QueryResult> fieldTypesSubscription = wsClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
            subscription fieldTypesSubscription($fieldTypesLastServerRevAt: timestamptz) {
              field_types(where: {server_rev_at: {_gt: $fieldTypesLastServerRevAt}}) {
                value
                sort
                comment
                server_rev_at
                deleted
              }
            }
      '''),
          variables: {'fieldTypesLastServerRevAt': fieldTypesLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'fieldTypesSubscription',
        ),
      );
      fieldTypesSnapshotStreamSubscription =
          fieldTypesSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from fieldTypesSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for fieldTypes',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['fieldTypes']?.length != null) {
          // update db
          List<dynamic> serverFieldTypesData =
              (result.data?['field_types'] ?? []);
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
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for field types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // files
    try {
      print(
          'ServerSubscriptionController, will subscribe to files. filesLastServerRevAt: $filesLastServerRevAt');
      Stream<QueryResult> filesSubscription = wsClient.subscribe(
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
          variables: {'filesLastServerRevAt': filesLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'filesSubscription',
        ),
      );
      filesSnapshotStreamSubscription =
          filesSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from filesSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for files',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['files']?.length != null) {
          // update db
          List<dynamic> serverFilesData = (result.data?['files'] ?? []);
          List<Cfile> serverFiles = List.from(
            serverFilesData.map((p) => Cfile.fromJson(p)),
          );
          await isar.writeTxn((isar) async {
            await Future.forEach(serverFiles, (Cfile serverFile) async {
              Cfile? localFile = await isar.cfiles
                  .where()
                  .idEqualTo(serverFile.id)
                  .findFirst();
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
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for files',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // optionTypes
    try {
      print(
          'ServerSubscriptionController, will subscribe to optionTypes. optionTypesLastServerRevAt: $optionTypesLastServerRevAt');
      Stream<QueryResult> optionTypesSubscription = wsClient.subscribe(
        SubscriptionOptions(
          document: gql(r'''
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
      '''),
          variables: {'optionTypesLastServerRevAt': optionTypesLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'optionTypesSubscription',
        ),
      );
      optionTypesSnapshotStreamSubscription =
          optionTypesSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from optionTypesSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for optionTypes',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['optionTypes']?.length != null) {
          // update db
          List<dynamic> serverOptionTypesData =
              (result.data?['option_types'] ?? []);
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
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for option types',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // projects
    try {
      print(
          'ServerSubscriptionController, will subscribe to projects. projectsLastServerRevAt: $projectsLastServerRevAt');
      Stream<QueryResult> projectsSubscription = wsClient.subscribe(
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
          variables: {'projectsLastServerRevAt': projectsLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'projectsSubscription',
        ),
      );
      projectsSnapshotStreamSubscription =
          projectsSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from projectsSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for projects',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['projects']?.length != null) {
          // update db
          List<dynamic> serverProjectsData = (result.data?['projects'] ?? []);
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
        }
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
      print(
          'Subscribing to projectUsers. LastServerRevAt: $projectUsersLastServerRevAt');
      Stream<QueryResult> projectUsersSubscription = wsClient.subscribe(
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
            'projectUsersLastServerRevAt': projectUsersLastServerRevAt
          },
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'projectUsersSubscription',
        ),
      );
      projectUsersSnapshotStreamSubscription =
          projectUsersSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from projectUsersSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for projectUsers',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['projectUsers']?.length != null) {
          // update db
          List<dynamic> serverProjectUsersData =
              (result.data?['project_users'] ?? []);
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
        }
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
      print(
          'ServerSubscriptionController, will subscribe to rows. rowsLastServerRevAt: $rowsLastServerRevAt');
      Stream<QueryResult> rowsSubscription = wsClient.subscribe(
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
          variables: {'rowsLastServerRevAt': rowsLastServerRevAt},
          fetchPolicy: FetchPolicy.noCache,
          operationName: 'rowsSubscription',
        ),
      );
      rowsSnapshotStreamSubscription = rowsSubscription.listen((result) async {
        if (result.exception != null) {
          print('exception from rowsSubscription: ${result.exception}');
          // TODO: catch JWTException, then re-authorize
          Get.snackbar(
            'Error listening to server data for rows',
            result.exception.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (result.data?['rows']?.length != null) {
          // update db
          List<dynamic> serverRowsData = (result.data?['rows'] ?? []);
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
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error subscribing to server data for rows',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // relTypes
    // try {
    //   gqlConnect.subscription(
    //     r'''
    //     subscription relTypesSubscription($relTypesLastServerRevAt: timestamptz) {
    //       rel_types(where: {server_rev_at: {_gt: $relTypesLastServerRevAt}}) {
    //         value
    //         sort
    //         comment
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'relTypesLastServerRevAt': relTypesLastServerRevAt,
    //     },
    //     key: 'relTypesSubscription',
    //   ).then((snapshot) {
    //     relTypesSnapshotStreamSubscription = snapshot.listen((data) async {
    //       List<dynamic> serverRelTypesData = (data['rel_types'] ?? []);
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
    //     });
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
    //   gqlConnect.subscription(
    //     r'''
    //     subscription roleTypesSubscription($roleTypesLastServerRevAt: timestamptz) {
    //       role_types(where: {server_rev_at: {_gt: $roleTypesLastServerRevAt}}) {
    //         value
    //         sort
    //         comment
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'roleTypesLastServerRevAt': roleTypesLastServerRevAt,
    //     },
    //     key: 'roleTypesSubscription',
    //   ).then((snapshot) {
    //     roleTypesSnapshotStreamSubscription = snapshot.listen((data) async {
    //       List<dynamic> serverRoleTypesData = (data['role_types'] ?? []);
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
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for role types',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // ctables
    // try {
    //   gqlConnect.subscription(
    //     r'''
    //     subscription tablesSubscription($ctablesLastServerRevAt: timestamptz) {
    //       tables(where: {server_rev_at: {_gt: $ctablesLastServerRevAt}}) {
    //         id
    //         name
    //         label
    //         single_label
    //         ord
    //         label_fields
    //         label_fields_separator
    //         rel_type
    //         option_type
    //         project_id
    //         parent_id
    //         client_rev_at
    //         client_rev_by
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'ctablesLastServerRevAt': ctablesLastServerRevAt,
    //     },
    //     key: 'tablesSubscription',
    //   ).then((snapshot) {
    //     tablesSnapshotStreamSubscription = snapshot.listen((data) async {
    //       List<dynamic> serverCtablesData = (data['tables'] ?? []);
    //       //print('updateFromServer: serverCtablesData: $serverCtablesData');
    //       List<Ctable> serverCtables = List.from(
    //         serverCtablesData.map((p) => Ctable.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverCtables, (Ctable serverCtable) async {
    //           Ctable? localCtable = await isar.ctables
    //               .where()
    //               .idEqualTo(serverCtable.id)
    //               .findFirst();
    //           if (localCtable != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.ctables.delete(localCtable.isarId ?? 0);
    //           }
    //           await isar.ctables.put(serverCtable);
    //         });
    //       });
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for tables',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // users
    // try {
    //   gqlConnect.subscription(
    //     r'''
    //     subscription usersSubscription($usersLastServerRevAt: timestamptz) {
    //       users(where: {server_rev_at: {_gt: $usersLastServerRevAt}}) {
    //         id
    //         name
    //         email
    //         account_id
    //         auth_id
    //         client_rev_at
    //         client_rev_by
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'usersLastServerRevAt': usersLastServerRevAt,
    //     },
    //     key: 'usersSubscription',
    //   ).then((snapshot) {
    //     usersSnapshotStreamSubscription = snapshot.listen((data) async {
    //       List<dynamic> serverUsersData = (data['users'] ?? []);
    //       List<CUser> serverUsers = List.from(
    //         serverUsersData.map((p) => CUser.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverUsers, (CUser serverUser) async {
    //           CUser? localUser = await isar.cUsers
    //               .where()
    //               .idEqualTo(serverUser.id)
    //               .findFirst();
    //           if (localUser != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.cUsers.delete(localUser.isarId ?? 0);
    //           }
    //           await isar.cUsers.put(serverUser);
    //         });
    //       });
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for users',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // widgetTypes
    // try {
    //   gqlConnect.subscription(
    //     r'''
    //     subscription widgetTypesSubscription($widgetTypesLastServerRevAt: timestamptz) {
    //       widget_types(where: {server_rev_at: {_gt: $widgetTypesLastServerRevAt}}) {
    //         value
    //         needs_list
    //         sort
    //         comment
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'widgetTypesLastServerRevAt': widgetTypesLastServerRevAt,
    //     },
    //     key: 'widgetTypesSubscription',
    //   ).then((snapshot) {
    //     widgetTypesSnapshotStreamSubscription = snapshot.listen((data) async {
    //       List<dynamic> serverWidgetTypesData = (data['widget_types'] ?? []);
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
    //     });
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
    //   gqlConnect.subscription(
    //     r'''
    //     subscription widgetsForFieldsSubscription($widgetsForFieldsLastServerRevAt: timestamptz) {
    //       widgets_for_fields(where: {server_rev_at: {_gt: $widgetsForFieldsLastServerRevAt}}) {
    //         field_value
    //         widget_value
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'widgetsForFieldsLastServerRevAt': widgetsForFieldsLastServerRevAt
    //     },
    //     key: 'widgetsForFieldsSubscription',
    //   ).then((snapshot) {
    //     widgetsForFieldsSnapshotStreamSubscription =
    //         snapshot.listen((data) async {
    //       List<dynamic> serverWidgetsForFieldsData =
    //           (data['widgets_for_fields'] ?? []);
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
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for widgets for fields',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // tileLayers
    // try {
    //   gqlConnect.subscription(
    //     r'''
    //     subscription tileLayersSubscription($tileLayersLastServerRevAt: timestamptz) {
    //       tile_layers(where: {server_rev_at: {_gt: $tileLayersLastServerRevAt}}) {
    //         id
    //         label
    //         url_template
    //         subdomains
    //         max_zoom
    //         min_zoom
    //         opacity
    //         wms_base_url
    //         wms_format
    //         wms_layers
    //         wms_parameters
    //         wms_request
    //         wms_service
    //         wms_styles
    //         wms_transparent
    //         wms_version
    //         client_rev_at
    //         client_rev_by
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {'tileLayersLastServerRevAt': tileLayersLastServerRevAt},
    //     key: 'tileLayersSubscription',
    //   ).then((snapshot) {
    //     tileLayersSnapshotStreamSubscription = snapshot.listen((data) async {
    //       List<dynamic> serverTileLayersData = (data['tile_layers'] ?? []);
    //       List<CtileLayer> serverTileLayers = List.from(
    //         serverTileLayersData.map((p) => CtileLayer.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverTileLayers,
    //             (CtileLayer serverTileLayer) async {
    //           CtileLayer? localTileLayer = await isar.ctileLayers
    //               .where()
    //               .filter()
    //               .idEqualTo(serverTileLayer.id)
    //               .findFirst();
    //           if (localTileLayer != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.ctileLayers.delete(localTileLayer.isarId ?? 0);
    //           }
    //           await isar.ctileLayers.put(serverTileLayer);
    //         });
    //       });
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Error subscribing to server data for widgets for fields',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }

    // projectTileLayers
    // try {
    //   gqlConnect.subscription(
    //     r'''
    //     subscription projectTileLayersSubscription($projectTileLayersLastServerRevAt: timestamptz) {
    //       project_tile_layers(where: {server_rev_at: {_gt: $projectTileLayersLastServerRevAt}}) {
    //         id
    //         project_id
    //         label
    //         ord
    //         active
    //         url_template
    //         subdomains
    //         max_zoom
    //         min_zoom
    //         opacity
    //         wms_base_url
    //         wms_format
    //         wms_layers
    //         wms_parameters
    //         wms_request
    //         wms_service
    //         wms_styles
    //         wms_transparent
    //         wms_version
    //         client_rev_at
    //         client_rev_by
    //         server_rev_at
    //         deleted
    //       }
    //     }

    //   ''',
    //     variables: {
    //       'projectTileLayersLastServerRevAt': projectTileLayersLastServerRevAt
    //     },
    //     key: 'projectTileLayersSubscription',
    //   ).then((snapshot) {
    //     projectTileLayersSnapshotStreamSubscription =
    //         snapshot.listen((data) async {
    //       List<dynamic> serverProjectTileLayersData =
    //           (data['project_tile_layers'] ?? []);
    //       List<ProjectTileLayer> serverProjectTileLayers = List.from(
    //         serverProjectTileLayersData
    //             .map((p) => ProjectTileLayer.fromJson(p)),
    //       );
    //       await isar.writeTxn((isar) async {
    //         await Future.forEach(serverProjectTileLayers,
    //             (ProjectTileLayer serverProjectTileLayer) async {
    //           ProjectTileLayer? localProjectTileLayer = await isar
    //               .projectTileLayers
    //               .where()
    //               .filter()
    //               .idEqualTo(serverProjectTileLayer.id)
    //               .findFirst();
    //           if (localProjectTileLayer != null) {
    //             // unfortunately need to delete
    //             // because when updating this is not registered and ui does not update
    //             await isar.projectTileLayers
    //                 .delete(localProjectTileLayer.isarId ?? 0);
    //           }
    //           await isar.projectTileLayers.put(serverProjectTileLayer);
    //         });
    //       });
    //     });
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
    // });}
  }
}
