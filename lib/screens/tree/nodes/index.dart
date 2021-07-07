import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'dart:math';

List<Map> buildNodes() {
  List<Map> nodes = [];
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
  nodes.addAll(projectNodes);

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
  nodes.sort((a, b) {
    int aLength = a['sort'].length;
    int bLength = b['sort'].length;
    int maxLength = [aLength, bLength].toList().reduce(max);

    for (int i = 0; i < maxLength - 2; i++) {
      int first = compare(a['sort'][0], b['sort'][0]);
      if (first == 0) return first;
    }
    return compare(a['sort'][maxLength - 1], b['sort'][maxLength - 1]);
  });

  return nodes;
}

int compare(int? a, int? b) {
  // sort a before, if it has no value at this index
  if (a == null) return -1;
  // sort a after if b has no value at this index
  if (b == null) return 1;
  // sort a before if its value is smaller
  return a - b;
}
