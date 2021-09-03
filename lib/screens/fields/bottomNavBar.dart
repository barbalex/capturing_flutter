import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';

class FieldsBottomNavBar extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String projectId = activeProjectId ?? '';
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Map'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.arrow_upward),
        label: 'Table List'.tr,
      ),
    ];
    if (editingProject.value == projectId) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'Table'.tr,
        ),
      );
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: bottomNavigationBarItems,
      currentIndex: 0,
      onTap: (index) async {
        switch (index) {
          case 0:
            url.value = [...url, 'map/'];
            break;
          case 1:
            url.value = ['/projects/', projectId, '/tables/'];
            break;
          case 2:
            if (tableId == null) break;
            Ctable? table =
                isar.ctables.where().idEqualTo(tableId ?? '').findFirstSync();
            if (table == null) break;
            url.value = table.getUrl();
            break;
        }
      },
    );
  }
}
