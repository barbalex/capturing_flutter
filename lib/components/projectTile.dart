import 'package:capturing/models/project.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final Isar isar = Get.find<Isar>();

  ProjectTile({required this.project});

  @override
  Widget build(BuildContext context) {
    // print(
    //     'project: id: ${project.id}, name: ${project.name}, clientRevAt: ${project.clientRevAt}, clientRevBy: ${project.clientRevBy}');
    return Dismissible(
      key: Key(project.isarId.toString()),
      // Show a red background as the item is swiped away.
      background: Container(
        color: Theme.of(context).accentColor,
        child: Center(
          child: Text(
            'dismissing',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        project.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${project.name ?? ''} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          project.name ?? '',
        ),
        onTap: () {
          // TODO:
          // only go to project details if user is account_admin AND editingStructure
          // else: go to tables
          Get.toNamed('/projects/${project.id}');
        },
      ),
    );
  }
}
