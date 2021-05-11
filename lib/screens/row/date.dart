import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DateWidget extends StatelessWidget {
  final Crow row;
  final Field field;

  DateWidget({
    required this.row,
    required this.field,
  });

  final Isar isar = Get.find<Isar>();
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = row.getData();

    return FormBuilderDateTimePicker(
      name: field.name ?? 'date',
      onChanged: (DateTime? picked) async {
        if (picked != null) {
          final DateFormat formatter = DateFormat('M/d/yyyy');
          final String formatted = formatter.format(picked);
          if (formatted == data['${field.name}']) return;
          data['${field.name}'] = formatted;
          row.data = json.encode(data);
          // TODO: accept null to empty field?
          try {
            await row.save(field: field.name ?? '', value: formatted);
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
      inputType: InputType.date,
      decoration: InputDecoration(
        labelText: field.name,
      ),
      initialValue: data['${field.name}'] != null
          ? DateFormat('M/d/yyyy').parse(data['${field.name}'])
          : null,
    );
  }
}
