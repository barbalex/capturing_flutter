import 'package:get/get.dart';

final editingProject = ''.obs;
final activeUserEmail = ''.obs;

// navigation is managed via this url
// using Get.toNamed
final url = <String>[].obs;
String? get activeProjectId => url[1];
int get activeTableLevelCount => url.where((e) => e == '/tables/').length;
String? get activeTableId => url[3];
String? get activeTableId2 => activeTableLevelCount > 1 ? url[5] : null;
String? get activeTableId3 => activeTableLevelCount > 2 ? url[7] : null;
String? get activeRowId => url[url.indexOf('/rows/') + 1];
String? get activeFieldId => url[url.indexOf('/fields/') + 1];
