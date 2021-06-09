import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/tables/noneditable/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class TablesNoneditable extends StatelessWidget {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.projects.where().filter().idEqualTo(projectId).findFirst(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Project? project = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.build,
                    ),
                    onPressed: () {
                      editingProject.value = projectId;
                    },
                    tooltip: 'Edit data structure',
                    color: Colors.white,
                  ),
                ],
                title:
                    FormTitle(title: 'Tables of ${project?.getLabel() ?? ''}'),
              ),
              body: TablesNoneditableList(),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).primaryColor,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.map),
                    label: 'Map',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.arrow_upward,
                    ),
                    label: 'Project list',
                  ),
                ],
                currentIndex: 0,
                onTap: (index) async {
                  switch (index) {
                    case 0:
                      url.value = [...url, 'map/'];
                      break;
                    case 1:
                      url.value = ['/projects/'];
                      break;
                    case 2:
                      url.value = ['/projects/', projectId];
                      break;
                    case 3:
                      // TODO: set url of parent
                      //Get.toNamed();
                      break;
                  }
                },
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
