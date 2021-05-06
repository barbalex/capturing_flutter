import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';

class DateWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  final Ctable table;
  final Crow row;
  final Field field;
  final dynamic maxLines;
  final FocusNode focusNode;

  DateWidget({
    required this.table,
    required this.row,
    required this.field,
    required this.focusNode,
    this.maxLines = 1,
  });

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

    TextEditingController controller = TextEditingController();
    controller.text = value.value;

    Future<void> selectDate() async {
      print('date, selectDate, value: ${value.value}');
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // TODO: adjust
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      print('date, selectDate. picked: $picked');
      if (picked != null) {
        final DateFormat formatter = DateFormat('yyyy.MM.dd');
        final String formatted = formatter.format(picked);
        if (formatted == value.value) return;
        value.value = formatted;
        isDirty.value = true;
        data['${field.name}'] = formatted;
        print(
            'date, selectDate, data: $data, picked: $picked, formatted: $formatted');
        row.data = json.encode(data);
        // TODO: accept null to empty field?
        try {
          await row.save(field: field.name ?? '', value: value.value);
          if (errorText.value != '') {
            errorText.value = '';
          }
        } catch (e) {
          print(e);
          errorText.value = e.toString();
        }
        focusNode.requestFocus();
      }
    }

    return Obx(
      () => Focus(
        onFocusChange: (hasFocus) async {
          if (hasFocus && isDirty.value == false) {
            selectDate();
          }
        },
        child: TextField(
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            labelText: field.label ?? field.name,
            errorText: errorText.value != '' ? errorText.value : null,
          ),
        ),
      ),
    );
  }
}
