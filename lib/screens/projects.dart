import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'dart:async';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  StreamSubscription<bool>? editingStructureListener;

  @override
  void dispose() {
    super.dispose();
    editingStructureListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    editingStructureListener = editingStructure.listen((_) {
      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        // TODO: only show actions if user is account_admin
        actions: <Widget>[
          Obx(
            () => IconButton(
              icon: Icon(
                Icons.build,
              ),
              onPressed: () {
                editingStructure.value = !editingStructure.value;
              },
              tooltip: editingStructure.value
                  ? 'Editing data structure. Click to stop.'
                  : 'Edit data structure',
              color: editingStructure.value
                  ? Theme.of(context).accentColor
                  : Colors.white,
            ),
          ),
        ],
        title: FormTitle(title: 'Projects'),
      ),
      body: ProjectList(),
      // TODO: only show action button if user is account_admin
      floatingActionButton: editingStructure.value
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
