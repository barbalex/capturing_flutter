import 'package:capturing/models/table.dart';
import 'package:collection/collection.dart';

List<Map> tableMapsFromTables(List<Ctable> tables) {
  List<Ctable> parents = tables.where((t) => t.parentId == null).toList();
  List<Ctable> children = tables.where((t) => t.parentId != null).toList();
  int level = 2;

  List<Map> tableMaps = [];
  parents.forEach((p) {
    tableMaps.add({'level': 1, 'table': p});
  });
  // loop for increasing levels until children is empty
  while (children.isNotEmpty) {
    List<Ctable> childrenCopied = [...children];
    childrenCopied.forEach((c) {
      Map? parentMap = tableMaps.firstWhereOrNull(
          (s) => s['table'].id == c.parentId && s['level'] == level - 1);
      if (parentMap != null) {
        int indexOfParentMap = tableMaps.indexOf(parentMap);
        if (indexOfParentMap > -1) {
          int newIndex = indexOfParentMap + 1;
          if (tableMaps.length > newIndex + 1) {
            // look if children of parent exists
            // need to sort children too
            bool goOn = true;
            while (goOn) {
              Map nextMap = tableMaps[newIndex];
              if (nextMap['level'] == parentMap['level'] + 1) {
                // sort children by ord
                if (nextMap['table'].ord < c.ord) {
                  newIndex++;
                } else {
                  goOn = false;
                }
              } else {
                goOn = false;
              }
            }
          }
          tableMaps.insert(
            newIndex,
            {'level': level, 'table': c},
          );
          children.removeWhere((child) => child.id == c.id);
        }
      }
    });
    level++;
  }
  //print('Tables editable list, tableMaps: $tableMaps');
  return tableMaps;
}
