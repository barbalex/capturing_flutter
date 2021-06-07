import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DateWidget extends StatefulWidget {
  final Crow row;
  final Field field;

  DateWidget({
    required this.row,
    required this.field,
  });

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  final Isar isar = Get.find<Isar>();
  final RxString errorText = ''.obs;

  @override
  void initState() {
    super.initState();

    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.row.getData();
    bool isTime = (widget.field.fieldType ?? '') == 'date-time';

    DateTime? initialValue = data['${widget.field.name}'] != null
        ? DateTime.parse(data['${widget.field.name}'])
        : null;

    return FormBuilderDateTimePicker(
      name: widget.field.name ?? 'date',
      onChanged: (DateTime? picked) async {
        if (picked != null) {
          String formatted = picked.toIso8601String();
          if (formatted == data['${widget.field.name}']) return;
          data['${widget.field.name}'] = formatted;
          widget.row.data = json.encode(data);
          try {
            await widget.row
                .saveData(fieldName: widget.field.name ?? '', value: formatted);
            errorText.value = '';
          } catch (e) {
            print(e);
            errorText.value = e.toString();
          }
        }
      },
      validator: (_) {
        if (errorText.value != '') return errorText.value;
        return null;
      },
      inputType: isTime ? InputType.both : InputType.date,
      decoration: InputDecoration(
        labelText: widget.field.label ?? widget.field.name,
      ),
      initialValue: initialValue,
    );
  }
}
