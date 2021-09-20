import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:get/get.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/row.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:validators/validators.dart' as validator;
import 'controllers/auth.dart';

// store values that shall be saved between restarts of the app
// need to be added to the store model and written/fetched from there
// (for instance in main.dart)

final authController = AuthController().obs;

final defaultLocale = ''.obs;

final storeInitialized = false.obs;
final editingProject = ''.obs;
bool get editingStructure => editingProject.value != '';

final activeUserHasAccount = false.obs;
final activeUserEmail = ''.obs;
// TODO: activeCUser not yet used? maybe bad idea
// because of the CUser call
final activeCUser = CUser().obs;

// navigation is managed via this url
// using Get.toNamed
final url = <String>[].obs;

final largeLayoutTreeColumnSize = 300.obs;

final activeLayers = <String>[].obs;
final mapEditing = false.obs;
final crsList = <int>[
  2056,
  3034,
  3035,
  4326,
  4839,
  5243,
  31287,
].obs;

// ensure not to tap a url element that does not exist
// so always check url.length
String? get activeProjectId {
  if (url.length < 2) return null;
  if (url[0] != '/projects/') return null;
  if (validator.isUUID(url[1])) return url[1];
  return null;
}

Project? get activeProject {
  final Isar isar = Get.find<Isar>();
  return isar.projects.where().idEqualTo(activeProjectId ?? '').findFirstSync();
}

mayEditByProject(Project project) {
  final Isar isar = Get.find<Isar>();
  String? activeUserAccount = activeCUser.value.accountId;
  String? projectAccount = project.accountId;
  bool activeUserIsAccountOwner =
      activeUserAccount != null && activeUserAccount == projectAccount;
  String? userRoleInProject = isar.projectUsers
      .where()
      .filter()
      .projectIdEqualTo(project.id)
      .and()
      .userEmailEqualTo(activeUserEmail.value)
      .roleProperty()
      .findFirstSync();
  bool activeUserIsProjectManager = userRoleInProject == 'project_manager';
  return activeUserIsAccountOwner || activeUserIsProjectManager;
}

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

  int lastTablesFolderIndex = url.lastIndexOf('/tables/');
  int childIndex = lastTablesFolderIndex + 1;
  bool hasChild = url.length > childIndex;
  String? child = hasChild ? url[childIndex] : null;
  bool hasUuidChild = child != null ? validator.isUUID(child) : false;
  if (hasUuidChild) return child;

  List<String> urlCopied = [...url];
  // need to get previous tables folder
  urlCopied.removeRange(lastTablesFolderIndex, urlCopied.length - 1);
  if (!urlCopied.contains('/tables/')) return null;

  lastTablesFolderIndex = urlCopied.lastIndexOf('/tables/');
  childIndex = lastTablesFolderIndex + 1;
  hasChild = urlCopied.length > childIndex;
  child = hasChild ? urlCopied[childIndex] : null;
  hasUuidChild = child != null ? validator.isUUID(child) : false;
  if (hasUuidChild) return child;

  return null;
}

Ctable? get activeTable {
  final Isar isar = Get.find<Isar>();
  return isar.ctables.where().idEqualTo(activeTableId ?? '').findFirstSync();
}

String? get activeFieldId {
  // find last fields folder containing a field id
  if (!url.contains('/fields/')) return null;
  String lastFieldFolder = url.lastWhere((e) {
    if (e != '/fields/') return false;
    int childIndex = url.indexOf(e) + 1;
    bool hasChild = url.length > childIndex;
    if (!hasChild) return false;
    String child = url[childIndex];
    bool childIsUuid = validator.isUUID(child);
    return childIsUuid;
  }, orElse: () => '');
  if (lastFieldFolder == '') return null;
  String activeFieldId = url[url.indexOf(lastFieldFolder) + 1];
  return activeFieldId;
}
