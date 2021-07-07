import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

List<Map> buildNodes() {
  final Isar isar = Get.find<Isar>();
  List<Project> projects = isar.projects
      .where()
      .filter()
      .deletedEqualTo(false)
      .sortByName()
      .findAllSync();
  List<Map> projectNodes = projects
      .asMap()
      .entries
      .map((entry) => {
            'object': entry.value,
            'url': ['/projects/', entry.value.id],
            'sort': [entry.key],
          })
      .toList();

  final String projectId = activeProjectId ?? '';
  List<Ctable> tables = isar.ctables
      .where()
      .filter()
      .projectIdEqualTo(projectId)
      .and()
      .deletedEqualTo(false)
      .and()
      // show tables with parent id only when editing structure
      .parentIdIsNull()
      .and()
      // show option tables only when editing structure
      .optionTypeIsNull()
      .sortByOrd()
      .findAllSync();

  print('projectNodes: $projectNodes');

  return [...projectNodes];
}
