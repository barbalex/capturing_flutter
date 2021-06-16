import 'package:hasura_connect/hasura_connect.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart' as getX;

class TokenInterceptor extends Interceptor {
  final AuthController authController = getX.Get.find<AuthController>();

  @override
  Future<void> onConnected(HasuraConnect connect) async {}

  @override
  Future<void> onDisconnected() async {}

  @override
  Future onError(HasuraError request) async {
    return request;
  }

  @override
  Future<Request> onRequest(Request request) async {
    request.headers["Authorization"] = "Bearer ${authController.token}";
    return request;
  }

  @override
  Future onResponse(Response data) async {
    return data;
  }

  @override
  Future<void> onSubscription(Request request, Snapshot snapshot) async {}

  @override
  Future<void> onTryAgain(HasuraConnect connect) async {}
}
