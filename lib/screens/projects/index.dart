import 'package:flutter/material.dart';
import 'package:capturing/screens/projects/list.dart';
import 'package:capturing/screens/projects/floatingActionButton.dart';
import 'package:capturing/screens/projects/bottomNavBar.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:capturing/screens/tree/index.dart';

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
      appBar: AppBar(
        title: Text('Projects'.tr),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ProjectList(),
      drawer: Drawer(
        child: Tree(),
        semanticLabel: 'Tree view of the data structure',
      ),
      bottomNavigationBar: ProjectsBottomNavBar(),
      floatingActionButton: ProjectsFloatingActionButton(),
    );
  }
}
