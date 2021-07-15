import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';

class RowsBottomNavBar extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final Function goUp;

  RowsBottomNavBar({required this.goUp});

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
          label: 'Up'.tr,
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        switch (index) {
          case 0:
            url.value = [...url, 'map/'];
            break;
          case 1:
            goUp();
            break;
        }
      },
    );
  }
}
