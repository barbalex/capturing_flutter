import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:hasura_connect/hasura_connect.dart';

class GraphqlController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  Rx<HasuraConnect> hasuraConnect =
      Rx<HasuraConnect>(HasuraConnect(graphQlUri));

  void initGraphql() async {
    print('graphqlUri: $graphQlUri');
    var r = await hasuraConnect.value.query('''
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
    // final AuthLink authLink = AuthLink(
    //   getToken: () => 'Bearer ${authController.token}',
    // );
    // TODO: token updates every hour > how to catch?
    // TODO: start subscriptions
    // TODO: start syncing
  }
}
