import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  final List<Crow> rows;
  final int activePageIndex;
  final PageController controller;

  BottomNavBar({
    required this.rows,
    required this.activePageIndex,
    required this.controller,
  });

  final String projectId = activeProjectId ?? '';
  final String tableId = activeTableId1 ?? '';

  final RxInt bottomBarIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    bool existsNextRow = rows.length > activePageIndex + 1;
    bool existsPreviousRow = activePageIndex > 0;

    return Obx(
      () => BottomNavigationBar(
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
          existsPreviousRow
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  label: 'Previous',
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'New',
                ),
          existsNextRow
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_forward),
                  label: 'Next',
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'New',
                ),
        ],
        currentIndex: bottomBarIndex.value,
        onTap: (index) async {
          bottomBarIndex.value = index;
          switch (index) {
            case 0:
              print('TODO:');
              break;
            case 1:
              url.value = [
                '/projects/',
                projectId,
                '/tables/',
                tableId,
                '/rows/'
              ];
              break;
            case 2:
              {
                if (!existsPreviousRow) {
                  Crow newRow = Crow(tableId: tableId);
                  await newRow.create();
                  url.value = [
                    '/projects/',
                    projectId,
                    '/tables/',
                    tableId,
                    '/rows/',
                    newRow.id
                  ];
                  break;
                }
                controller.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                break;
              }
            case 3:
              {
                if (!existsNextRow) {
                  Crow newRow = Crow(tableId: tableId);
                  await newRow.create();
                  url.value = [
                    '/projects/',
                    projectId,
                    '/tables/',
                    tableId,
                    '/rows/',
                    newRow.id
                  ];
                  break;
                }
                await controller.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                break;
              }
          }
        },
      ),
    );
  }
}
