import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/screens/table/bottomNavBar.dart';
import 'package:capturing/screens/table/name.dart';
import 'package:capturing/screens/table/label.dart';
import 'package:capturing/screens/table/labelFields.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/screens/table/table.dart';

class TableViewWidget extends StatefulWidget {
  @override
  _TableViewWidgetState createState() => _TableViewWidgetState();
}

class _TableViewWidgetState extends State<TableViewWidget> {
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
        isar.optionTypes.where().findAll(),
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
            List<OptionType> optionTypes =
                snapshot.data?[2] as List<OptionType>? ?? [];
            List<FormBuilderFieldOption> optionTypesList = optionTypes
                .map((o) => o.value?.replaceFirst('none', 'no') ?? '')
                .map((lang) => FormBuilderFieldOption(value: lang))
                .toList();
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
                optionTypesList: optionTypesList,
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
