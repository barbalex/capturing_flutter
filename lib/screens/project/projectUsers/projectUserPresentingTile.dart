import 'package:capturing/models/projectUser.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';

class ProjectUserPresentingTile extends StatelessWidget {
  final ProjectUser projectUser;
  final Isar isar = Get.find<Isar>();

  ProjectUserPresentingTile({required this.projectUser});

  @override
  Widget build(BuildContext context) {
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
      child: ListTile(
        title: Text(
          '${projectUser.userEmail ?? '(no email)'} (${projectUser.role ?? 'no role'})',
        ),
        onTap: () {
          // TODO: show editing widget instead of presenting
        },
      ),
    );
  }
}
