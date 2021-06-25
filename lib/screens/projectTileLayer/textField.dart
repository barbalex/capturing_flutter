import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextWidget extends StatefulWidget {
  final Function save;
  final String label;
  final dynamic val;
  final dynamic maxLines;

  TextWidget({
    required this.save,
    required this.label,
    required this.val,
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

    value.value = widget.val;
    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Function save = widget.save;
    String label = widget.label;
    dynamic maxLines = widget.maxLines;
    String initialValue = value.value?.toString() ?? '';
    print('initialValue: $initialValue');

    return Focus(
      onFocusChange: (hasFocus) async {
        if (!hasFocus && isDirty.value == true) {
          try {
            print('value: ${value.value}');
            await save(value.value);
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
        name: label,
        decoration: InputDecoration(labelText: label),
        maxLines: maxLines,
        onChanged: (String? val) {
          value.value = val;
          isDirty.value = true;
        },
        validator: FormBuilderValidators.compose([
          (_) => errorText.value != '' ? errorText.value : null,
        ]),
        keyboardType: TextInputType.text,
        initialValue: initialValue,
      ),
    );
  }
}
