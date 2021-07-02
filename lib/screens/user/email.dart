import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:expandable/expandable.dart';

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
  final value = ''.obs;
  final errorText = ''.obs;
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    value.value = widget.user.email ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: (hasFocus) async {
            String? oldValue = widget.user.email;
            String? newValue = value.value;
            print(
                'hasFocus: $hasFocus, value: ${value.value}, user.email: ${widget.user.email}');
            if (!hasFocus && newValue != '' && newValue != oldValue) {
              print('lost focus and has changed');
              // TODO: ensure this does not run when validator barks (no correct email)
              try {
                // update user.email
                widget.user.email = newValue;
                widget.user.save();
                // update all occurences of the email in project_user (only isar side)
                List<ProjectUser> projectUsers = isar.projectUsers
                    .where()
                    .filter()
                    .userEmailEqualTo(oldValue)
                    .findAllSync();
                await isar.writeTxn((_) async {
                  projectUsers.forEach((pU) async {
                    pU.userEmail = newValue;
                    await isar.projectUsers.put(pU);
                  });
                });
                // In a perfect world: update all occurences of the email in client_rev_by of all tables (server and isar)
                // hm. LOTS of work. And not nice for rows and files: client_rev_by is not part of the hashed rev!
                // So: don't do it.
                // TODO:
                // 1. create new firebase account
                // 2. delete old one
                // 3. log out
                // 4. log back in
                // ALTERNATIVE: Maybe the reauthenticate methode does it all? https://firebase.flutter.dev/docs/auth/usage/#reauthenticating-a-user
                errorText.value = '';
              } catch (e) {
                errorText.value = e.toString();
              }
            }
          },
          child: FormBuilderTextField(
            enabled: false,
            readOnly: true,
            name: 'email',
            decoration: InputDecoration(labelText: 'Email'.tr),
            onChanged: (String? val) {
              print('changed, val: $val');
              value.value = val == null ? '' : val;
            },
            validator: FormBuilderValidators.compose([
              (_) => errorText.value != '' ? errorText.value : null,
              FormBuilderValidators.email(context),
            ]),
            keyboardType: TextInputType.emailAddress,
            initialValue: widget.user.email,
          ),
        ),
        SizedBox(height: 8),
        Card(
          margin: EdgeInsetsGeometry.lerp(
            EdgeInsets.zero,
            EdgeInsets.zero,
            0,
          ),
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              iconPadding: EdgeInsets.all(15),
              iconSize: 30,
            ),
            header: ListTile(
              title: Text(
                'Can I change my email?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TODO:'),
                  SizedBox(height: 8),
                  Text('enable and explain'),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
