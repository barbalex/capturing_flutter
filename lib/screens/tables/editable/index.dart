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
    Project? project =
        isar.projects.where().filter().idEqualTo(projectId).findFirstSync();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              editingProject.value = '';
            },
            tooltip: 'Editing data structure. Click to stop.'.tr,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
        title:
            FormTitle(title: '${'Tables of'.tr} ${project?.getLabel() ?? ''}'),
      ),
      body: TablesEditableList(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Project List'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Project'.tr,
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
              tooltip: 'Add Table'.tr,
            )
          : null,
    );
  }
}
