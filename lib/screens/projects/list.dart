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
    List<Project> projects = isar.projects
        .where()
        .filter()
        .deletedEqualTo(false)
        .sortByName()
        .findAllSync();

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
