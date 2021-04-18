import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/authController.dart';

class GraphqlController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  Rx<GraphQLClient?> graphqlClient = Rx<GraphQLClient?>(null);

  Future<GraphQLClient> initGraphql() async {
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(graphQlUri);
    final WebSocketLink webSocketLink = WebSocketLink(wsGraphQlUri);
    final AuthLink authLink = AuthLink(
      getToken: () => 'Bearer ${authController.token}',
    );
    Link link = authLink.concat(httpLink);
    link = Link.split((request) => request.isSubscription, webSocketLink, link);
    final client = GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    );
    graphqlClient.value = client;
    return client;
    // TODO: token updates every hour > how to catch?
    // TODO: start subscriptions
    // TODO: start syncing
  }
}
