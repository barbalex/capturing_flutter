import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/field/field.dart';
import 'package:capturing/screens/field/bottomNavBar.dart';

class FieldViewWidget extends StatefulWidget {
  @override
  _FieldViewWidgetState createState() => _FieldViewWidgetState();
}

class _FieldViewWidgetState extends State<FieldViewWidget> {
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String id = Get.parameters['fieldId'] ?? '0';

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
                          print('page changed to index: $index');
                          activePageIndex.value = index;
                          // do not add index if returning to last
                          if (index != pageHistory.last) {
                            pageHistory.add(index);
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: fields
                              .map((field) => indicator(
                                  isActive: fields.indexOf(field) ==
                                      activePageIndex.value,
                                  context: context,
                                  onTap: () {
                                    controller.animateToPage(
                                      fields.indexOf(field),
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: BottomNavBar(
                  fields: fields,
                  activePageIndex: activePageIndex,
                  controller: controller,
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

Widget indicator({required bool isActive, context, required onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Theme.of(context).primaryColor : Color(0XFFEAEAEA),
          //color: isActive ? Colors.red : Color(0XFFEAEAEA),
        ),
      ),
    ),
  );
}
