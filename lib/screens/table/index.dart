import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/project.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:capturing/models/operation.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reorderables/reorderables.dart';
import 'package:capturing/screens/table/bottomNavBar.dart';
import 'package:capturing/screens/table/name.dart';
import 'package:capturing/screens/table/label.dart';

class TableWidget extends StatefulWidget {
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String projectId = Get.parameters['projectId'] ?? '0';

  final RxBool dirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString labelErrorText = ''.obs;
  final RxBool isOptions = false.obs;
  final RxString parentId = ''.obs;
  final RxString relType = ''.obs;
  final RxList<String> labelFields = <String>[].obs;

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
        isar.fields.where().filter().tableIdEqualTo(tableId).findAll(),
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
            List<Field> fields = snapshot.data?[2];
            Project project = snapshot.data?[1];
            List<Ctable> tables = snapshot.data?[0] ?? [];
            Ctable? table = tables.where((p) => p.id == tableId).first;
            isOptions.value = table.isOptions ?? false;
            parentId.value = table.parentId ?? '';
            TextEditingController parentController = TextEditingController();
            parentController.text = parentTableName.value;
            relType.value = table.relType ?? 'n';
            labelFields.value = table.labelFields ?? [];

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
                    // fieldNames
                    SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'Fields used to label rows',
                      style: TextStyle(
                        color: (Colors.grey.shade800),
                        fontSize: 13,
                      ),
                    ),
                    fields.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                style: ButtonStyle(),
                                onPressed: () async {
                                  List fields = await isar.fields
                                      .where()
                                      .filter()
                                      .tableIdEqualTo(tableId)
                                      .findAll();
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx) {
                                      return MultiSelectBottomSheet(
                                        items: fields
                                            .map((e) => MultiSelectItem(
                                                e.name, e.name ?? '(no name)'))
                                            .toList(),
                                        initialValue:
                                            (table.labelFields ?? []).toList(),
                                        onConfirm: (values) async {
                                          labelFields.value = values
                                              .map((e) => e as String)
                                              .toList();
                                          table.labelFields = labelFields;
                                          await isar.writeTxn((_) async {
                                            isar.ctables.put(table);
                                            await isar.operations.put(Operation(
                                                    table: 'tables')
                                                .setData(
                                                    table.toMapFromModel()));
                                          });
                                          setState(() {});
                                        },
                                        maxChildSize: 0.8,
                                        initialChildSize: 0.5,
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Select'),
                                    Icon(Icons.arrow_downward),
                                  ],
                                ),
                              ),
                              labelFields.length > 0
                                  ? Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReorderableRow(
                                            onReorder: (int oldIndex,
                                                int newIndex) async {
                                              String labelField = labelFields
                                                  .removeAt(oldIndex);
                                              labelFields.insert(
                                                  newIndex, labelField);
                                              table.labelFields = labelFields;
                                              await isar.writeTxn((_) async {
                                                isar.ctables.put(table);
                                                await isar.operations.put(
                                                  Operation(table: 'tables')
                                                      .setData(
                                                    table.toMapFromModel(),
                                                  ),
                                                );
                                              });
                                            },
                                            children: labelFields
                                                .map(
                                                  (e) => Chip(
                                                    label: Text(e),
                                                    key: ValueKey(e),
                                                    backgroundColor:
                                                        Colors.white,
                                                    shadowColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    elevation: 1,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .padded,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                          Visibility(
                                            child: Text(
                                              'Hint: dragg Fields to order them.',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.orange.shade400,
                                              ),
                                            ),
                                            visible: labelFields.length > 1,
                                          )
                                        ],
                                      ),
                                    )
                                  : Text('No Field choosen as row label yet.'),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Text(
                                'You need to create fields before you can select the fields to label rows with.'),
                          ),

                    // Text((table.labelFields ?? [])
                    //     .join(table.labelFieldsSeparator ?? ', ')),
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
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
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
                    // TypeAheadField(
                    //   textFieldConfiguration: TextFieldConfiguration(
                    //     controller: parentController,
                    //     decoration: InputDecoration(
                    //       labelText: 'Parent Table',
                    //       suffixIcon: IconButton(
                    //         onPressed: () async {
                    //           parentController.clear();
                    //           parentId.value = '';
                    //           table.parentId = null;
                    //           await isar.writeTxn((_) async {
                    //             isar.ctables.put(table);
                    //             await isar.operations.put(
                    //                 Operation(table: 'tables')
                    //                     .setData(table.toMapFromModel()));
                    //           });
                    //           setState(() {});
                    //         },
                    //         icon: Icon(Icons.clear),
                    //       ),
                    //     ),
                    //   ),
                    //   suggestionsCallback: (pattern) async => isar.ctables
                    //       .where()
                    //       .filter()
                    //       .not()
                    //       .idEqualTo(table.id)
                    //       .and()
                    //       .nameContains(pattern, caseSensitive: false)
                    //       .and()
                    //       .projectIdEqualTo(projectId)
                    //       .sortByName()
                    //       .findAll(),
                    //   itemBuilder: (context, Ctable table) {
                    //     return ListTile(
                    //       title: Text(table.name ?? ''),
                    //     );
                    //   },
                    //   onSuggestionSelected: (Ctable choosenTable) async {
                    //     parentId.value = choosenTable.id;
                    //     table.parentId = choosenTable.id;
                    //     await isar.writeTxn((_) async {
                    //       isar.ctables.put(table);
                    //       await isar.operations.put(Operation(table: 'tables')
                    //           .setData(table.toMapFromModel()));
                    //     });
                    //     setState(() {});
                    //   },
                    // ),
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
