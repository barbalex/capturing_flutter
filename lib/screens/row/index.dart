import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/row/bottomNavBar.dart';
import 'package:capturing/screens/row/row.dart';

class RowViewWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String id = Get.parameters['rowId'] ?? '0';
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
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

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Row of ${table.label ?? table.name}'),
              ),
              body: RowWidget(row: row),
              bottomNavigationBar: BottomNavBar(
                activePageIndex: activePageIndex,
                rows: rows,
                controller: controller,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
