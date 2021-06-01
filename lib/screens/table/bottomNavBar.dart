import 'package:flutter/material.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
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
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Fields',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New',
        )
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
            Ctable newTable = Ctable(projectId: projectId);
            await newTable.save();
            url.value = ['/projects/', projectId, '/tables/', newTable.id];
            break;
        }
      },
    );
  }
}
