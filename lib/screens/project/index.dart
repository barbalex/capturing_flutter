import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/screens/project/bottomNavBar.dart';
import 'package:capturing/screens/project/project/index.dart';
import 'package:capturing/store.dart';
import 'package:collection/collection.dart';
import 'package:capturing/screens/tree/index.dart';

// TODO: either remove PageController or re-enable it

class ProjectContainerSm extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String id = activeProjectId ?? '';

  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    List<Project> projects = isar.projects
        .where()
        .filter()
        .deletedEqualTo(false)
        .sortByName()
        .findAllSync();
    Project? project = projects.firstWhereOrNull((p) => p.id == id);
    activePageIndex.value = project != null ? projects.indexOf(project) : 0;
    final PageController controller =
        PageController(initialPage: activePageIndex.value);
    List<String> urlOnEntering = [...url];

    return WillPopScope(
      // PageView does not navigate using navigator
      // so when user pops, need to use self-built pageHistory
      // and navigate back using that to enable expected experience
      onWillPop: () {
        if (pageHistory.length > 1) {
          pageHistory.removeLast();
          controller.animateToPage(
            pageHistory.last,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          return Future.value(false);
        }
        urlOnEntering.removeLast();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: FormTitle(title: 'Project'.tr)),
        drawer: Drawer(
          child: Tree(),
          semanticLabel: 'Tree view of the data structure',
        ),
        body: ProjectWidget(),
        bottomNavigationBar: BottomNavBar(projects: projects),
      ),
    );
  }
}
