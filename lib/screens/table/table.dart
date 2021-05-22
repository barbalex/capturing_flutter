import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/screens/table/labelFields.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/components/nameLabel.dart';

class TableWidget extends StatefulWidget {
  final Ctable table;
  final List<Ctable> tables;

  TableWidget({
    required this.tables,
    required this.table,
  });

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '';
  final String projectId = Get.parameters['projectId'] ?? '';

  final RxString relType = ''.obs;
  final RxString parentTableName = ''.obs;

  @override
  Widget build(BuildContext context) {
    final List<String> parentTableNames = widget.tables
        .where((t) => t.id != widget.table.id)
        .where((t) => t.optionType == null)
        .map((e) => e.name ?? '(no name)')
        .toList();
    parentTableNames.insert(0, '(no Parent Table)');

    return FutureBuilder(
      future: Future.wait([
        isar.optionTypes.where().findAll(),
      ]).then((result) async {
        // Need to fetch parentTableName BEFORE returning the result
        Ctable? parentTable = await isar.ctables
            .where()
            .filter()
            .idEqualTo(widget.table.parentId ?? '')
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
                snapshot.data?[0] as List<OptionType>? ?? [];
            List<FormBuilderFieldOption> optionTypesList = optionTypes
                .map((o) => o.value?.replaceFirst('none', 'no') ?? '')
                .map((lang) => FormBuilderFieldOption(value: lang))
                .toList();

            return Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 20, right: 20),
                children: <Widget>[
                  NameLabelWidget(dataset: widget.table),
                  SizedBox(
                    height: 24.0,
                  ),
                  LabelFieldsWidget(),
                  SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      labelText: 'Is this an options list?',
                    ),
                    name: 'option_type',
                    options: optionTypesList,
                    initialValue: widget.table.optionType ?? 'no',
                    orientation: OptionsOrientation.vertical,
                    onChanged: (dynamic val) async {
                      widget.table.optionType = val == 'no' ? null : val;
                      await isar.writeTxn((_) async {
                        isar.ctables.put(widget.table);
                        await isar.dbOperations.put(DbOperation(table: 'tables')
                            .setData(widget.table.toMapFromModel()));
                      });
                    },
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
                          widget.table.parentId = null;
                          await isar.writeTxn((_) async {
                            isar.ctables.put(widget.table);
                            await isar.dbOperations.put(
                                DbOperation(table: 'tables')
                                    .setData(widget.table.toMapFromModel()));
                          });
                          setState(() {});
                          return;
                        }
                        String id = widget.tables
                            .where((t) => t.name == newValue)
                            .first
                            .id;
                        widget.table.parentId = id;
                        await isar.writeTxn((_) async {
                          isar.ctables.put(widget.table);
                          await isar.dbOperations.put(
                              DbOperation(table: 'tables')
                                  .setData(widget.table.toMapFromModel()));
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
                        widget.table.relType = '1';
                        await isar.writeTxn((_) async {
                          isar.ctables.put(widget.table);
                          await isar.dbOperations.put(
                            DbOperation(table: 'tables')
                                .setData(widget.table.toMapFromModel()),
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
                        widget.table.relType = 'n';
                        await isar.writeTxn((_) async {
                          isar.ctables.put(widget.table);
                          await isar.dbOperations.put(
                            DbOperation(table: 'tables')
                                .setData(widget.table.toMapFromModel()),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
