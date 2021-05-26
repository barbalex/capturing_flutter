import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  final List<Ctable> tables;
  final int activePageIndex;
  final PageController controller;

  BottomNavBar({
    required this.tables,
    required this.activePageIndex,
    required this.controller,
  });

  final String projectId = activeProjectId ?? '';

  @override
  Widget build(BuildContext context) {
    Ctable activeTable = tables.asMap()[activePageIndex] as Ctable;
    bool existsNextTable = tables.length > activePageIndex + 1;
    bool existsPreviousTable = activePageIndex > 0;

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
            url.value = ['/projects/', projectId, '/children/'];
            break;
          case 2:
            {
              if (!existsPreviousTable) {
                Ctable newTable = Ctable(projectId: projectId);
                await newTable.save();
                url.value = [
                  '/projects/',
                  projectId,
                  '/children/',
                  newTable.id
                ];
                break;
              }
              controller.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
              break;
            }
          case 3:
            {
              if (!existsNextTable) {
                Ctable newTable = Ctable(projectId: projectId);
                await newTable.save();
                url.value = [
                  '/projects/',
                  projectId,
                  '/children/',
                  newTable.id
                ];
                break;
              }
              await controller.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
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
            }
        }
      },
    );
  }
}
