import 'dart:async';
import 'package:flutter/material.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/roleType.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

class EditProjectUserWidget extends StatefulWidget {
  final ProjectUser projectUser;
  final Function setEditingProjectUser;

  EditProjectUserWidget({
    required this.projectUser,
    required this.setEditingProjectUser,
  });

  @override
  _EditProjectUserWidgetState createState() => _EditProjectUserWidgetState();
}

class _EditProjectUserWidgetState extends State<EditProjectUserWidget> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    ProjectUser projectUser = widget.projectUser;
    Function setEditingProjectUser = widget.setEditingProjectUser;
    final Isar isar = Get.find<Isar>();
    String? roleError;
    final email = ''.obs;
    String? emailError;

    List<RoleType> roleTypes = isar.roleTypes
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .not()
        .valueEqualTo('account_manager')
        .sortBySort()
        .findAllSync();
    email.value = projectUser.userEmail ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'Edit Collaborator'.tr,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        Focus(
          onFocusChange: (hasFocus) async {
            if (!hasFocus && email.value != projectUser.userEmail) {
              try {
                projectUser.userEmail = email.value;
                await projectUser.save();
                emailError = null;
                setState(() {});
                if (projectUser.role != null) {
                  Timer(
                    Duration(seconds: 1),
                    () => setEditingProjectUser(null),
                  );
                }
              } catch (e) {
                String errorText = e.toString();
                if (errorText.contains('Unique index violated')) {
                  errorText = 'The name has to be unique'.tr;
                }
                emailError = errorText;
                setState(() {});
              }
            }
          },
          child: FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(labelText: 'Email'.tr),
            onChanged: (String? val) async {
              email.value = val ?? '';
            },
            validator: FormBuilderValidators.compose([
              (_) => emailError,
              FormBuilderValidators.required(context),
              FormBuilderValidators.email(context),
            ]),
            keyboardType: TextInputType.emailAddress,
            initialValue: projectUser.userEmail ?? '',
          ),
        ),
        FormBuilderRadioGroup<String?>(
          wrapCrossAxisAlignment: WrapCrossAlignment.center,
          name: 'role',
          validator: (_) => roleError,
          onChanged: (choosen) async {
            if (choosen == projectUser.role) {
              projectUser.role = null;
            } else {
              // add project_ again
              projectUser.role = 'project_${choosen}';
            }
            try {
              await projectUser.save();
              roleError = null;
            } catch (e) {
              print(e);
              roleError = e.toString();
            }
            setState(() {});
            if (projectUser.userEmail != '') {
              Timer(
                Duration(seconds: 1),
                () => setEditingProjectUser(null),
              );
            }
          },
          decoration: InputDecoration(labelText: 'Role'.tr),
          initialValue: (projectUser.role ?? '').replaceAll(r'project_', ''),
          options: roleTypes
              .map(
                (roleType) => FormBuilderFieldOption(
                  // remove project_ for clearer ui
                  value: (roleType.value ?? '').replaceAll(r'project_', ''),
                ),
              )
              .toList(growable: false),
          orientation: OptionsOrientation.vertical,
        )
      ],
    );
  }
}
