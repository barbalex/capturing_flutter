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
int get activeTableLevelCount {
  List<String> urlToUse = [...url];
  // last children folder hat to be ignored
  urlToUse.removeLast();
  return url.where((e) => e == '/children/').length;
}

String? get parentTableId {
  if (activeTableLevelCount == 0) return null;
  int index = 1 + (activeTableLevelCount * 2);
  if (index < url.length) {
    return url[index];
  }
  return null;
}

String? get activeTableId {
  List<String> urlToUse = [...url];
  // last children folder hat to be ignored
  urlToUse.removeLast();
  int lastTableFolderIndex = urlToUse.lastIndexOf('/children/');
  if (lastTableFolderIndex == 0) return null;
  int lastTableIndex = lastTableFolderIndex + 1;
  if (lastTableIndex < url.length) {
    return url[lastTableIndex];
  }
  return null;
}

String? get activeChildId {
  int childIndex = url.indexOf('/children/');
  if (childIndex == -1) {
    // must be project
    childIndex = url.indexOf('/projects/');
  }
  return (childIndex + 1) < url.length ? url[childIndex + 1] : null;
}
