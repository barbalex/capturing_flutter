import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:hasura_connect/hasura_connect.dart';

class GraphqlController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  HasuraConnect gqlConnect = HasuraConnect(graphQlUri);

  void initGraphql() async {
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

    print('graphqlUri: $graphQlUri');
    //print('wsGraphQlUri: $wsGraphQlUri');

    var r = await gqlConnect.query('''
      query allDataSubscription {
        projects {
          id
          label
          name
          account_id
        }
      }
      ''');
    print('graphqlController, result: $r');

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

    // TODO: token updates every hour > how to catch?
    // TODO: start subscriptions
    // TODO: start syncing
    //
    // Syncing concept without subscriptions
    //
    // 1 incoming
    // 1.1 per table
    //     fetch and process all data with server_rev_at > most recent server_rev_at
    //     on startup (subscriptions: on every change)
    //
    // 2 Outgoing, when local object is edited:
    // 2.1 Write operation into locally saved pending operations collection in isar
    //     There is a SINGLE array: need to keep sequence of operations!
    //     Also: Every operation contains the data at the time the operation occured: to never break references.
    //     Every edit is an upsert. Deletion is handled by updating the "deleted" field.
    //     So: pending operations array is array of objects with fields: "table", "id" and "data".
    //     Can I have a dynamic map in the data field?
    //     Versioned tables: New version is written to revision table. Type is always insert.
    //     Unversioned tables: write directly to table.
    // 2.2 Try to immediately execute all pending operations.
    // 2.3 Every successfull operation is removed from the pending_operations array.
    // 2.3 Retry on:
    //     - startup
    //     - next edit
    //     - connection change (https://stackoverflow.com/a/49648870/712005)
    //       Check for connection + availability of healthz on connection change
  }
}
