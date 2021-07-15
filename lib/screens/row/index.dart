import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/row/bottomNavBarWithCarrousel.dart';
import 'package:capturing/screens/row/row.dart';
import 'package:capturing/components/carouselIndicators.dart';
import 'package:capturing/store.dart';
import 'package:collection/collection.dart';
import 'package:capturing/screens/tree/index.dart';

class RowContainer extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final activePageIndex = 0.obs;
  final pageHistory = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    Crow? row = isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
    if (row == null) return Container();
    Ctable? table = isar.ctables
        .where()
        .filter()
        .idEqualTo(row.tableId ?? '')
        .findFirstSync();
    List<Crow> rows = isar.crows
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .tableIdEqualTo(row.tableId)
        .and()
        .optional(
          row.parentId != null,
          (q) => q.parentIdEqualTo(row.parentId),
        )
        .findAllSync();
    rows.sort((a, b) => a.getLabel().compareTo(b.getLabel()));
    int activeRowIndex = rows.indexOf(row);
    activePageIndex.value = activeRowIndex;
    // need to start with the index of the active row
    pageHistory.add(activeRowIndex);
    final PageController controller =
        PageController(initialPage: activePageIndex.value);
    List<String> urlOnEntering = [...url];
    String? formTitle = table?.singleLabel != null
        ? table?.singleLabel
        : '${'Row of'.tr} ${table?.getLabel()}';

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
        if (urlOnEntering.length > 0) {
          urlOnEntering.removeLast();
          List<String> newUrl = [...url];
          if (newUrl.length > 0) {
            newUrl.removeLast();
            url.value = newUrl;
          }
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(formTitle ?? '(table without label)'.tr),
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
                children: rows.map((r) => RowWidget(row: r)).toList(),
                onPageChanged: (index) {
                  activePageIndex.value = index;
                  // do not add index if returning to last
                  if (index != pageHistory.lastOrNull) {
                    pageHistory.add(index);
                  }
                },
              ),
            ),
            CarrouselIndicators(
              activePageIndex: activePageIndex,
              controller: controller,
              datasets: rows,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBarWithCarrousel(
          row: row,
          pageHistory: pageHistory,
          rows: rows,
        ),
      ),
    );
  }
}
