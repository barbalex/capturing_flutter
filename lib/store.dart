import 'package:capturing/models/table.dart';
import 'package:get/get.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/row.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:validators/validators.dart' as validator;

final storeInitialized = false.obs;
final editingProject = ''.obs;
final activeUserHasAccount = false.obs;
final activeUserEmail = ''.obs;
// TODO: activeCUser not yet used? maybe bad idea
// because of the CUser call
final activeCUser = CUser().obs;

// navigation is managed via this url
// using Get.toNamed
final url = <String>[].obs;

final activeTileLayerFromStore = ''.obs;

// ensure not to tap a url element that does not exist
// so always check url.length
String? get activeProjectId {
  if (url.length < 2) return null;
  if (url[0] != '/projects/') return null;
  if (validator.isUUID(url[1])) return url[1];
  return null;
}

mayEdit(String projectId) =>
    editingProject.value == projectId && activeUserHasAccount.value;

String? get activeRowId {
  // find last rows folder containing a row id
  if (!url.contains('/rows/')) return null;
  String lastRowFolder = url.lastWhere((e) {
    if (e != '/rows/') return false;
    int childIndex = url.indexOf(e) + 1;
    bool hasChild = url.length > childIndex;
    if (!hasChild) return false;
    String child = url[childIndex];
    bool childIsUuid = validator.isUUID(child);
    return childIsUuid;
  }, orElse: () => '');
  if (lastRowFolder == '') return null;
  String activeRowId = url[url.indexOf(lastRowFolder) + 1];
  return activeRowId;
}

Crow? get activeRow {
  final Isar isar = Get.find<Isar>();
  return isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
}

String? get activeTableId {
  // find last table followed by uuid
  // and return the uuid
  // else: return null
  if (!url.contains('/tables/')) return null;
  String lastTableFolder = url.lastWhere((e) {
    if (e != '/tables/') return false;
    int childIndex = url.indexOf(e) + 1;
    bool hasChild = url.length > childIndex;
    if (!hasChild) return false;
    String child = url[childIndex];
    bool childIsUuid = validator.isUUID(child);
    return childIsUuid;
  }, orElse: () => '');
  if (lastTableFolder == '') return null;
  String activeTableId = url[url.indexOf(lastTableFolder) + 1];
  return activeTableId;
}

Ctable? get activeTable {
  final Isar isar = Get.find<Isar>();
  return isar.ctables.where().idEqualTo(activeTableId ?? '').findFirstSync();
}
