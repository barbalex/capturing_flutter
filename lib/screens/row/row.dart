import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/screens/row/text.dart';
import 'package:capturing/screens/row/date.dart';
import 'package:capturing/screens/row/dropdown.dart';
import 'package:capturing/screens/row/boolean.dart';
import 'package:capturing/screens/row/radioGroup.dart';
import 'package:capturing/screens/row/file/index.dart';

class RowWidget extends StatelessWidget {
  final Crow row;
  RowWidget({required this.row});

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    final String? tableId = row.tableId;
    print('row, tableId: $tableId');
    List<Field> fields = isar.fields
        .where()
        .filter()
        .tableIdEqualTo(tableId)
        .and()
        .deletedEqualTo(false)
        .sortByOrd()
        .findAllSync();

    List<Widget> children = fields.map((field) {
      // pick correct widget depending on row.widgetType
      // Markdown: https://pub.dev/packages/flutter_markdown
      // Quill: https://pub.dev/packages/flutter_quill
      switch (field.widgetType) {
        case 'text':
          return TextWidget(
            row: row,
            field: field,
          );
        case 'textarea':
          return TextWidget(
            row: row,
            field: field,
            maxLines: null,
          );
        case 'datepicker':
          return DateWidget(
            row: row,
            field: field,
          );
        case 'dropdown':
          return DropdownWidget(
            row: row,
            field: field,
          );
        case 'filepicker':
          return FileContainer(
            row: row,
            field: field,
          );
        case 'options-2':
          return BooleanWidget(
            row: row,
            field: field,
            tristate: false,
          );
        case 'options-3':
          return BooleanWidget(
            row: row,
            field: field,
            tristate: true,
          );
        case 'radio-group':
          return RadioGroupWidget(
            row: row,
            field: field,
          );
        default:
          return TextWidget(
            row: row,
            field: field,
          );
      }
    }).toList();
    // TODO: replace this by a small map?
    children.add(Text('coordinates: ${row.geometry}'));

    return Column(
      children: [
        Expanded(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
