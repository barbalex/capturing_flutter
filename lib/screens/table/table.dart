import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/screens/table/name.dart';
import 'package:capturing/screens/table/label.dart';
import 'package:capturing/screens/table/labelFields.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TableWidget extends StatefulWidget {
  Ctable table;
  List<Ctable> tables;
  List<FormBuilderFieldOption> optionTypesList;

  TableWidget(
      {required this.tables,
      required this.table,
      required this.optionTypesList});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String projectId = Get.parameters['projectId'] ?? '0';

  final RxString optionType = ''.obs;
  final RxString parentId = ''.obs;
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

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          NameWidget(table: widget.table),
          SizedBox(
            height: 8.0,
          ),
          LabelWidget(table: widget.table),
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
            options: widget.optionTypesList,
            initialValue: widget.table.optionType ?? 'no',
            orientation: OptionsOrientation.vertical,
            onChanged: (dynamic val) async {
              optionType.value = val;
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
              value: parentTableName.value == '' ? null : parentTableName.value,
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
                  widget.table.parentId = null;
                  await isar.writeTxn((_) async {
                    isar.ctables.put(widget.table);
                    await isar.dbOperations.put(DbOperation(table: 'tables')
                        .setData(widget.table.toMapFromModel()));
                  });
                  setState(() {});
                  return;
                }
                String id =
                    widget.tables.where((t) => t.name == newValue).first.id;
                parentId.value = id;
                widget.table.parentId = id;
                await isar.writeTxn((_) async {
                  isar.ctables.put(widget.table);
                  await isar.dbOperations.put(DbOperation(table: 'tables')
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
