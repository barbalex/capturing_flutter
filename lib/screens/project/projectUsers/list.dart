import 'package:capturing/models/projectUser.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/screens/project/projectUsers/edit.dart';

class ProjectUserTile extends StatefulWidget {
  final ProjectUser projectUser;

  ProjectUserTile({required this.projectUser});

  @override
  _ProjectUserTileState createState() => _ProjectUserTileState();
}

class _ProjectUserTileState extends State<ProjectUserTile> {
  final Isar isar = Get.find<Isar>();
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    ProjectUser projectUser = widget.projectUser;

    return Dismissible(
      key: Key(projectUser.isarId.toString()),
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
        projectUser.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${projectUser.userEmail ?? '(no email)'} dismissed"),
          ),
        );
      },
      child: editing
          ? EditProjectUserWidget(
              projectUser: projectUser,
              stopEditing: () {
                editing = false;
              })
          : ListTile(
              dense: true,
              title: Text(
                '${projectUser.userEmail ?? '(no email)'} (${projectUser.role ?? 'no role'})',
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    editing = true;
                  });
                },
              ),
            ),
    );
  }
}
