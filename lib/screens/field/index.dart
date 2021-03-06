import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/field/field.dart';
import 'package:capturing/screens/field/bottomNavBar.dart';
import 'package:capturing/components/carouselIndicators.dart';
import 'package:capturing/store.dart';
import 'package:collection/collection.dart';
import 'package:capturing/utils/urlUtils.dart';

class FieldContainer extends StatelessWidget {
  final Field field;
  FieldContainer({required this.field});

  final Isar isar = Get.find<Isar>();
  final String projectId = activeProjectId ?? '';
  final String? tableId = url.length > 2 ? url[url.length - 3] : null;

  final RxInt bottomBarIndex = 0.obs;
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    List<Field> fields = isar.fields
        .filter()
        .deletedEqualTo(false)
        .and()
        .tableIdEqualTo(tableId)
        .sortByOrd()
        .findAllSync();
    Ctable? table =
        isar.ctables.filter().idEqualTo(tableId ?? '').findFirstSync();
    List<String> urlOnEntering = [...url];

    activePageIndex.value = fields.indexWhere((f) => f.id == field.id);
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
        urlOnEntering.removeLast();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${'Field of'.tr} ${table?.getSingleLabel() ?? ''}'),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: fields.map((f) => FieldWidget(field: f)).toList(),
                onPageChanged: (index) {
                  activePageIndex.value = index;
                  // do not add index if returning to last
                  if (index != pageHistory.lastOrNull) {
                    pageHistory.add(index);
                  }
                  // enable showing same after reload
                  persistUrl(fields[index].getUrl());
                },
              ),
            ),
            CarrouselIndicators(
              activePageIndex: activePageIndex,
              controller: controller,
              datasets: fields,
            ),
          ],
        ),
        bottomNavigationBar: FieldBottomNavBar(),
      ),
    );
  }
}
