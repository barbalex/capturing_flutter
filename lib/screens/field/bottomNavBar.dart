import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/field.dart';

class BottomNavBar extends StatefulWidget {
  final List<Field> fields;
  final RxInt activePageIndex;
  final PageController controller;

  BottomNavBar({
    required this.fields,
    required this.activePageIndex,
    required this.controller,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '';
  final String tableId = Get.parameters['tableId'] ?? '';

  final RxInt bottomBarIndex = 0.obs;
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;
  var activePageWorker;

  @override
  void initState() {
    super.initState();
    activePageWorker = ever(activePageIndex, (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    activePageWorker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int ownIndex = widget.activePageIndex.value;
    bool existsNextField = widget.fields.length > ownIndex + 1;
    bool existsPreviousField = ownIndex > 0;

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
              Get.toNamed('/projects/${projectId}/tables/${tableId}/fields');
              break;
            case 2:
              {
                if (!existsPreviousField) {
                  Field newField = Field();
                  await newField.create();
                  Get.toNamed(
                      '/projects/${projectId}/tables/${tableId}/fields/${newField.id}');
                  break;
                }
                widget.controller.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                break;
              }
            case 3:
              {
                if (!existsNextField) {
                  Field newField = Field();
                  await newField.create();
                  Get.toNamed(
                      '/projects/${projectId}/tables/${tableId}/fields/${newField.id}');
                  break;
                }
                await widget.controller.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                break;
              }
          }
        },
      ),
    );
  }
}
