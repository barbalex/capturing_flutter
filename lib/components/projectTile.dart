import 'package:capturing/models/project.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final Isar isar = Get.find<Isar>();

  ProjectTile({required this.project});

  @override
  Widget build(BuildContext context) {
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
            content: Text(
                "${project.label ?? project.name ?? '(project without name)'} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          project.label ?? project.name ?? '(project without name)',
        ),
        trailing: Obx(
          () => IconButton(
            icon: Icon(
              Icons.build,
            ),
            onPressed: () {
              editingProject.value =
                  editingProject.value == project.id ? '' : project.id;
            },
            tooltip: editingProject.value == project.id
                ? 'Editing data structure. Click to stop.'
                : 'Edit data structure',
            color: editingProject.value == project.id
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
          ),
        ),
        onTap: () {
          editingProject.value == project.id
              ? Get.toNamed('/projects/${project.id}')
              : Get.toNamed('/projects/${project.id}/tables/');
          return;
        },
      ),
    );
  }
}
