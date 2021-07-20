import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class ProjectsFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (activeUserHasAccount.value) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          Project newProject = Project();
          await newProject.save();
          url.value = ['/projects/', newProject.id];
        },
        tooltip: 'Add Project'.tr,
      );
    }
    return Container();
  }
}
