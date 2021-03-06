import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';

class FieldBottomNavBar extends StatelessWidget {
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
          icon: Icon(Icons.add),
          label: 'New'.tr,
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        final String projectId = activeProjectId ?? '';
        final String? tableId = url.length > 2 ? url[url.length - 3] : null;
        switch (index) {
          case 0:
            url.value = [...url, '/map/'];
            break;
          case 1:
            if (tableId == null) break;
            url.value = [
              '/projects/',
              projectId,
              '/tables/',
              tableId,
              '/fields/'
            ];
            break;
          case 2:
            if (tableId == null) break;
            Field newField = Field(tableId: tableId);
            await newField.create();
            url.value = newField.getUrl();
            break;
        }
      },
    );
  }
}
