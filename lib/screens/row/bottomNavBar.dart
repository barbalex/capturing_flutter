import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class BottomNavBar extends StatelessWidget {
  final Crow? row;
  final Ctable table;
  BottomNavBar({this.row, required this.table});

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
            int newNavbarItemIndex = 3 + childTableCount;

            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              // TODO: add nav item for every child table
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
                  String? tableId = url.length > 3 ? url[url.length - 3] : null;
                  // add row's parent row id if table has parentId
                  String? parentId = table.parentId != null ? row?.id : null;
                  Crow newRow = Crow(tableId: tableId, parentId: parentId);
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
                  List<String> newUrl = [...url];
                  newUrl.removeLast();
                  newUrl = [...newUrl, childTable.id, '/children/'];
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
