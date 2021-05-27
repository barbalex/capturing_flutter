import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/store.dart';

class BottomNavBar extends StatelessWidget {
  final List<Project> projects;

  BottomNavBar({
    required this.projects,
  });

  final String id = activeProjectId ?? '';

  @override
  Widget build(BuildContext context) {
    Project project = projects.where((p) => p.id == id).first;

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
          label: 'Tables',
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
            url.value = ['/projects/'];
            break;
          case 2:
            url.value = ['/projects/', project.id, '/children/'];
            break;
          case 3:
            Project newProject = Project();
            await newProject.save();
            url.value = ['/projects/', newProject.id];
            break;
        }
      },
    );
  }
}
