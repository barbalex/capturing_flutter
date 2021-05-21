import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/screens/project/bottomNavBar.dart';
import 'package:capturing/screens/project/project.dart';
import 'package:capturing/components/carrousselIndicators.dart';

class ProjectViewWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '';

  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    //print('project, id: $id');
    return FutureBuilder(
      //future: isar.projects.where().idEqualTo(id).findFirst(),
      future: isar.projects
          .where()
          .filter()
          .deletedEqualTo(false)
          .sortByName()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Project> projects = snapshot.data;
            Project project = projects.where((p) => p.id == id).first;
            activePageIndex.value = projects.indexOf(project);
            final PageController controller =
                PageController(initialPage: activePageIndex.value);

            return WillPopScope(
              // PageView does not navigate using navigator
              // so when user pops, need to use self-built pageHistory
              // and navigate back using that to enable expected experience
              onWillPop: () {
                if (pageHistory.length > 1) {
                  pageHistory.removeLast();
                  controller.animateToPage(
                    pageHistory.last,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  return Future.value(false);
                }
                return Future.value(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: FormTitle(title: 'Project'),
                ),
                body: ProjectWidget(projects: projects),
                bottomNavigationBar: BottomNavBar(projects: projects),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}