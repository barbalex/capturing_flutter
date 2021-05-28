import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/tables/editable/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class TablesEditable extends StatelessWidget {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    //print('projectId: $projectId');
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
                      editingProject.value = '';
                    },
                    tooltip: 'Editing data structure. Click to stop.',
                    color: Theme.of(context).accentColor,
                  ),
                ],
                title:
                    FormTitle(title: 'Tables of ${project?.getLabel() ?? ''}'),
              ),
              body: TableList(),
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
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.arrow_upward,
                    ),
                    label: 'Project',
                  ),
                ],
                currentIndex: 0,
                onTap: (index) async {
                  switch (index) {
                    case 0:
                      print('TODO: show map with all tables of this project');
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
              // only show action button if user is account_admin
              floatingActionButton: editingProject.value == projectId
                  ? FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.add,
                        size: 40,
                      ),
                      onPressed: () async {
                        Ctable newTable = Ctable(projectId: projectId);
                        await newTable.save();
                        url.value = [
                          '/projects/',
                          projectId,
                          '/children/',
                          newTable.id
                        ];
                      },
                      tooltip: 'Add Table',
                    )
                  : null,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
