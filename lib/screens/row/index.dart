import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/row/bottomNavBar.dart';
import 'package:capturing/screens/row/row.dart';
import 'package:capturing/components/carouselIndicators.dart';
import 'package:capturing/store.dart';
import 'package:collection/collection.dart';

class RowContainer extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String? tableId = url.length > 2 ? url[url.length - 3] : null;
  final activePageIndex = 0.obs;
  final pageHistory = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    List<String> urlCopied = [...url];
    // remove last rows folder and own id
    if (urlCopied.length > 1) {
      urlCopied.removeLast();
      urlCopied.removeLast();
    }
    int indexOfLastRowsFolder = urlCopied.lastIndexWhere((e) => e == '/rows/');
    String? parentRowId = indexOfLastRowsFolder == -1
        ? null
        : urlCopied.length > indexOfLastRowsFolder
            ? urlCopied[indexOfLastRowsFolder + 1]
            : null;

    return FutureBuilder(
      future: Future.wait([
        isar.crows
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            .and()
            .optional(
              parentRowId != null,
              (q) => q.parentIdEqualTo(parentRowId),
            )
            .findAll(),
        isar.ctables.where().filter().idEqualTo(tableId ?? '').findFirst(),
        isar.ctables
            .where()
            .filter()
            .not()
            .optionTypeEqualTo(null)
            .and()
            .deletedEqualTo(false)
            .findAll(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            if (snapshot.data == null) return Container();
            Ctable? table = isar.ctables
                .where()
                .filter()
                .idEqualTo(tableId ?? '')
                .findFirstSync();
            List<String> labelFields = table?.labelFields ?? [];
            List<Crow> rows = isar.crows
                .where()
                .filter()
                .deletedEqualTo(false)
                .and()
                .tableIdEqualTo(tableId)
                .and()
                .optional(
                  parentRowId != null,
                  (q) => q.parentIdEqualTo(parentRowId),
                )
                .findAllSync();
            rows.sort((a, b) =>
                a.getLabel(labelFields).compareTo(b.getLabel(labelFields)));
            print(
                'RowContainer, rows: ${rows.map((e) => e.toMapForServer()).toList()}');
            Crow? row = rows.where((p) => p.id == activeRowId).firstOrNull;
            if (row == null) return Container();
            int activeRowIndex = rows.indexOf(row);
            activePageIndex.value = activeRowIndex;
            // need to start with the index of the active row
            pageHistory.add(activeRowIndex);
            final PageController controller =
                PageController(initialPage: activePageIndex.value);
            List<String> urlOnEntering = [...url];

            return WillPopScope(
              // PageView does not navigate using navigator
              // so when user pops, need to use self-built pageHistory
              // and navigate back using that to enable expected experience
              onWillPop: () {
                //print('row, will pop, pageHistory: $pageHistory');
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
                  title: FormTitle(title: 'Row of ${table?.getLabel()}'),
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
                            // print(
                            //     'row, onPageChanged, pageHistory: $pageHistory');
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
                bottomNavigationBar: BottomNavBar(
                  row: row,
                  pageHistory: pageHistory,
                  rows: rows,
                ),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
