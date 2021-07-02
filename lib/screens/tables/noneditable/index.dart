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
    Project? project =
        isar.projects.where().filter().idEqualTo(projectId).findFirstSync();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              editingProject.value = projectId;
            },
            tooltip: 'Edit data structure'.tr,
            color: Colors.white,
          ),
        ],
        title:
            FormTitle(title: '${'Tables of'.tr} ${project?.getLabel() ?? ''}'),
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
            label: 'Map'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Project List'.tr,
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
