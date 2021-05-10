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
  final dynamic maxLines;

  DateWidget({
    required this.row,
    required this.field,
    this.maxLines = 1,
  });

  final Isar isar = Get.find<Isar>();
  final data = <String, dynamic>{}.obs;
  final value = ''.obs;
  final RxBool isDirty = false.obs;
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    //print('date field');
    Map<String, dynamic> rowMap = row.toMapFromServer();
    Map<String, dynamic> _data = {};
    // somehow
    // when fetched from server data is encoded TWICE
    // but not when saved in app...
    if (rowMap['data'] != null) {
      var temp = rowMap['data'];
      while (temp.runtimeType == String) {
        temp = json.decode(temp);
      }
      _data = temp;
    }

    data.value = Map<String, dynamic>.from(_data);
    value.value = data['${field.name}'] ?? '';

    return Obx(
      () => FormBuilderDateTimePicker(
        name: 'date',
        onChanged: (DateTime? picked) async {
          print(
              'date, selectDate. picked: $picked, picked != null: ${picked != null}');
          if (picked != null) {
            final DateFormat formatter = DateFormat('M/d/yyyy');
            final String formatted = formatter.format(picked);
            if (formatted == value.value) return;
            value.value = formatted;
            data['${field.name}'] = formatted;
            row.data = json.encode(data);
            // TODO: accept null to empty field?
            try {
              await row.save(field: field.name ?? '', value: formatted);
              if (errorText.value != '') {
                errorText.value = '';
              }
            } catch (e) {
              print(e);
              errorText.value = e.toString();
            }
          }
        },
        inputType: InputType.date,
        decoration: InputDecoration(
          labelText: field.name,
        ),
        initialValue: data['${field.name}'] != null
            ? DateFormat('M/d/yyyy').parse(data['${field.name}'])
            : null,
      ),
    );
  }
}
