import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/table/bottomNavBar.dart';
import 'package:capturing/screens/table/table.dart';
import 'package:capturing/components/carouselIndicators.dart';
import 'package:capturing/store.dart';
import 'package:collection/collection.dart';
import 'package:capturing/screens/tree/index.dart';
import 'package:capturing/utils/urlUtils.dart';

class TableContainer extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    Project? project =
        isar.projects.filter().idEqualTo(activeProjectId ?? '').findFirstSync();
    List<Ctable> tables = isar.ctables
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(activeProjectId)
        .sortByOrd()
        .findAllSync();
    Ctable? table = tables.where((p) => p.id == activeTableId).firstOrNull;
    activePageIndex.value =
        table != null ? tables.indexWhere((t) => t.id == table.id) : 0;
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
        //url.value = urlOnEntering;
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${'Table of'.tr} ${project?.getLabel()}'),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: Tree(),
          semanticLabel: 'Tree view of the data structure',
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: tables
                    .map((t) => TableWidget(tables: tables, table: t))
                    .toList(),
                onPageChanged: (index) {
                  activePageIndex.value = index;
                  // do not add index if returning to last
                  if (index != pageHistory.lastOrNull) {
                    pageHistory.add(index);
                  }
                  // enable showing same after reload
                  persistUrl(tables[index].getUrl());
                },
              ),
            ),
            CarrouselIndicators(
              activePageIndex: activePageIndex,
              controller: controller,
              datasets: tables,
            ),
          ],
        ),
        bottomNavigationBar: TableBottomNavBar(),
      ),
    );
  }
}
