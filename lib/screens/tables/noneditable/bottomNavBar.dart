import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class TablesNoneditableBottomNavBar extends StatelessWidget {
  final String projectId = activeProjectId ?? '';

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'Project List'.tr,
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        switch (index) {
          case 0:
            url.value = [...url, 'map/'];
            break;
          case 1:
            url.value = ['/projects/'];
            break;
          case 2:
            url.value = ['/projects/', projectId];
            break;
          case 3:
            // TODO: set url of parent
            //Get.toNamed();
            break;
        }
      },
    );
  }
}
