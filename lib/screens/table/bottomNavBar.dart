import 'package:flutter/material.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class TableBottomNavBar extends StatelessWidget {
  final String projectId = activeProjectId ?? '';

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'List'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Fields'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Rows'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New Table'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New Child Table'.tr,
        ),
      ],
      onTap: (index) async {
        switch (index) {
          case 0:
            url.value = [...url, '/map/'];
            break;
          case 1:
            url.value = ['/projects/', projectId, '/tables/'];
            break;
          case 2:
            url.value = [...url, '/fields/'];
            break;
          case 3:
            url.value = [...url, '/rows/'];
            break;
          case 4:
            Ctable newTable = Ctable(projectId: projectId);
            await newTable.save();
            url.value = newTable.getUrl();
            break;
          case 5:
            Ctable newTable =
                Ctable(projectId: projectId, parentId: activeTableId);
            await newTable.save();
            url.value = newTable.getUrl();
            break;
        }
      },
    );
  }
}
