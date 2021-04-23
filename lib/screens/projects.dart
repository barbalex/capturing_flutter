import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.build,
            ),
            onPressed: () {
              editingStructure.value = !editingStructure.value;
              setState(() {});
            },
            tooltip: editingStructure.value
                ? 'Editing data structure. Click to stop.'
                : 'Edit data structure',
            color: editingStructure.value
                ? Theme.of(context).accentColor
                : Colors.white,
          ),
        ],
        title: FormTitle(title: 'Projects'),
      ),
      body: ProjectList(),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
