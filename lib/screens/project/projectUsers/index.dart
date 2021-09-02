import 'package:capturing/models/projectUser.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/project/projectUsers/list.dart';

class ProjectUsersList extends StatefulWidget {
  final Project project;

  ProjectUsersList({required this.project});

  @override
  _ProjectUsersListState createState() => _ProjectUsersListState();
}

class _ProjectUsersListState extends State<ProjectUsersList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> projectUsersListener;
  String? editingProjectUser;

  @override
  void initState() {
    super.initState();
    projectUsersListener = isar.projectUsers
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(widget.project.id)
        .watchLazy()
        .listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    projectUsersListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Project project = widget.project;

    void setEditingProjectUser(String? id) {
      setState(() {
        editingProjectUser = id;
      });
    }

    List<ProjectUser> projectUsers = isar.projectUsers
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(project.id)
        .findAllSync();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collaborators'.tr,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        // can NOT use a ListView.divided here
        // because it creates it's own scrollbar
        // which makes it hard to have one for the entire project form
        Column(
          children: projectUsers
              .map(
                (projectUser) => ProjectUserTile(
                  projectUser: projectUser,
                  setEditingProjectUser: setEditingProjectUser,
                  editingProjectUser: editingProjectUser,
                ),
              )
              .toList(),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: editingProjectUser != null
              ? null
              : OutlinedButton(
                  onPressed: () async {
                    ProjectUser newUser = ProjectUser(projectId: project.id);
                    await newUser.save();
                    setState(() {
                      editingProjectUser = newUser.id;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                      ),
                      SizedBox(width: 10),
                      Text('Add Collaborator'.tr),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
