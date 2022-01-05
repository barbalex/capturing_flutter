import 'package:isar/isar.dart';

part 'store.g.dart';

/**
 * this class is used to save store values that should be reset on app start
 */

@Collection()
class Store {
  int? id;

  List<String>? url;

  String? editingProject;

  int? largeLayoutTreeColumnSize;

  Store({
    this.url,
    this.editingProject,
    this.largeLayoutTreeColumnSize,
  }) {
    url = ['/'];
    editingProject = '';
    largeLayoutTreeColumnSize = 300;
  }
}
