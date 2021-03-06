import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class RowBottomNavBar extends StatelessWidget {
  final Crow? row;
  RowBottomNavBar({this.row});

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    List<Ctable> childTables = isar.ctables
        .filter()
        .parentIdEqualTo(row?.tableId ?? 'none')
        .and()
        .deletedEqualTo(false)
        .sortByOrd()
        .findAllSync();
    int childTableCount = childTables.length;
    int newNavbarItemIndex = 2 + childTableCount;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'List'.tr,
        ),
        ...childTables
            .map(
              (t) => BottomNavigationBarItem(
                icon: Icon(Icons.arrow_downward),
                label: t.getLabel(),
              ),
            )
            .toList(),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New'.tr,
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        if (index == 0) {
          List<String> newUrl = [...url];
          newUrl.add('/map/');
          url.value = newUrl;
        } else if (index == 1) {
          List<String> newUrl = [...url];
          if (newUrl.length > 0) newUrl.removeLast();
          url.value = newUrl;
        } else if (index == newNavbarItemIndex) {
          String? tableId = row?.tableId;
          // add row's parent row id if table has parentId
          List<String> urlCopied = [...url];
          // remove last rows folder and own id
          if (urlCopied.length > 1) {
            urlCopied.removeLast();
            urlCopied.removeLast();
          }
          int indexOfLastRowsFolder =
              urlCopied.lastIndexWhere((e) => e == '/rows/');
          String? parentRowId = indexOfLastRowsFolder == -1
              ? null
              : urlCopied.length > indexOfLastRowsFolder
                  ? urlCopied[indexOfLastRowsFolder + 1]
                  : null;
          Crow newRow = Crow(tableId: tableId, parentId: parentRowId);
          await newRow.create();
          List<String> newUrl = [...url];
          if (url.length > 0) {
            newUrl.removeLast();
            newUrl.add(newRow.id);
            url.value = newUrl;
          }
        } else {
          // this is a child table
          Ctable? childTable;
          childTable = childTables.length > 0 ? childTables[index - 2] : null;
          if (childTable != null) {
            List<String> newUrl = [...url, '/tables/', childTable.id, '/rows/'];
            url.value = newUrl;
          }
        }
      },
    );
  }
}
