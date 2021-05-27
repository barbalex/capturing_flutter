import 'package:get/get.dart';
import 'package:capturing/models/user.dart';

final editingProject = ''.obs;
final activeUserHasAccount = false.obs;
final activeUserEmail = ''.obs;
// TODO: activeCUser not yet used? maybe bad idea
// because of the CUser call
final activeCUser = CUser().obs;

// navigation is managed via this url
// using Get.toNamed
final url = <String>[].obs;
// ensure not to tap a url element that does not exist
// so always check url.length
String? get activeProjectId => url.length > 1 ? url[1] : null;

mayEdit(String projectId) {
  return editingProject.value == projectId && activeUserHasAccount.value;
}
