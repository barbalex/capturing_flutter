import 'dart:async';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/sync/dbOperations/index.dart';
import 'package:capturing/controllers/sync/fileOperations/index.dart';
import 'package:capturing/controllers/sync/subscribeFromServerGraphqlServer.dart';
import 'package:capturing/controllers/sync/queryFromServer.dart';
import 'package:capturing/controllers/sync/updateFromServer.dart';
import 'package:capturing/controllers/sync/tokenInterceptor.dart';

class SyncController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final Isar isar = Get.find<Isar>();
  StreamSubscription<void>? dbOperationsStreamSubscription;
  StreamSubscription<void>? fileOperationsStreamSubscription;
  late DbOperationsController dbOperationsController;
  late ServerQueryController serverQueryController;
  late UpdateFromServerController updateFromServerController;
  late FileOperationsController fileOperationsController;

  HasuraConnect gqlConnect = HasuraConnect(
    graphQlUri,
    headers: {'X-Hasura-Role': 'user'},
    interceptors: [TokenInterceptor()],
  );
  HasuraConnect wsConnect = HasuraConnect(
    wsGraphQlUri,
    headers: {'X-Hasura-Role': 'user'},
    interceptors: [TokenInterceptor()],
  );

  void init() async {
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
    //print('graphQlUri: $graphQlUri');

    // Syncing concept without subscriptions
    //
    // 1 incoming
    // 1.1 Send pending operations first
    //     Need server to solve conflicts
    dbOperationsController = DbOperationsController(gqlConnect: gqlConnect);
    await dbOperationsController.run();
    // 1.2 per table
    //     fetch and process all data with server_rev_at > most recent server_rev_at ✓
    //     on startup, maybe sync menu (subscriptions: on every change) ✓

    serverQueryController = ServerQueryController(gqlConnect: gqlConnect);
    dynamic result = await serverQueryController.fetch();

    updateFromServerController = UpdateFromServerController(result: result);
    await updateFromServerController.update();

    // turned off because of lots of issues with hasura_connect
    //ServerSubscriptionController(gqlConnect: wsConnect);
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
