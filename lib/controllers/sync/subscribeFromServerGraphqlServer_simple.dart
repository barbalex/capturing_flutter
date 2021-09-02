import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/utils/constants.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:web_socket_channel/io.dart';

class ServerSubscriptionController {
  final HttpLink httpLink = HttpLink(wsGraphQlUri);
  final AuthController authController = Get.find<AuthController>();

  final Isar isar = Get.find<Isar>();

  ServerSubscriptionController() {
    final AuthLink authLink = AuthLink(
      getToken: () => "Bearer ${authController.token}",
    );
    final WebSocketLink wsLink = WebSocketLink(
      wsGraphQlUri,
      config: SocketClientConfig(
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
    final link = Link.split(
        (request) => request.isSubscription, wsLink, authLink.concat(httpLink));
    GraphQLClient wsClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );

    // fetch last time any project was revisioned server side
    String? fieldsLastServerRevAt = isar.fields
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirstSync() ??
        '1900-01-01T00:00:00+01:00';

    print(
        'ServerSubscriptionController, will subscribe to fields. fieldsLastServerRevAt: $fieldsLastServerRevAt');
    Stream<QueryResult> fieldsSubscription = wsClient.subscribe(
      SubscriptionOptions(
        document: gql(r'''
            subscription fieldsSubscription($fieldsLastServerRevAt: timestamptz) {
            #subscription fieldsSubscription {
              fields(where: {server_rev_at: {_gt: $fieldsLastServerRevAt}}) {
              #fields() {
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
    fieldsSubscription.listen((result) {
      print('fields from fieldsSubscription: ${result.data?['fields']}');
    });
  }
}
