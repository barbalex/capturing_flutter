import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/sync/dbOperations/index.dart';
import 'package:capturing/controllers/sync/fileOperations/index.dart';
import 'package:capturing/controllers/sync/fetchFromServer.dart';
import 'package:capturing/controllers/sync/updateFromServer.dart';

class SyncController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  HasuraConnect gqlConnect = HasuraConnect(graphQlUri);
  final Isar isar = Get.find<Isar>();

  void init() async {
    // HasuraConnect wsConnect = HasuraConnect(wsGraphQlUri,
    //     headers: {'authorization': 'Bearer ${authController.token}'});
    //HasuraConnect wsConnect = HasuraConnect(wsGraphQlUri);

    // need to refresh token when it expires
    // use interceptor, see:
    // https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-732187377
    //
    // the following is using this solution: https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-669650467
    // but does not work?
    // HasuraConnect gqlConnect = HasuraConnect(graphQlUri, headers: {
    //   "X-Hasura-Role": "user",
    // }, token: (isError) async {
    //   final token = await authController.getIdToken();
    //   return "Bearer ${token}";
    // });

    // TODO: token updates every hour > how to catch?
    // TODO: start subscriptions
    // TODO: start syncing

    // Syncing concept without subscriptions
    //
    // 1 incoming
    // 1.1 Send pending operations first
    //     Need server to solve conflicts
    DbOperationsController dbOperationsController =
        DbOperationsController(gqlConnect: gqlConnect);
    await dbOperationsController.run();
    // 1.2 per table
    //     fetch and process all data with server_rev_at > most recent server_rev_at ✓
    //     on startup, maybe sync menu (subscriptions: on every change) ✓
    ServerFetchController serverFetchController =
        ServerFetchController(gqlConnect: gqlConnect);
    dynamic result = await serverFetchController.fetch();

    UpdateFromServerController updateFromServerController =
        UpdateFromServerController(result: result);
    await updateFromServerController.update();

    // TODO: fetch every file that has no local_path
    // or that was edited since last sync
    // i.e.: start fileSyncController

    // 2 Outgoing, when local object is edited:
    // 2.1 Write operation into locally saved pending operations collection in isar
    //     There is a SINGLE array: need to keep sequence of operations!
    //     Also: Every operation contains the data at the time the operation occured: to never break references.
    //     Every edit is an upsert. Deletion is handled by updating the "deleted" field.
    //     So: pending operations array is array of objects with fields: "table" and "data". ✓
    //     Versioned tables: New version is written to revision table. Type is always insert.
    //     Unversioned tables: write directly to table. ✓
    // 2.2 Try to immediately execute all pending operations ✓
    isar.dbOperations.watchLazy().listen((_) {
      dbOperationsController.run();
    });
    // same for files
    FileOperationsController fileOperationsController =
        FileOperationsController();
    await dbOperationsController.run();
    isar.fileOperations.watchLazy().listen((_) {
      fileOperationsController.run();
    });
    // 2.3 Every successfull operation is removed from the pending_operations array. ✓
    // 2.3 Retry on:
    //     - startup ✓
    //     - next edit ✓
    //     - connection change (https://stackoverflow.com/a/49648870/712005)
    //       Check for connection + availability of healthz on connection change
  }
}
