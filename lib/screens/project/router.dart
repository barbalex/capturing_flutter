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
import 'package:animate_do/animate_do.dart';

class ProjectRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);

    final Isar isar = Get.find<Isar>();
    List<Project> projects = isar.projects
        .where()
        .filter()
        .deletedEqualTo(false)
        .sortByName()
        .findAllSync();

    if (layout == 'sm') {
      return SlideInUp(child: ProjectContainer(projects: projects));
    }

    return LargeLayout(
      content: SlideInUp(child: ProjectWidget()),
      title: 'Project'.tr,
      bottomNavBar: BottomNavBar(projects: projects),
    );
  }
}
