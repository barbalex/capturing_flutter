import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/project/index.dart';
import 'package:capturing/screens/project/bottomNavBar.dart';
import 'package:capturing/screens/project/project/index.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class ProjectRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);

    if (layout == 'sm') return ProjectContainerSm();

    final Isar isar = Get.find<Isar>();
    List<Project> projects = isar.projects
        .where()
        .filter()
        .deletedEqualTo(false)
        .sortByName()
        .findAllSync();

    return LargeLayout(
      content: ProjectWidget(),
      title: 'Project'.tr,
      bottomNavBar: BottomNavBar(projects: projects),
    );
  }
}
