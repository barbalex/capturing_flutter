import 'package:get/get.dart';
import 'package:capturing/models/user.dart';

final editingProject = ''.obs;
final activeUserEmail = ''.obs;
final activeCUser = CUser().obs;
final activeUserHasAccount = false.obs;

// navigation is managed via this url
// using Get.toNamed
final url = <String>[].obs;
// ensure not to tap a url element that does not exist
// so always check url.length
String? get activeProjectId => url.length > 1 ? url[1] : null;
int get activeTableLevelCount => url.where((e) => e == '/tables/').length;
String? get activeTableId1 => activeTableLevelCount > 0 ? url[3] : null;
String? get activeTableId2 => activeTableLevelCount > 1 ? url[5] : null;
String? get activeTableId3 => activeTableLevelCount > 2 ? url[7] : null;
String? get activeTableId4 => activeTableLevelCount > 3 ? url[9] : null;
String? get activeTableId5 => activeTableLevelCount > 4 ? url[11] : null;
String? get parentTableId {
  if (activeTableLevelCount == 0) return null;
  int index = 1 + (activeTableLevelCount * 2);
  if (index < url.length) {
    return url[index];
  }
  return null;
}

String? get activeRowId => (url.indexOf('/rows/') + 1) < url.length
    ? url[url.indexOf('/rows/') + 1]
    : null;
String? get activeFieldId => (url.indexOf('/fields/') + 1) < url.length
    ? url[url.indexOf('/fields/') + 1]
    : null;
