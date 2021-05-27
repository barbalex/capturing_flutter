import 'package:capturing/models/table.dart';

List<Map> tableMapsFromTables(List<Ctable> tables) {
  List<Ctable> parents = [...tables.where((t) => t.parentId == null).toList()];
  List<Ctable> children = [...tables.where((t) => t.parentId != null).toList()];
  int level = 2;

  List<Map> tableMaps = [];
  parents.forEach((p) {
    tableMaps.add({'level': 1, 'ord': p.ord, 'id': p.id, 'table': p});
  });
  // loop for increasing levels until children is empty
  while (children.isNotEmpty) {
    //print('while 1. children: $children');
    List<Ctable> childrenCopied = [...children];
    //print('while 2. childrenCopied: $childrenCopied');
    childrenCopied.forEach((c) {
      Map parentMap = tableMaps.firstWhere(
          (s) => s['id'] == c.parentId && s['level'] == level - 1,
          orElse: () => {});
      int indexOfParentMap = tableMaps.indexOf(parentMap);
      //print('while 3. indexOfParentMap: $indexOfParentMap');
      if (indexOfParentMap > -1) {
        tableMaps.insert(
          indexOfParentMap + 1,
          {'level': level, 'ord': c.ord, 'id': c.id, 'table': c},
        );
        //print('while 4. tableMaps: $tableMaps');
        children.removeWhere((child) => child.id == c.id);
        //print('while 5. children: $children');
      }
    });
    //print('6. children: $children, level: $level');
    level++;
    //print('7. level: $level');
  }
  //print('Tables editable list, tableMaps: $tableMaps');
  return tableMaps;
}
