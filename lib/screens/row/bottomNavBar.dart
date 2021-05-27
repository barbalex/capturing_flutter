import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('url: $url');
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
        switch (index) {
          case 0:
            print('TODO:');
            break;
          case 1:
            List<String> newUrl = [...url];
            newUrl.removeLast();
            url.value = newUrl;
            break;
          case 2:
            String? tableId = url.length > 3 ? url[url.length - 3] : null;
            Crow newRow = Crow(tableId: tableId);
            await newRow.create();
            List<String> newUrl = [...url];
            newUrl.removeLast();
            newUrl.add(newRow.id);
            url.value = newUrl;
            break;
        }
      },
    );
  }
}
