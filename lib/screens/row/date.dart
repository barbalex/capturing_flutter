import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/operation.dart';
import 'dart:convert';

class DateWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  final Ctable table;
  final Crow row;
  final Field field;
  final dynamic maxLines;
  FocusNode focusNode;

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
    Map<String, dynamic> rowMap = row.toMapFromServer();
    Map<String, dynamic> _data = {};
    // somehow
    // when fetched from server data is encoded TWICE
    // but not when saved in app...
    if (rowMap['data'] != null) {
      var temp = rowMap['data'];
      while (temp.runtimeType == String) {
        _data = json.decode(temp);
      }
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
        final DateFormat formatterForUi = DateFormat('dd.MM.yyyy');
        final String formattedForUi = formatterForUi.format(picked);
        final DateFormat formatterForServer = DateFormat('yyyy-MM-dd');
        final String formattedForServer = formatterForServer.format(picked);
        if (formattedForUi == value.value) return;
        value.value = formattedForUi;
        isDirty.value = true;
        // TODO: accept null to empty field?
        try {
          data['${field.name}'] = formattedForServer;
          print(
              'date, selectDate, data: $data, picked: $picked, formatted: $formattedForUi');
          row.data = json.encode(data);
          await isar.writeTxn((_) async {
            await isar.crows.put(row);
            await isar.operations
                .put(Operation(table: 'rows').setData(row.toMapFromServer()));
          });
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
