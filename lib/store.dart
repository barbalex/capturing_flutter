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
int get activeTableLevelCount => url.where((e) => e == '/tables/').length;
String? get parentTableId {
  if (activeTableLevelCount == 0) return null;
  int index = 1 + (activeTableLevelCount * 2);
  if (index < url.length) {
    return url[index];
  }
  return null;
}

String? get activeTableId {
  int lastTableFolderIndex = url.lastIndexOf('/tables/');
  if (lastTableFolderIndex == 0) return null;
  int lastTableIndex = url.lastIndexOf('/tables/') + 1;
  if (lastTableIndex < url.length) {
    return url[lastTableIndex];
  }
  return null;
}

String? get activeRowId => (url.indexOf('/rows/') + 1) < url.length
    ? url[url.indexOf('/rows/') + 1]
    : null;
String? get activeFieldId => (url.indexOf('/fields/') + 1) < url.length
    ? url[url.indexOf('/fields/') + 1]
    : null;
