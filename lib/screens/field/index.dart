import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/field/field.dart';
import 'package:capturing/screens/field/bottomNavBar.dart';
import 'package:capturing/components/carouselIndicators.dart';
import 'package:capturing/store.dart';

class FieldViewWidget extends StatefulWidget {
  @override
  _FieldViewWidgetState createState() => _FieldViewWidgetState();
}

class _FieldViewWidgetState extends State<FieldViewWidget> {
  final Isar isar = Get.find<Isar>();
  final String projectId = activeProjectId ?? '';
  final String tableId = url[url.length - 3];
  final String id = url[url.length - 1];

  final RxInt bottomBarIndex = 0.obs;
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isar.fields
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            .sortByOrd()
            .findAll(),
        isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
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
            List<Field> fields = snapshot.data[0];
            Field? field = fields.where((p) => p.id == id).first;
            Ctable table = snapshot.data[1];
            List<String> urlOnEntering = [...url];

            activePageIndex.value = fields.indexOf(field);
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
                //url.value = urlOnEntering;
                return Future.value(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: FormTitle(title: 'Field of ${table.name}'),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller,
                        children:
                            fields.map((f) => FieldWidget(field: f)).toList(),
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
                      datasets: fields,
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavBar(),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
