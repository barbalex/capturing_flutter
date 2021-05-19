import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'dart:async';
import 'package:capturing/utils/doesActiveUserHaveAccount.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  StreamSubscription<String>? editingProjectListener;

  @override
  void dispose() {
    super.dispose();
    editingProjectListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    editingProjectListener = editingProject.listen((_) {
      setState(() {});
    });
    bool userHasAccount = doesActiveUserHaveAccount();

    return Scaffold(
      appBar: AppBar(
        title: FormTitle(title: 'Projects'),
      ),
      body: ProjectList(),
      // only show action button if user is account_admin
      floatingActionButton: userHasAccount
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                size: 40,
              ),
              onPressed: () async {
                Project newProject = Project();
                await newProject.create();
                Get.toNamed('/projects/${newProject.id}');
              },
            )
          : null,
    );
  }
}
