import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/screens/field/standardValue/optionDropdown.dart';

class StandardValueWidget extends StatefulWidget {
  final Field field;

  StandardValueWidget({required this.field});

  @override
  _StandardValueWidgetState createState() => _StandardValueWidgetState();
}

class _StandardValueWidgetState extends State<StandardValueWidget> {
  final Isar isar = Get.find<Isar>();
  final RxBool standardValueIsDirty = false.obs;
  final RxString standardValueErrorText = ''.obs;
  final RxString lastErrorText = ''.obs;
  final RxString booleanErrorText = ''.obs;
  final RxString nowErrorText = ''.obs;

  Future<void> save() async {
    try {
      await isar.writeTxn((_) async {
        isar.fields.put(widget.field);
        await isar.dbOperations
            .put(DbOperation(table: 'fields').setData(widget.field.toMap()));
      });
      standardValueIsDirty.value = false;
      if (standardValueErrorText.value != '') {
        standardValueErrorText.value = '';
      }
    } catch (e) {
      standardValueErrorText.value = e.toString();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    everAll([lastErrorText, booleanErrorText, nowErrorText], (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController standardValueController = TextEditingController();
    standardValueController.text = widget.field.standardValue ?? '';
    bool isOptionsTable = widget.field.optionsTable != null;
    bool showTextField = !isOptionsTable;

    if (widget.field.fieldType == 'boolean') {
      return FormBuilderCheckbox(
        name: 'bool',
        initialValue: widget.field.standardValue == 'true',
        onChanged: (bool? val) async {
          widget.field.standardValue = val == null ? null : val.toString();
          try {
            await isar.writeTxn((_) async {
              isar.fields.put(widget.field);
              await isar.dbOperations.put(
                  DbOperation(table: 'fields').setData(widget.field.toMap()));
            });
            if (booleanErrorText.value != '') {
              booleanErrorText.value = '';
            }
          } catch (e) {
            booleanErrorText.value = e.toString();
          }
          setState(() {});
        },
        title: Text(
            '${'Standard Value'.tr} (${'current value'.tr}: ${widget.field.standardValue}${widget.field.standardValue == null ? ' = ${'no value set'.tr}' : ''})'),
        validator: (_) {
          if (booleanErrorText.value != '') return booleanErrorText.value;
          return null;
        },
        tristate: true,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isOptionsTable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardValueOptionDropdownWidget(
                    field: widget.field,
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
                      widget.field.standardValue = value;
                      standardValueIsDirty.value = true;
                    },
                    decoration: InputDecoration(
                      labelText: 'Standard Value'.tr,
                      errorText: standardValueErrorText.value != ''
                          ? standardValueErrorText.value
                          : null,
                    ),
                  ),
                ),
              )
            : Container(),
        // add now checkbox for dates
        widget.field.fieldType?.contains('date') == true
            ? FormBuilderCheckbox(
                name: 'now',
                initialValue: widget.field.standardValue == 'now()',
                onChanged: (bool? val) async {
                  widget.field.standardValue = val == true ? 'now()' : null;
                  try {
                    await isar.writeTxn((_) async {
                      isar.fields.put(widget.field);
                      await isar.dbOperations.put(DbOperation(table: 'fields')
                          .setData(widget.field.toMap()));
                    });
                    if (nowErrorText.value != '') {
                      nowErrorText.value = '';
                    }
                  } catch (e) {
                    nowErrorText.value = e.toString();
                  }
                  setState(() {});
                },
                title: Text('Current Date/Time'.tr),
                validator: (_) {
                  if (nowErrorText.value != '') return nowErrorText.value;
                  return null;
                },
              )
            : Container(),
        FormBuilderCheckbox(
          name: 'last',
          initialValue: widget.field.standardValue == 'last()',
          onChanged: (bool? val) async {
            widget.field.standardValue = val == true ? 'last()' : null;
            try {
              await isar.writeTxn((_) async {
                isar.fields.put(widget.field);
                await isar.dbOperations.put(
                    DbOperation(table: 'fields').setData(widget.field.toMap()));
              });
              if (lastErrorText.value != '') {
                lastErrorText.value = '';
              }
            } catch (e) {
              lastErrorText.value = e.toString();
            }
            setState(() {});
          },
          title: Text('Previously entered Value'.tr),
          validator: (_) {
            if (lastErrorText.value != '') return lastErrorText.value;
            return null;
          },
        ),
      ],
    );
  }
}
