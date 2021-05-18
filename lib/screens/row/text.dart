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
  Widget build(BuildContext context) {
    ever(errorText, (_) {
      setState(() {});
    });
    data = widget.row.getData();

    return Focus(
      onFocusChange: (hasFocus) async {
        if (!hasFocus && isDirty.value == true) {
          try {
            await widget.row
                .save(fieldName: widget.field.name ?? '', value: value.value);
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
        name: widget.field.name ?? widget.field.id,
        decoration: InputDecoration(
          labelText: widget.field.label ?? widget.field.name,
        ),
        maxLines: widget.maxLines,
        onChanged: (String? val) {
          print('changed, val: $val');
          value.value = val;
          isDirty.value = true;
        },
        validator: FormBuilderValidators.compose([
          (_) => errorText.value != '' ? errorText.value : null,
          ...(widget.field.fieldType == 'integer'
              ? [FormBuilderValidators.integer(context)]
              : []),
          ...(widget.field.fieldType == 'decimal'
              ? [FormBuilderValidators.numeric(context)]
              : []),
        ]),
        keyboardType: ['integer', 'decimal'].contains(widget.field.fieldType)
            ? TextInputType.number
            : TextInputType.text,
        initialValue: data[widget.field.name]?.toString() ?? '',
      ),
    );
  }
}
