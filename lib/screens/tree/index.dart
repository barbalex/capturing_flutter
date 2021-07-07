import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/tree/tile.dart';
import 'package:capturing/store.dart';

class Tree extends StatefulWidget {
  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> projectListener;
  final String projectId = activeProjectId ?? '';

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
    List<Ctable> tables = isar.ctables
        .where()
        .filter()
        .projectIdEqualTo(projectId)
        .and()
        .deletedEqualTo(false)
        .and()
        // show tables with parent id only when editing structure
        .parentIdIsNull()
        .and()
        // show option tables only when editing structure
        .optionTypeIsNull()
        .sortByOrd()
        .findAllSync();

    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            TreeTile(project: projects[index]),
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
