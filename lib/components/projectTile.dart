import 'package:capturing/models/project.dart';
import 'package:capturing/models/operation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
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
        project.deleted = true;
        Operation operation =
            Operation(table: 'projects').setData(project.toMap());
        isar.writeTxn((isar) async {
          await isar.projects.put(project);
          await isar.operations.put(operation);
        });
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
          //print('projectTile, id: ${project.id}');
          Get.toNamed('/projects/${project.id}');
        },
      ),
    );
  }
}
