import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/screens/project/bottomNavBar.dart';
import 'package:capturing/screens/project/project.dart';

class ProjectViewWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '';

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

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Project'),
              ),
              body: ProjectWidget(projects: projects),
              bottomNavigationBar: BottomNavBar(projects: projects),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
