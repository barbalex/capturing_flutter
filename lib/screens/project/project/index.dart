import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/nameLabel.dart';
import 'package:capturing/screens/project/projectUsers/index.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import './crs.dart';
import 'dart:async';

class ProjectWidget extends StatefulWidget {
  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  late StreamSubscription<void> projectListener;

  @override
  void initState() {
    super.initState();
    projectListener =
        isar.projects.where().idEqualTo(id).watchLazy().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    projectListener.cancel();
    super.dispose();
  }

  final Isar isar = Get.find<Isar>();
  final String id = activeProjectId ?? '';

  @override
  Widget build(BuildContext context) {
    Project? project = isar.projects.where().idEqualTo(id).findFirstSync();

    if (project == null) return Container();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 30,
      ),
      child: ListView(
        children: <Widget>[
          NameLabelWidget(dataset: project),
          SizedBox(height: 8),
          CrsWidget(project: project),
          SizedBox(height: 20),
          ProjectUsersList(project: project),
        ],
      ),
    );
  }
}
