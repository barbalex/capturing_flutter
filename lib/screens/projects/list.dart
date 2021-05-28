import 'package:flutter/material.dart';
import 'package:capturing/screens/projects/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/project.dart';

class ProjectList extends StatefulWidget {
  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> projectListener;

  @override
  void initState() {
    super.initState();
    projectListener = isar.projects.watchLazy().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    projectListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.projects
          .where()
          .filter()
          .deletedEqualTo(false)
          .sortByName()
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
            if (snapshot.data == null) return Container();
            List<Project> projects = snapshot.data;

            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ProjectTile(
                      project: projects[index],
                    ),
                    Divider(
                      height: 0,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ],
                );
              },
              itemCount: projects.length,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
