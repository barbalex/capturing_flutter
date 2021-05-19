import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

bool doesActiveUserHaveAccount() {
  final Isar isar = Get.find<Isar>();
  String? accountId = isar.cUsers
      .where()
      .filter()
      .emailEqualTo(activeUserEmail.value)
      .accountIdProperty()
      .findFirstSync();
  return accountId != null;
}
