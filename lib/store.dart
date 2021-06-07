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
// ensure not to tap a url element that does not exist
// so always check url.length
String? get activeProjectId {
  if (url.length < 2) return null;
  if (url[0] != '/projects/') return null;
  return url[1];
}

mayEdit(String projectId) =>
    editingProject.value == projectId && activeUserHasAccount.value;

String? get activeRowId {
  // find last rows folder containing a row id
  if (!url.contains('/rows/')) return null;
  List<String> urlCopied = [...url];
  String? lastRowFolder =
      urlCopied.lastWhere((e) => e == '/rows/', orElse: null);
  // ignore: unnecessary_null_comparison
  if (lastRowFolder == null) return null;
  int indexOfLastRowFolder = urlCopied.indexOf(lastRowFolder);
  if (urlCopied.length > indexOfLastRowFolder + 1) {
    return urlCopied[indexOfLastRowFolder + 1];
  }
  // shorten the url
  urlCopied.length = indexOfLastRowFolder;
  // look if there is a parent row
  lastRowFolder = urlCopied.lastWhere((e) => e == '/rows/', orElse: null);
  // ignore: unnecessary_null_comparison
  if (lastRowFolder == null) return null;
  indexOfLastRowFolder = urlCopied.indexOf(lastRowFolder);
  if (urlCopied.length > indexOfLastRowFolder + 1) {
    return urlCopied[indexOfLastRowFolder + 1];
  }
  return null;
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
  List<String> urlCopied = [...url];
  String? lastTableFolder =
      urlCopied.lastWhere((e) => e == '/tables/', orElse: null);
  // ignore: unnecessary_null_comparison
  if (lastTableFolder == null) return null;
  int indexOfLastTableFolder = urlCopied.indexOf(lastTableFolder);
  if (urlCopied.length > indexOfLastTableFolder + 1) {
    String lastTableFoldersChild = urlCopied[indexOfLastTableFolder + 1];
    if (validator.isUUID(lastTableFoldersChild)) return lastTableFoldersChild;
  }
  // shorten the url
  urlCopied.length = indexOfLastTableFolder;
  lastTableFolder = urlCopied.lastWhere((e) => e == '/tables/', orElse: null);
  // ignore: unnecessary_null_comparison
  if (lastTableFolder == null) return null;
  indexOfLastTableFolder = urlCopied.indexOf(lastTableFolder);
  if (urlCopied.length > indexOfLastTableFolder + 1) {
    String lastTableFoldersChild = urlCopied[indexOfLastTableFolder + 1];
    if (validator.isUUID(lastTableFoldersChild)) return lastTableFoldersChild;
  }
  return null;
}

Ctable? get activeTable {
  final Isar isar = Get.find<Isar>();
  return isar.ctables.where().idEqualTo(activeTableId ?? '').findFirstSync();
}
