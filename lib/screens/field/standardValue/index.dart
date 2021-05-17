import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/screens/field/standardValue/optionDropdown.dart';

class StandardValueWidget extends StatelessWidget {
  final Field field;

  StandardValueWidget({required this.field});

  final Isar isar = Get.find<Isar>();

  final RxBool standardValueIsDirty = false.obs;
  final RxString standardValueErrorText = ''.obs;

  Future<void> save() async {
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

  @override
  Widget build(BuildContext context) {
    TextEditingController standardValueController = TextEditingController();
    standardValueController.text = field.standardValue ?? '';
    bool isOptionsTable = field.optionsTable != null;
    bool showTextField = !isOptionsTable;

    // TODO: add checkbox for boolean

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isOptionsTable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardValueOptionDropdownWidget(
                    field: field,
                    save: save,
                  )
                ],
              )
            : Container(),
        showTextField
            ? Obx(
                () => Focus(
                  onFocusChange: (hasFocus) async {
                    if (!hasFocus && standardValueIsDirty.value == true) {
                      save();
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
              )
            : Container(),
        // add now checkbox for dates
        field.fieldType?.contains('date') == true ? Container() : Container(),
        // TODO: always add last value
      ],
    );
  }
}
