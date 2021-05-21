import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/row.dart';

class BottomNavBar extends StatelessWidget {
  final List<Crow> rows;
  final RxInt activePageIndex;
  final PageController controller;

  BottomNavBar({
    required this.rows,
    required this.activePageIndex,
    required this.controller,
  });

  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';
  final RxInt bottomBarIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    bool existsNextRow = rows.length > activePageIndex.value + 1;
    Crow? nextRow = existsNextRow ? rows[activePageIndex.value + 1] : null;
    bool existsPreviousRow = activePageIndex.value > 0;
    Crow? previousRow =
        existsPreviousRow ? rows[activePageIndex.value - 1] : null;

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
              Get.toNamed('/projects/${projectId}/tables/${tableId}/rows');
              break;
            case 2:
              {
                if (!existsPreviousRow) {
                  Crow newRow = Crow(tableId: tableId);
                  await newRow.create();
                  Get.toNamed(
                      '/projects/${projectId}/tables/${tableId}/rows/${newRow.id}');
                  break;
                }
                Get.toNamed(
                    '/projects/${projectId}/tables/${tableId}/rows/${previousRow?.id}');
                break;
              }
            case 3:
              {
                if (!existsNextRow) {
                  Crow newRow = Crow(tableId: tableId);
                  await newRow.create();
                  Get.toNamed(
                      '/projects/${projectId}/tables/${tableId}/rows/${newRow.id}');
                  break;
                }
                Get.toNamed(
                    '/projects/${projectId}/tables/${tableId}/rows/${nextRow?.id}');
                break;
              }
          }
        },
      ),
    );
  }
}
