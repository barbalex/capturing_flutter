import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/dbOperation.dart';

class StandardValueWidget extends StatelessWidget {
  final Field field;

  StandardValueWidget({required this.field});

  final Isar isar = Get.find<Isar>();

  final RxBool standardValueIsDirty = false.obs;
  final RxString standardValueErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    TextEditingController standardValueController = TextEditingController();
    standardValueController.text = field.standardValue ?? '';

    return Obx(
      () => Focus(
        onFocusChange: (hasFocus) async {
          if (!hasFocus && standardValueIsDirty.value == true) {
            try {
              await isar.writeTxn((_) async {
                isar.fields.put(field);
                await isar.dbOperations
                    .put(DbOperation(table: 'fields').setData(field.toMap()));
              });
              standardValueIsDirty.value = false;
              if (standardValueErrorText.value != '') {
                standardValueErrorText.value = '';
              }
            } catch (e) {
              standardValueErrorText.value = e.toString();
            }
          }
        },
        child: TextField(
          controller: standardValueController,
          onChanged: (value) async {
            field.standardValue = value;
            standardValueIsDirty.value = true;
          },
          decoration: InputDecoration(
            labelText: 'Standard value',
            errorText: standardValueErrorText.value != ''
                ? standardValueErrorText.value
                : null,
          ),
        ),
      ),
    );
  }
}
