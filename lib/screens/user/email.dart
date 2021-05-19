import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/models/user.dart';

class EmailWidget extends StatefulWidget {
  final CUser user;

  EmailWidget({
    required this.user,
  });

  @override
  _EmailWidgetState createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
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

    return Focus(
      onFocusChange: (hasFocus) async {
        if (!hasFocus && isDirty.value == true) {
          try {
            await widget.user
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
        name: 'email',
        decoration: InputDecoration(
          labelText: 'Email',
        ),
        onChanged: (String? val) {
          print('changed, val: $val');
          value.value = val;
          isDirty.value = true;
        },
        validator: (_) => errorText.value != '' ? errorText.value : null,
        keyboardType: TextInputType.emailAddress,
        initialValue: widget.user.email,
      ),
    );
  }
}
