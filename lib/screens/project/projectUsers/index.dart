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

    return FutureBuilder(
      future: isar.projectUsers
          .where()
          .filter()
          .deletedEqualTo(false)
          .and()
          .projectIdEqualTo(project.id)
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collaborators',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        return ProjectUserTile(
                          projectUser: snapshot.data[index],
                          setEditingProjectUser: setEditingProjectUser,
                          editingProjectUser: editingProjectUser,
                        );
                      },
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: editingProjectUser != null
                        ? null
                        : OutlinedButton(
                            onPressed: () async {
                              ProjectUser newUser =
                                  ProjectUser(projectId: project.id);
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
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Add user'),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
