import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class BottomNavBar extends StatelessWidget {
  final Crow? row;
  BottomNavBar({this.row});

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isar.ctables
            .where()
            .filter()
            .parentIdEqualTo(row?.tableId ?? 'none')
            .and()
            .deletedEqualTo(false)
            .sortByOrd()
            .findAll(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Ctable> childTables = snapshot.data?[0] ?? [];
            //print('Row bottomNavBar, childTables: $childTables');
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
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_upward),
                  label: 'List',
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
                  label: 'New',
                ),
              ],
              currentIndex: 0,
              onTap: (index) async {
                if (index == 0) {
                  print('TODO:');
                } else if (index == 1) {
                  List<String> newUrl = [...url];
                  newUrl.removeLast();
                  url.value = newUrl;
                } else if (index == newNavbarItemIndex) {
                  String? tableId = row?.tableId;
                  // add row's parent row id if table has parentId
                  List<String> urlCopied = [...url];
                  // remove last rows folder and own id
                  urlCopied.removeLast();
                  urlCopied.removeLast();
                  int indexOfLastRowsFolder =
                      urlCopied.lastIndexWhere((e) => e == '/rows/');
                  String? parentRowId = indexOfLastRowsFolder == -1
                      ? null
                      : urlCopied[indexOfLastRowsFolder + 1];
                  //String? parentId = table.parentId != null ? row?.id : null;
                  Crow newRow = Crow(tableId: tableId, parentId: parentRowId);
                  await newRow.create();
                  List<String> newUrl = [...url];
                  newUrl.removeLast();
                  newUrl.add(newRow.id);
                  url.value = newUrl;
                } else {
                  // this is a child table
                  print('TODO:');
                  Ctable childTable;
                  try {
                    childTable = childTables[index - 2];
                  } catch (e) {
                    print(e);
                    return;
                  }
                  List<String> newUrl = [
                    ...url,
                    '/tables/',
                    childTable.id,
                    '/rows/'
                  ];
                  url.value = newUrl;
                }
              },
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
