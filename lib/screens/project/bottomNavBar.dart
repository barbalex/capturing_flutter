import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final List<Project> projects;

  BottomNavBar({
    required this.projects,
  });

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
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'List'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Tables'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'New'.tr,
        ),
      ],
      currentIndex: 0,
      onTap: (index) async {
        switch (index) {
          case 0:
            url.value = [...url, '/map/'];
            break;
          case 1:
            url.value = ['/projects/'];
            break;
          case 2:
            Project? project =
                projects.firstWhereOrNull((p) => p.id == activeProjectId);
            if (project != null) {
              url.value = [...url, '/tables/'];
            }
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
