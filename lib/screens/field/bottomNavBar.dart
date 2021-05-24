import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  final List<Field> fields;
  final int activePageIndex;
  final PageController controller;

  BottomNavBar({
    required this.fields,
    required this.activePageIndex,
    required this.controller,
  });

  final Isar isar = Get.find<Isar>();
  final String projectId = activeProjectId ?? '';
  final String tableId = activeTableId1 ?? '';

  final RxInt bottomBarIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    bool existsNextField = fields.length > activePageIndex + 1;
    bool existsPreviousField = activePageIndex > 0;

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
          existsPreviousField
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  label: 'Previous',
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'New',
                ),
          existsNextField
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
                '/fields/'
              ];
              break;
            case 2:
              {
                if (!existsPreviousField) {
                  Field newField = Field();
                  await newField.create();
                  url.value = [
                    '/projects/',
                    projectId,
                    '/tables/',
                    tableId,
                    '/fields/',
                    newField.id
                  ];
                  break;
                }
                controller.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                break;
              }
            case 3:
              {
                if (!existsNextField) {
                  Field newField = Field();
                  await newField.create();
                  url.value = [
                    '/projects/',
                    projectId,
                    '/tables/',
                    tableId,
                    '/fields/',
                    newField.id
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
