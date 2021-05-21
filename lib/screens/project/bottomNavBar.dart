import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';

class BottomNavBar extends StatelessWidget {
  final List<Project> projects;
  BottomNavBar({required this.projects});

  final String id = Get.parameters['projectId'] ?? '';

  final RxInt bottomBarIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    Project project = projects.where((p) => p.id == id).first;
    int ownIndex = projects.indexOf(project);
    bool existsNextProject = projects.length > ownIndex + 1;
    Project? nextProject = existsNextProject ? projects[ownIndex + 1] : null;
    bool existsPreviousProject = ownIndex > 0;
    Project? previousProject =
        existsPreviousProject ? projects[ownIndex - 1] : null;

    return Obx(
      () => BottomNavigationBar(
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
          existsPreviousProject
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  label: 'Previous',
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'New',
                ),
          existsNextProject
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_forward),
                  label: 'Next',
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'New',
                ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            label: 'Tables',
          ),
        ],
        currentIndex: bottomBarIndex.value,
        onTap: (index) async {
          bottomBarIndex.value = index;
          switch (index) {
            case 0:
              print('TODO:');
              break;
            case 1:
              Get.toNamed('/projects/');
              break;
            case 2:
              {
                if (!existsPreviousProject) {
                  Project newProject = Project();
                  await newProject.create();
                  Get.toNamed('/projects/${newProject.id}');
                  break;
                }
                Get.toNamed('/projects/${previousProject?.id}');
                break;
              }
            case 3:
              {
                if (!existsNextProject) {
                  Project newProject = Project();
                  await newProject.create();
                  Get.toNamed('/projects/${newProject.id}');
                  break;
                }
                Get.toNamed('/projects/${nextProject?.id}');
                break;
              }
            case 4:
              Get.toNamed('/projects/${project.id}/tables/');
              break;
          }
        },
      ),
    );
  }
}
