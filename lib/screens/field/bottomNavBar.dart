import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

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
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New',
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        final String projectId = activeProjectId ?? '';
        final String tableId = url[url.length - 3];
        switch (index) {
          case 0:
            print('TODO:');
            break;
          case 1:
            url.value = [
              '/projects/',
              projectId,
              '/children/',
              tableId,
              '/fields/'
            ];
            break;
          case 2:
            Field newField = Field();
            await newField.create();
            url.value = [
              '/projects/',
              projectId,
              '/children/',
              tableId,
              '/fields/',
              newField.id
            ];
            break;
        }
      },
    );
  }
}
