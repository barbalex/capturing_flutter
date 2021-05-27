import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  final List<Ctable> tables;
  final int activePageIndex;

  BottomNavBar({
    required this.tables,
    required this.activePageIndex,
  });

  final String projectId = activeProjectId ?? '';

  @override
  Widget build(BuildContext context) {
    Ctable activeTable = tables.asMap()[activePageIndex] as Ctable;

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
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: editingProject.value == projectId ? 'Children' : 'Rows',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New',
        )
      ],
      onTap: (index) async {
        switch (index) {
          case 0:
            print('TODO:');
            break;
          case 1:
            url.value = ['/projects/', projectId, '/children/'];
            break;
          case 2:
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
                                '/projects/$projectId/children/${activeTable.id}/children/');
                          },
                        ),
                        ListTile(
                          title: Text('Fields'),
                          onTap: () {
                            Get.offAndToNamed(
                                '/projects/$projectId/children/${activeTable.id}/children/');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
              return;
            }
            url.value = [
              '/projects/',
              projectId,
              '/children/',
              activeTable.id,
              '/children/'
            ];
            break;
          case 3:
            Ctable newTable = Ctable(projectId: projectId);
            await newTable.save();
            url.value = ['/projects/', projectId, '/children/', newTable.id];
            break;
        }
      },
    );
  }
}
