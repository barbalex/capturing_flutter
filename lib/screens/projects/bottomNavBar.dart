import 'package:flutter/material.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class ProjectsBottomNavBar extends StatelessWidget {
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
          icon: Icon(Icons.person),
          label: 'User'.tr,
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        switch (index) {
          case 0:
            url.value = ['/projects/', 'map/'];
            break;
          case 1:
            url.value = ['/user/'];
            break;
        }
      },
    );
  }
}
