import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/tables/noneditable/list.dart';
import 'package:capturing/screens/tables/noneditable/bottomNavBar.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/screens/tree/index.dart';

class TablesNoneditable extends StatelessWidget {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    Project? project = isar.projects
      ..filter().idEqualTo(projectId).findFirstSync();

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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Tree(),
        semanticLabel: 'Tree view of the data structure',
      ),
      body: TablesNoneditableList(),
      bottomNavigationBar: TablesNoneditableBottomNavBar(),
    );
  }
}
