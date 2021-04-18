import 'package:flutter/foundation.dart';

bool get isDev => kReleaseMode ? false : true;

String get graphQlUri => isDev
    ? 'http://localhost:8080/v1/graphql'
    : 'https://api.capturing.app/v1/graphql';

String get wsGraphQlUri => isDev
    ? 'ws://localhost:8080/v1/graphql'
    : 'wss://api.capturing.app/v1/graphql';

String get graphQlHealthUri => isDev
    ? 'http://localhost:8080/healthz'
    : 'https://api.capturing.app/healthz';
