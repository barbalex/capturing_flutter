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

class RowWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String? tableId = url.length > 2 ? url[url.length - 3] : null;
  final String? rowId = url.length > 0 ? url[url.length - 1] : null;
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    List<String> urlCopied = [...url];
    // remove last rows folder and own id
    urlCopied.removeLast();
    urlCopied.removeLast();
    int indexOfLastRowsFolder = urlCopied.lastIndexWhere((e) => e == '/rows/');
    String? parentRowId = indexOfLastRowsFolder == -1
        ? null
        : urlCopied[indexOfLastRowsFolder + 1];

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
            Ctable? table = snapshot.data?[1];
            //print('RowViewWidget, table: $table');
            List<Crow> rows = snapshot.data?[0] ?? [];
            Crow? row = rows.where((p) => p.id == rowId).firstOrNull;

            activePageIndex.value = row != null ? rows.indexOf(row) : 0;
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
                List<String> newUrl = [...url];
                newUrl.removeLast();
                url.value = newUrl;
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
                        children:
                            rows.map((r) => RowRowWidget(row: r)).toList(),
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
                bottomNavigationBar: BottomNavBar(row: row),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
