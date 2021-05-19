import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

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
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    ever(errorText, (_) {
      setState(() {});
    });
    value.value = widget.user.email;

    return Focus(
      onFocusChange: (hasFocus) async {
        print(
            'hasFocus: $hasFocus, value: ${value.value}, user.email: ${widget.user.email}');
        if (!hasFocus && value.value != widget.user.email) {
          print('lost focus and has changed');
          // TODO: ensure this does not run when validator barks (no correct email)
          try {
            // update user.email
            widget.user.email = value.value;
            widget.user.save();
            // TODO: update all occurences of the email in project_user (only isar side)
            // TODO: update all occurences of the email in client_rev_by (server and isar)
            errorText.value = '';
          } catch (e) {
            errorText.value = e.toString();
          }
        }
      },
      child: FormBuilderTextField(
        name: 'email',
        decoration: InputDecoration(labelText: 'Email'),
        onChanged: (String? val) {
          print('changed, val: $val');
          value.value = val;
        },
        validator: FormBuilderValidators.compose([
          (_) => errorText.value != '' ? errorText.value : null,
          FormBuilderValidators.email(context),
        ]),
        keyboardType: TextInputType.emailAddress,
        initialValue: widget.user.email,
      ),
    );
  }
}
