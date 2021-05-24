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

class RowViewWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String tableId = activeTableId1 ?? '';
  final String id = activeRowId ?? '';
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    //final String? tableId2 = activeTableLevelCount.value > 1 ? url[5] : null;
    //final String? tableId3 = activeTableLevelCount.value > 2 ? url[7] : null;

    print('RowWidget, activeRowId: ${activeRowId}');

    return FutureBuilder(
      future: Future.wait([
        isar.crows
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            .findAll(),
        isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
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
            Ctable table = snapshot.data[1];
            List<Crow> rows = snapshot.data[0];
            Crow? row = rows.where((p) => p.id == id).first;

            activePageIndex.value = rows.indexOf(row);
            final PageController controller =
                PageController(initialPage: activePageIndex.value);

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
                return Future.value(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  title:
                      FormTitle(title: 'Row of ${table.label ?? table.name}'),
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
                          if (index != pageHistory.last) {
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
                bottomNavigationBar: Obx(
                  () => BottomNavBar(
                    activePageIndex: activePageIndex.value,
                    rows: rows,
                    controller: controller,
                  ),
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
