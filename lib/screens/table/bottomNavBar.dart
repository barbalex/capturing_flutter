import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatefulWidget {
  final List<Ctable> tables;
  final RxInt activePageIndex;
  final PageController controller;

  BottomNavBar({
    required this.tables,
    required this.activePageIndex,
    required this.controller,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final String projectId = Get.parameters['projectId'] ?? '';

  @override
  Widget build(BuildContext context) {
    ever(widget.activePageIndex, (_) {
      setState(() {});
    });
    int ownIndex = widget.activePageIndex.value;
    Ctable activeTable = widget.tables.asMap()[ownIndex] as Ctable;
    bool existsNextTable = widget.tables.length > ownIndex + 1;
    bool existsPreviousTable = ownIndex > 0;

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
              widget.controller.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
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
              await widget.controller.nextPage(
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
                                  '/projects/$projectId/tables/${activeTable.id}/rows/');
                            },
                          ),
                          ListTile(
                            title: Text('Fields'),
                            onTap: () {
                              Get.offAndToNamed(
                                  '/projects/$projectId/tables/${activeTable.id}/fields/');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                return;
              }
              Get.toNamed(
                  '/projects/$projectId/tables/${activeTable.id}/rows/');
              break;
            }
        }
      },
    );
  }
}
