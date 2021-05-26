import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
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
            'deleting',
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
              Icons.build_outlined,
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
        onTap: () async {
          List<Ctable> tables = await isar.ctables
              .where()
              .filter()
              .projectIdEqualTo(project.id)
              .and()
              .parentIdIsNull()
              .and()
              .deletedEqualTo(false)
              .and()
              // show option tables only when editing structure
              .optional(editingProject.value != project.id,
                  (q) => q.optionTypeEqualTo(null))
              .findAll();
          int tableCount = tables.length;
          // if only one table exists, navigate to children list
          if (tableCount == 1 && editingProject.value != project.id) {
            url.value = [
              '/projects/',
              project.id,
              '/children/',
              tables[0].id,
              '/children/',
            ];
            return;
          }
          editingProject.value == project.id
              ? url.value = ['/projects/', project.id]
              : url.value = ['/projects/', project.id, '/children/'];
          return;
        },
      ),
    );
  }
}
