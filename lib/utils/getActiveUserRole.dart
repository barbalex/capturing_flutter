import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/user.dart';

String? getActiveUserRole(String projectId) {
  final Isar isar = Get.find<Isar>();
  CUser? activeUser =
      isar.cUsers.filter().emailEqualTo(activeUserEmail.value).findFirstSync();
  String? role = activeUser?.getRoleForProject(projectId);
  return role;
}
