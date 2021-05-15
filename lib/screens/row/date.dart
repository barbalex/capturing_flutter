import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.row.getData();
    bool isTime = (widget.field.fieldType ?? '').contains('time');

    ever(errorText, (_) {
      setState(() {});
    });

    return FormBuilderDateTimePicker(
      name: widget.field.name ?? 'date',
      onChanged: (DateTime? picked) async {
        if (picked != null) {
          final DateFormat formatter =
              isTime ? DateFormat('M/d/yyyy HH:mm:ss') : DateFormat('M/d/yyyy');
          final String formatted = formatter.format(picked);
          if (formatted == data['${widget.field.name}']) return;
          data['${widget.field.name}'] = formatted;
          widget.row.data = json.encode(data);
          // TODO: accept null to empty field?
          try {
            await widget.row
                .save(field: widget.field.name ?? '', value: formatted);
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
      initialValue: data['${widget.field.name}'] != null
          ? isTime
              ? DateFormat('M/d/yyyy HH:mm:ss')
                  .parse(data['${widget.field.name}'])
              : DateFormat('M/d/yyyy').parse(data['${widget.field.name}'])
          : null,
    );
  }
}
