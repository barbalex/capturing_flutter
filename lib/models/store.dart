import 'package:isar/isar.dart';

/**
 * this class is used to save store values that should be reset on app start
 */

@Collection()
class Store {
  int? id;

  List<String>? url;

  String? editingProject;

  Store({
    this.url,
    this.editingProject,
  }) {
    url = ['/'];
    editingProject = '';
  }
}
