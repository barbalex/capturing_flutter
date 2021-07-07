import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'dart:math';

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
            'level': 1,
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

  List<Map> tableNodes = tables
      .asMap()
      .entries
      .map((entry) => {
            'object': entry.value,
            'url': [
              '/projects/',
              entry.value.projectId,
              '/tables/',
              entry.value.id,
            ],
            'sort': [
              projectNodes
                  .indexWhere((e) => entry.value.projectId == e['object'].id),
              entry.key
            ],
            'level': 2,
          })
      .toList();

  List<Map> nodes = [...projectNodes, ...tableNodes];
  nodes.sort((a, b) {
    int aLength = a['sort'].length;
    int bLength = b['sort'].length;
    int maxLength = [aLength, bLength].toList().reduce(max);
    print('a label: ${a['object']?.getLabel()}');
    print('b label: ${b['object']?.getLabel()}');
    print('aSort: ${a['sort']}');
    print('bSort: ${b['sort']}');
    print('maxLength: ${maxLength}');
    for (var i = 0; i < maxLength; i++) {
      int? intA;
      try {
        intA = a['sort'][i];
      } catch (e) {
        // i is out of range
        return -1;
      }
      int? intB;
      try {
        intB = b['sort'][i];
      } catch (e) {
        // i is out of range
        return 1;
      }
      int val = (intA as int).compareTo(intB as int);

      print('while, intA: $intA');
      print('while, intB: $intB');
      print('while, val: $val');
      if (val != 0) return val;
    }
    print('SHOULD NOT HAPPEN');
    return 0;
  });
  print('nodes: $nodes');
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

//null T exceptionAware<T>(T Function() f) { try { return f(); } catch(_)  { return null; })
