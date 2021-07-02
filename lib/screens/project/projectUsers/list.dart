import 'package:capturing/models/projectUser.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/screens/project/projectUsers/edit.dart';

class ProjectUserTile extends StatelessWidget {
  final ProjectUser projectUser;
  final Function setEditingProjectUser;
  final String? editingProjectUser;

  ProjectUserTile({
    required this.projectUser,
    required this.setEditingProjectUser,
    required this.editingProjectUser,
  });

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(projectUser.isarId.toString()),
      // Show a red background as the item is swiped away.
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: Text(
            'delete'.tr,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        projectUser.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${projectUser.userEmail ?? '(no email)'} dismissed"),
          ),
        );
      },
      child: editingProjectUser == projectUser.id
          ? EditProjectUserWidget(
              projectUser: projectUser,
              setEditingProjectUser: setEditingProjectUser,
            )
          : Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black26))),
              child: ListTile(
                dense: true,
                title: Text(
                  '${projectUser.userEmail ?? '(no email)'} (${projectUser.role ?? 'no role'})',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setEditingProjectUser(projectUser.id);
                  },
                ),
              ),
            ),
    );
  }
}
