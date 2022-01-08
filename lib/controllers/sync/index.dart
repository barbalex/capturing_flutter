import 'dart:async';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isar/isar.dart';
import 'package:capturing/controllers/sync/dbOperations/index.dart';
import 'package:capturing/controllers/sync/fileOperations/index.dart';
import 'package:capturing/controllers/sync/subscribeFromServer.dart';
import 'package:capturing/controllers/sync/queryNonSyncedFromServer.dart';
import 'package:capturing/controllers/sync/updateNonSyncedFromServer.dart';
import 'package:capturing/models/fileOperation.dart';
import 'package:capturing/models/dbOperation.dart';

class SyncController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final Isar isar = Get.find<Isar>();
  StreamSubscription<void>? dbOperationsStreamSubscription;
  StreamSubscription<void>? fileOperationsStreamSubscription;
  late DbOperationsController dbOperationsController;
  late ServerQueryNonSyncedController serverQueryController;
  late UpdateNonSyncedFromServerController updateFromServerController;
  late FileOperationsController fileOperationsController;

  void init() async {
    // TODO: token updates every hour > how to catch?

    // Syncing concept without subscriptions
    //
    // 1 incoming
    // 1.1 Send pending operations first
    //     Need server to solve conflicts
    dbOperationsController = DbOperationsController();
    await dbOperationsController.run();
    // 1.2 per table
    //     fetch and process all data with server_rev_at > most recent server_rev_at ✓
    //     on startup, maybe sync menu (subscriptions: on every change) ✓

    print('SyncController, ServerQueryNonSyncedController will be called');
    serverQueryController = ServerQueryNonSyncedController();
    print('SyncController, ServerQueryNonSyncedController will fetch');
    QueryResult result = await serverQueryController.fetch();

    print('SyncController, UpdateNonSyncedFromServerController will be called');
    updateFromServerController =
        UpdateNonSyncedFromServerController(result: result);
    print('SyncController, UpdateNonSyncedFromServerController will update');
    await updateFromServerController.update();

    print('SyncController, ServerSubscriptionController will be called');
    ServerSubscriptionController();

    // same for files
    fileOperationsController = FileOperationsController();
    await fileOperationsController.run();

    // 2 Outgoing, when local object is edited:
    // 2.1 Write operation into locally saved pending operations collection in isar
    //     There is a SINGLE array: need to keep sequence of operations!
    //     Also: Every operation contains the data at the time the operation occured: to never break references.
    //     Every edit is an upsert. Deletion is handled by updating the "deleted" field.
    //     So: pending operations array is array of objects with fields: "table" and "data". ✓
    //     Versioned tables: New version is written to revision table. Type is always insert.
    //     Unversioned tables: write directly to table. ✓
    // 2.2 Try to immediately execute all pending operations ✓
    dbOperationsStreamSubscription = isar.dbOperations.watchLazy().listen((_) {
      dbOperationsController.run();
    });
    // same for files
    fileOperationsStreamSubscription =
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dbOperationsStreamSubscription?.cancel();
    fileOperationsStreamSubscription?.cancel();
  }
}
