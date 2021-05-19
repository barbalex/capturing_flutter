import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class TableBottomNavBar extends StatelessWidget {
  final String tableId = Get.parameters['tableId'] ?? '';
  final String projectId = Get.parameters['projectId'] ?? '';

  final List<Ctable> tables;

  TableBottomNavBar({required this.tables});

  @override
  Widget build(BuildContext context) {
    Ctable? table = tables.where((p) => p.id == tableId).first;
    int ownIndex = tables.indexOf(table);
    bool existsNextTable = tables.length > ownIndex + 1;
    Ctable? nextTable = existsNextTable ? tables[ownIndex + 1] : null;
    bool existsPreviousTable = ownIndex > 0;
    Ctable? previousTable = existsPreviousTable ? tables[ownIndex - 1] : null;

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
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'List',
        ),
        existsPreviousTable
            ? BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back),
                label: 'Previous',
              )
            : BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'New',
              ),
        existsNextTable
            ? BottomNavigationBarItem(
                icon: Icon(Icons.arrow_forward),
                label: 'Next',
              )
            : BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'New',
              ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: editingProject.value == projectId ? 'Children' : 'Rows',
        ),
      ],
      onTap: (index) async {
        switch (index) {
          case 0:
            print('TODO:');
            break;
          case 1:
            Get.toNamed('/projects/$projectId/tables/');
            break;
          case 2:
            {
              if (!existsPreviousTable) {
                Ctable newTable = Ctable(projectId: projectId);
                await newTable.create();
                Get.toNamed('/projects/${projectId}/tables/${newTable.id}');
                break;
              }
              Get.toNamed('/projects/$projectId/tables/${previousTable?.id}');
              break;
            }
          case 3:
            {
              if (!existsNextTable) {
                Ctable newTable = Ctable(projectId: projectId);
                await newTable.create();
                Get.toNamed('/projects/${projectId}/tables/${newTable.id}');
                break;
              }
              Get.toNamed('/projects/$projectId/tables/${nextTable?.id}');
              break;
            }
          case 4:
            {
              if (editingProject.value == projectId) {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Container(
                    height: 113,
                    child: Drawer(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('Rows'),
                            onTap: () {
                              Get.offAndToNamed(
                                  '/projects/$projectId/tables/${tableId}/rows/');
                            },
                          ),
                          ListTile(
                            title: Text('Fields'),
                            onTap: () {
                              Get.offAndToNamed(
                                  '/projects/$projectId/tables/${tableId}/fields/');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                return;
              }
              Get.toNamed('/projects/$projectId/tables/${tableId}/rows/');
              break;
            }
        }
      },
    );
  }
}
