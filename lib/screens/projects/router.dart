import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/projects/index.dart';
import 'package:capturing/screens/projects/bottomNavBar.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:capturing/screens/projects/list.dart';

class ProjectsRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);

    if (layout == 'sm') return ProjectsContainer();

    return LargeLayout(
      content: ProjectList(),
      title: 'Projects'.tr,
      bottomNavBar: ProjectsBottomNavBar(),
    );
  }
}