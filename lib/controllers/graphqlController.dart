import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/authController.dart';

class GraphqlController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  Rx<GraphQLClient?> graphqlClient = Rx<GraphQLClient?>(null);

  @override
  void onInit() {
    super.onInit();
    initGraphql();
    // should re-init when token changes
    ever(authController.token, (_) {
      print('graphql controller: ever token, token: $_');
      // TODO: should re-init?
    });
  }

  void initGraphql() async {
    // TODO:
    // initialize graphql
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(graphQlUri);
    final AuthLink authLink = AuthLink(
      getToken: () => 'Bearer ${authController.token}',
    );
    final Link link = authLink.concat(httpLink);
    graphqlClient.value = GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    );
    // TODO: token updates every hour > how to catch?
    // start subscriptions
    // start syncing}
  }
}
