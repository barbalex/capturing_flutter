import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextWidget extends StatefulWidget {
  final Crow row;
  final Field field;
  final dynamic maxLines;

  TextWidget({
    required this.row,
    required this.field,
    this.maxLines = 1,
  });

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  final Isar isar = Get.find<Isar>();
  late Map<String, dynamic> data;
  final Rx<dynamic> value = ''.obs;
  final RxBool isDirty = false.obs;
  final RxString errorText = ''.obs;

  @override
  void initState() {
    super.initState();

    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Field field = widget.field;
    Crow row = widget.row;
    dynamic maxLines = widget.maxLines;

    data = row.getData();

    return Focus(
      onFocusChange: (hasFocus) async {
        if (!hasFocus && isDirty.value == true) {
          try {
            await row.saveData(fieldName: field.name ?? '', value: value.value);
            isDirty.value = false;
            if (errorText.value != '') {
              errorText.value = '';
            }
          } catch (e) {
            errorText.value = e.toString();
          }
        }
      },
      child: FormBuilderTextField(
        // need this key to react to changes coming from server
        key: Key(
            '${field.label}/${field.name}/${data[field.name]?.toString() ?? ''}'),
        name: field.name ?? field.id,
        decoration: InputDecoration(
          labelText: field.label ?? field.name,
        ),
        maxLines: maxLines,
        onChanged: (String? val) {
          value.value = val;
          isDirty.value = true;
        },
        validator: FormBuilderValidators.compose([
          (_) => errorText.value != '' ? errorText.value : null,
          ...(field.fieldType == 'integer'
              ? [FormBuilderValidators.integer(context)]
              : []),
          ...(field.fieldType == 'decimal'
              ? [FormBuilderValidators.numeric(context)]
              : []),
        ]),
        keyboardType: ['integer', 'decimal'].contains(field.fieldType)
            ? TextInputType.number
            : TextInputType.text,
        initialValue: data[field.name]?.toString() ?? '',
      ),
    );
  }
}
