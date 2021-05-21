import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/table/bottomNavBar.dart';
import 'package:capturing/screens/table/table.dart';

class TableViewWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String projectId = Get.parameters['projectId'] ?? '0';

  final RxString optionType = ''.obs;
  final RxString parentId = ''.obs;
  final RxString relType = ''.obs;

  final RxString parentTableName = ''.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isar.ctables
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .projectIdEqualTo(projectId)
            .sortByName()
            .findAll(),
        isar.projects.where().filter().idEqualTo(projectId).findFirst(),
      ]).then((result) async {
        // Need to fetch parentTableName BEFORE returning the result
        List<Ctable> tables = result[0] as List<Ctable>? ?? [];
        Ctable table = tables.where((p) => p.id == tableId).first;
        Ctable? parentTable = await isar.ctables
            .where()
            .filter()
            .idEqualTo(table.parentId ?? '')
            .and()
            .optionTypeEqualTo(null)
            .findFirst();
        parentTableName.value = parentTable?.name ?? '';
        return result;
      }),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Project project = snapshot.data?[1];
            List<Ctable> tables = snapshot.data?[0] ?? [];
            Ctable? table = tables.where((p) => p.id == tableId).first;
            optionType.value = table.optionType ?? '';
            parentId.value = table.parentId ?? '';
            TextEditingController parentController = TextEditingController();
            parentController.text = parentTableName.value;
            relType.value = table.relType ?? 'n';

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Table of ${project.name}'),
              ),
              body: TableWidget(
                tables: tables,
                table: table,
              ),
              bottomNavigationBar: TableBottomNavBar(
                tables: tables,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
