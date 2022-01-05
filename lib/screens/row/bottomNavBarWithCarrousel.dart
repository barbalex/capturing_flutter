import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class BottomNavBarWithCarrousel extends StatelessWidget {
  final Crow? row;
  final RxList<int> pageHistory;
  final List<Crow> rows;
  BottomNavBarWithCarrousel(
      {this.row, required this.pageHistory, required this.rows});

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    List<Ctable> childTables = isar.ctables
        .where()
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
          // need to find active row id from pagehistory and rows
          // and set it in url
          // so the map knows what row is active
          Crow activeRow = rows[pageHistory.last];
          List<String> newUrl = [...url];
          if (newUrl.length > 0) newUrl.removeLast();
          newUrl.add(activeRow.id);
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
