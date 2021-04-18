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
    HasuraConnect wsConnect = HasuraConnect(wsGraphQlUri);

    print('graphqlUri: $graphQlUri');
    print('wsGraphQlUri: $wsGraphQlUri');

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

    Snapshot snapshot = await wsConnect.subscription('''
      subscription allDataSubscription {
        projects {
          id
          label
          name
          account_id
        }
      }
      ''');
    snapshot.listen((data) {
      print('graphqlController, data from subscription: $data');
    });
    // final AuthLink authLink = AuthLink(
    //   getToken: () => 'Bearer ${authController.token}',
    // );
    // TODO: token updates every hour > how to catch?
    // TODO: start subscriptions
    // TODO: start syncing
  }
}
