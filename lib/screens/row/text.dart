import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';

class TextWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  final Crow row;
  final Field field;
  final dynamic maxLines;

  TextWidget({
    required this.row,
    required this.field,
    this.maxLines = 1,
  });

  final data = <String, dynamic>{}.obs;
  final Rx<dynamic> value = ''.obs;
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
        temp = json.decode(temp);
      }
      _data = temp;
    }

    data.value = Map<String, dynamic>.from(_data);
    value.value = data['${field.name}'] ?? '';

    TextEditingController controller = TextEditingController();
    controller.text = value.value ?? '';

    return Obx(
      () => Focus(
        onFocusChange: (hasFocus) async {
          if (!hasFocus && isDirty.value == true) {
            try {
              await row.save(field: field.name ?? '', value: value.value);
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
          maxLines: maxLines,
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
