import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/operation.dart';
import 'dart:convert';

class TextWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  final Ctable table;
  final Crow row;
  final Field field;

  TextWidget({required this.table, required this.row, required this.field});

  final data = <String, dynamic>{}.obs;
  final Rx<dynamic> value = ''.obs;
  final RxBool isDirty = false.obs;
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> rowMap = row.toMap();
    print('TextWidget, rowMap: ${rowMap}');
    Map<String, dynamic> _data = {};
    // somehow
    // when fetched from server data is encoded TWICE
    // but not when saved in app...
    try {
      _data = rowMap['data'] != null ? json.decode(rowMap['data']) : {};
    } catch (e) {
      rowMap['data'] != null ? json.decode(json.decode(rowMap['data'])) : {};
    }

    print('TextWidget, _data: ${_data}');
    data.value = Map<String, dynamic>.from(_data);
    print('TextWidget, data: ${data}');
    value.value = data['${field.name}'] ?? '';
    print('TextWidget, value.value: ${value.value}');

    TextEditingController controller = TextEditingController();
    controller.text = value.value ?? '';

    return Obx(
      () => Focus(
        onFocusChange: (hasFocus) async {
          if (!hasFocus && isDirty.value == true) {
            try {
              data['${field.name}'] = value.value != '' ? value.value : null;
              print(
                  'TextWidget saving: data: $data, toJson: ${data.toJson()}, encoded: ${json.encode(data)}');
              row.data = json.encode(data);
              print('TextWidget saving: row.data: ${row.data}');
              await isar.writeTxn((_) async {
                await isar.crows.put(row);
                await isar.operations
                    .put(Operation(table: 'rows').setData(row.toMap()));
              });
              isDirty.value = false;
              if (errorText.value != '') {
                errorText.value = '';
              }
            } catch (e) {
              errorText.value = e.toString();
            }
          }
        },
        child: TextField(
          controller: controller,
          onChanged: (val) async {
            value.value = val;
            isDirty.value = true;
          },
          decoration: InputDecoration(
            labelText: field.label ?? field.name,
            errorText: errorText.value != '' ? errorText.value : null,
          ),
        ),
      ),
    );
  }
}
