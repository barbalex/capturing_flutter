import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';
import 'dart:math';

List<Map> buildNodesEditing() {
  final Isar isar = Get.find<Isar>();

  List<Project> projects = isar.projects
      .where()
      .filter()
      .deletedEqualTo(false)
      .and()
      .idEqualTo(editingProject.value)
      .sortByName()
      .findAllSync();
  List<Map> projectNodes = projects
      .asMap()
      .entries
      .map((entry) => {
            'object': entry.value,
            'url': ['/projects/', entry.value.id],
            'sort': [1],
            'level': 1,
            'hasChildren': true,
          })
      .toList();

  List<Ctable> parentTables = isar.ctables
      .where()
      .filter()
      .projectIdEqualTo(editingProject.value)
      .and()
      .deletedEqualTo(false)
      .and()
      .parentIdIsNull()
      .sortByOrd()
      .findAllSync();
  List<Map> parentTableNodes = parentTables
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
              1,
              entry.key,
            ],
            'level': 2,
            'hasChildren': true,
          })
      .toList();

  List<Ctable> childTables = isar.ctables
      .where()
      .filter()
      .projectIdEqualTo(editingProject.value)
      .and()
      .deletedEqualTo(false)
      .and()
      .not()
      .parentIdIsNull()
      .sortByOrd()
      .findAllSync();

  List<Map> tableNodes = [...parentTableNodes];
  while (childTables.isNotEmpty) {
    List<Ctable> childrenCopied = [...childTables];
    for (Ctable c in childrenCopied) {
      Map? parentMap =
          tableNodes.firstWhereOrNull((s) => s['object'].id == c.parentId);
      if (parentMap == null) {
        // move this table to the end of the array
        Ctable thisTable = childTables.removeAt(childTables.indexOf(c));
        childTables.add(thisTable);
        break;
      }
      int indexOfParentMap = tableNodes.indexOf(parentMap);
      if (indexOfParentMap > -1) {
        int newIndex = indexOfParentMap + 1;
        if (tableNodes.length > newIndex + 1) {
          // look if childTables of parent exists
          // need to sort childTables too
          bool goOn = true;
          while (goOn) {
            Map nextMap = tableNodes[newIndex];
            if (nextMap['level'] == parentMap['level'] + 1) {
              // sort childTables by ord
              if (nextMap['object'].ord < c.ord) {
                newIndex++;
              } else {
                goOn = false;
              }
            } else {
              goOn = false;
            }
          }
        }
        tableNodes.insert(
          newIndex,
          {
            'object': c,
            'url': [
              ...parentMap['url'],
              '/tables/',
              c.id,
            ],
            'sort': [
              ...parentMap['sort'],
              0,
              newIndex,
            ],
            'level': parentMap['level'] + 1,
            'hasChildren': true, // TODO:
          },
        );
        childTables.removeWhere((child) => child.id == c.id);
      }
    }
  }

  List<Map> nodes = [...projectNodes, ...tableNodes];

  List<String> activeTableIds = [];
  url.asMap().forEach((index, value) {
    if (value == '/tables/' && url.length > index + 1) {
      activeTableIds.add(url[index + 1]);
    }
  });

  //print('activeTableIds: $activeTableIds');
  //print('url: $url');

  activeTableIds.asMap().forEach((index, id) {
    List<Field> fields = isar.fields
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .tableIdEqualTo(id)
        .sortByOrd()
        .findAllSync();

    List<Map> fieldNodes = fields.asMap().entries.map((entry) {
      Field field = entry.value;
      Map? tableMap =
          tableNodes.firstWhereOrNull((s) => s['object'].id == field.tableId);

      return {
        'object': field,
        'url': [...tableMap?['url'], '/fields/', field.id],
        'sort': [...tableMap?['sort'], 1, entry.key],
        'level': tableMap?['level'] + 1,
        'hasChildren': false,
      };
    }).toList();
    //print('rowNodes: $rowNodes');
    nodes = [...nodes, ...fieldNodes];
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

  // nodes.forEach((node) {
  //   print('nodes: ${node['object'].getLabel()}: ${node['sort']}');
  // });

  return nodes;
}
