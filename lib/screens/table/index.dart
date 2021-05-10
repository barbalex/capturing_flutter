import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/screens/table/bottomNavBar.dart';
import 'package:capturing/screens/table/name.dart';
import 'package:capturing/screens/table/label.dart';
import 'package:capturing/screens/table/labelFields.dart';

class TableWidget extends StatefulWidget {
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String projectId = Get.parameters['projectId'] ?? '0';

  final RxBool isOptions = false.obs;
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
            isOptions.value = table.isOptions ?? false;
            parentId.value = table.parentId ?? '';
            TextEditingController parentController = TextEditingController();
            parentController.text = parentTableName.value;
            relType.value = table.relType ?? 'n';

            final List<String> parentTableNames = tables
                .where((t) => t.id != table.id)
                .map((e) => e.name ?? '(no name)')
                .toList();
            parentTableNames.insert(0, '(no Parent Table)');

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Table of ${project.name}'),
              ),
              body: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  children: <Widget>[
                    NameWidget(table: table),
                    SizedBox(
                      height: 8.0,
                    ),
                    LabelWidget(table: table),
                    SizedBox(
                      height: 24.0,
                    ),
                    LabelFieldsWidget(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Obx(
                      () => CheckboxListTile(
                        title: Text('Is an options list'),
                        value: isOptions.value,
                        onChanged: (val) async {
                          isOptions.value = val ?? false;
                          table.isOptions = val;
                          await isar.writeTxn((_) async {
                            isar.ctables.put(table);
                            await isar.operations.put(Operation(table: 'tables')
                                .setData(table.toMapFromModel()));
                            // TODO: if true, set fields automatically
                            // then set label field
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Parent Table',
                      style: TextStyle(
                        color: (Colors.grey.shade800),
                        fontSize: 13,
                      ),
                    ),
                    Obx(
                      () => DropdownButton<String>(
                        value: parentTableName.value == ''
                            ? null
                            : parentTableName.value,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) async {
                          if (newValue == '(no Parent Table)') {
                            parentId.value = '';
                            table.parentId = null;
                            await isar.writeTxn((_) async {
                              isar.ctables.put(table);
                              await isar.operations.put(
                                  Operation(table: 'tables')
                                      .setData(table.toMapFromModel()));
                            });
                            setState(() {});
                            return;
                          }
                          String id =
                              tables.where((t) => t.name == newValue).first.id;
                          parentId.value = id;
                          table.parentId = id;
                          await isar.writeTxn((_) async {
                            isar.ctables.put(table);
                            await isar.operations.put(Operation(table: 'tables')
                                .setData(table.toMapFromModel()));
                          });
                          setState(() {});
                        },
                        items: parentTableNames
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Relation Type:',
                      style: TextStyle(
                        color: (Colors.grey.shade800),
                        fontSize: 13,
                      ),
                    ),
                    Obx(
                      () => RadioListTile(
                        title: Text('1'),
                        value: '1',
                        groupValue: relType.value,
                        onChanged: (_) async {
                          relType.value = '1';
                          table.relType = '1';
                          await isar.writeTxn((_) async {
                            isar.ctables.put(table);
                            await isar.operations.put(
                              Operation(table: 'tables')
                                  .setData(table.toMapFromModel()),
                            );
                          });
                        },
                      ),
                    ),
                    Obx(
                      () => RadioListTile(
                        title: Text('n'),
                        value: 'n',
                        groupValue: relType.value,
                        onChanged: (_) async {
                          relType.value = 'n';
                          table.relType = 'n';
                          await isar.writeTxn((_) async {
                            isar.ctables.put(table);
                            await isar.operations.put(
                              Operation(table: 'tables')
                                  .setData(table.toMapFromModel()),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
