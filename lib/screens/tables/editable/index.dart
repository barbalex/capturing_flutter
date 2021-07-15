import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/tables/editable/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/screens/tree/index.dart';
import 'package:capturing/screens/tables/editable/bottomNavBar.dart';

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
      drawer: Drawer(
        child: Tree(),
        semanticLabel: 'Tree view of the data structure',
      ),
      body: TablesEditableList(),
      bottomNavigationBar: TablesBottomNavBar(),
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
