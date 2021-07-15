import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/projects/list.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:capturing/screens/tree/index.dart';
import 'package:capturing/screens/projects/bottomNavBar.dart';

class ProjectsContainer extends StatefulWidget {
  @override
  _ProjectsContainerState createState() => _ProjectsContainerState();
}

class _ProjectsContainerState extends State<ProjectsContainer> {
  @override
  void initState() {
    super.initState();
    everAll([
      editingProject,
      activeUserHasAccount,
    ], (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects'.tr)),
      body: ProjectList(),
      drawer: Drawer(
        child: Tree(),
        semanticLabel: 'Tree view of the data structure',
      ),
      bottomNavigationBar: ProjectsBottomNavBar(),
      // only show action button if user is account_admin
      floatingActionButton: activeUserHasAccount.value
          ? FloatingActionButton(
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
            )
          : null,
    );
  }
}
