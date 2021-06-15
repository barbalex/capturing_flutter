import 'package:flutter/foundation.dart';

bool get isDev => kReleaseMode ? false : true;

// magic address for local dev, see: https://github.com/Flutterando/hasura_connect/issues/7#issuecomment-539441669
// String get graphQlUri =>
//     isDev ? 'http://10.0.2.2:8080/v1/graphql' : 'https://api.capturing.app';
String get graphQlUri => 'https://api.capturing.app/v1/graphql';

String authUri = 'https://auth.capturing.app';

String get wsGraphQlUri =>
    isDev ? 'ws://10.0.2.2:8080/v1/graphql' : 'wss://api.capturing.app';

String get graphQlHealthUri => isDev
    ? 'http://localhost:8080/healthz'
    : 'https://api.capturing.app/healthz';
