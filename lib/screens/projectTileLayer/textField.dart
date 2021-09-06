import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextWidget extends StatefulWidget {
  final Function save;
  final String label;
  final dynamic val;
  final dynamic maxLines;
  final String type;

  TextWidget({
    required this.save,
    required this.label,
    required this.val,
    this.type = 'string',
    this.maxLines = 1,
  });

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  final Isar isar = Get.find<Isar>();
  late Map<String, dynamic> data;
  dynamic value;
  final RxBool isDirty = false.obs;
  final RxString errorText = ''.obs;

  @override
  void initState() {
    super.initState();

    value = widget.val;
    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Function save = widget.save;
    String label = widget.label;
    String? type = widget.type;
    dynamic maxLines = widget.maxLines;
    dynamic initialValue = value?.toString() ?? '';

    return Focus(
      onFocusChange: (hasFocus) async {
        if (!hasFocus && isDirty.value == true) {
          try {
            print('value: ${value}');
            save(value);
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
        key: Key(label),
        name: label,
        decoration: InputDecoration(labelText: label),
        maxLines: maxLines,
        onChanged: (String? val) {
          setState(() {
            value = val;
          });
          isDirty.value = true;
        },
        validator: FormBuilderValidators.compose([
          (_) => errorText.value != '' ? errorText.value : null,
          ...(type == 'integer'
              ? [FormBuilderValidators.integer(context)]
              : []),
          ...(type == 'decimal'
              ? [FormBuilderValidators.numeric(context)]
              : []),
        ]),
        keyboardType: ['integer', 'decimal'].contains(type)
            ? TextInputType.number
            : TextInputType.text,
        initialValue: initialValue,
      ),
    );
  }
}
