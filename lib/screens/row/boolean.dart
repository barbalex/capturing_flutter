import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BooleanWidget extends StatefulWidget {
  final Crow row;
  final Field field;
  final bool tristate;

  BooleanWidget({
    required this.row,
    required this.field,
    required this.tristate,
  });

  @override
  _BooleanWidgetState createState() => _BooleanWidgetState();
}

class _BooleanWidgetState extends State<BooleanWidget> {
  final Isar isar = Get.find<Isar>();
  late Map<String, dynamic> data;
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    data = widget.row.getData();
    String fieldName = widget.field.label ??
        widget.field.name ??
        '(Field without Label or Name)';
    String title = widget.tristate
        ? '$fieldName (current value: ${data[widget.field.name]}${data[widget.field.name] == null ? ' = no value set' : ''})'
        : fieldName;

    return FormBuilderCheckbox(
      key: Key(
          '${widget.field.name ?? widget.field.id}/${data[widget.field.name]?.toString() ?? 'false'}'),
      name: widget.field.name ?? widget.field.id,
      title: Text(title),
      onChanged: (bool? val) async {
        try {
          await widget.row.saveData(
            fieldName: widget.field.name ?? '',
            value: val,
          );
          if (errorText.value != '') {
            errorText.value = '';
          }
        } catch (e) {
          errorText.value = e.toString();
        }
        setState(() {});
      },
      validator: (_) {
        if (errorText.value != '') return errorText.value;
        return null;
      },
      // need to set false for null!
      initialValue: data[widget.field.name] ?? false,
      tristate: widget.tristate,
    );
  }
}
