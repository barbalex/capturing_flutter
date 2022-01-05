import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/screens/tables/editable/index.dart';
import 'package:capturing/screens/tables/editable/bottomNavBar.dart';
import 'package:capturing/screens/tables/editable/list.dart';
import 'package:capturing/screens/tables/noneditable/bottomNavBar.dart';
import 'package:capturing/screens/tables/noneditable/index.dart';
import 'package:capturing/screens/tables/noneditable/list.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/largeLayout.dart';
import 'package:capturing/models/project.dart';

class TablesListRouter extends StatefulWidget {
  @override
  _TablesListRouterState createState() => _TablesListRouterState();
}

class _TablesListRouterState extends State<TablesListRouter> {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();

  @override
  void initState() {
    super.initState();
    ever(editingProject, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);
    Project? project =
        isar.projects.where().filter().idEqualTo(projectId).findFirstSync();

    if (editingProject.value == projectId) {
      if (layout == 'sm') return TablesEditable();
      return LargeLayout(
        content: TablesEditableList(),
        title: '${'Tables of'.tr} ${project?.getLabel() ?? ''}',
        bottomNavBar: TablesEditableBottomNavBar(),
      );
    }
    if (layout == 'sm') return TablesNoneditable();
    return LargeLayout(
      content: TablesNoneditableList(),
      title: '${'Tables of'.tr} ${project?.getLabel() ?? ''}',
      bottomNavBar: TablesNoneditableBottomNavBar(),
    );
  }
}
