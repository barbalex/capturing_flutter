import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/projects/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'dart:async';

class ProjectsContainer extends StatefulWidget {
  @override
  _ProjectsContainerState createState() => _ProjectsContainerState();
}

class _ProjectsContainerState extends State<ProjectsContainer> {
  StreamSubscription<String>? editingProjectListener;
  StreamSubscription<bool>? activeUserHasAccountListener;

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
    activeUserHasAccountListener = activeUserHasAccount.listen((_) {
      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        title: FormTitle(title: 'Projects'),
      ),
      body: ProjectList(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'User',
          ),
        ],
        currentIndex: 0,
        onTap: (index) async {
          switch (index) {
            case 0:
              url.value = ['/projects/', 'map/'];
              break;
            case 1:
              url.value = ['/user/'];
              break;
          }
        },
      ),
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
              tooltip: 'Add Project',
            )
          : null,
    );
  }
}
