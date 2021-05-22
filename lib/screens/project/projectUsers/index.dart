import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/project/projectUsers/projectUserPresentingTile.dart';

class ProjectUsersList extends StatefulWidget {
  final Project project;

  ProjectUsersList({required this.project});

  @override
  _ProjectUsersListState createState() => _ProjectUsersListState();
}

class _ProjectUsersListState extends State<ProjectUsersList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> projectUsersListener;

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
            // TODO: add insertingTile
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                return ProjectUserPresentingTile(
                  projectUser: snapshot.data[index],
                );
              },
              itemCount: snapshot.data.length,
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
