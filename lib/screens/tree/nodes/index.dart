import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/store.dart';
import 'dart:math';

// TODO:
// if editingStructure:
// add to table:
// - rows
// - fields
// and add fields

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

  List<Map> topTableNodes = tables
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

  List<Map> nodes = [...projectNodes, ...topTableNodes];

  List<String> activeTableIds = [];
  url.asMap().forEach((index, value) {
    if (value == '/tables/' && url.length > index + 1) {
      activeTableIds.add(url[index + 1]);
    }
  });

  //print('activeTableIds: $activeTableIds');

  activeTableIds.asMap().forEach((index, id) {
    // TODO: get level and data and build nodes
    int ownIndex = url.indexOf(id);
    String? parentRowId;
    if (url.length > 6) {
      int parentRowIndex = ownIndex - 2;
      int rowsIndex = ownIndex - 3;
      if (url[rowsIndex] == '/rows/') {
        parentRowId = url[parentRowIndex];
      }
    }
    List<Crow> rows = isar.crows
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .tableIdEqualTo(id)
        .and()
        .optional(
          parentRowId != null,
          (q) => q.parentIdEqualTo(parentRowId),
        )
        .findAllSync();
    double tableLevel = (ownIndex + 1) / 4;
    List<Map> rowNodes = rows.asMap().entries.map((entry) {
      Crow row = entry.value;
      List<String> url = row.getUrl();

      return {
        'object': row,
        'url': url,
        'sort': [
          ...(url.length > 1
              ? [projectNodes.indexWhere((e) => url[1] == e['object'].id)]
              : []),
          ...(url.length > 3
              ? [topTableNodes.indexWhere((e) => url[3] == e['object'].id)]
              : []),
          entry.key
        ],
        'level': 2 + tableLevel,
      };
    }).toList();
    //print('rowNodes: $rowNodes');
    nodes = [...nodes, ...rowNodes];
  });
  nodes.sort((a, b) {
    int aLength = a['sort'].length;
    int bLength = b['sort'].length;
    int maxLength = [aLength, bLength].toList().reduce(max);
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
      if (val != 0) return val;
    }
    print('SHOULD NOT HAPPEN');
    return 0;
  });
  nodes.asMap().forEach((index, value) {
    bool open = false;
    if ((index + 1) < nodes.length) {
      open = nodes[index + 1]['level'] > value['level'];
    }
    value['open'] = open;
  });
  return nodes;
}
