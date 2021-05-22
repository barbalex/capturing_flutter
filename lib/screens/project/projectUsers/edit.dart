import 'package:flutter/material.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/roleType.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

class EditProjectUserWidget extends StatefulWidget {
  final ProjectUser projectUser;

  EditProjectUserWidget({required this.projectUser});

  @override
  _EditProjectUserWidgetState createState() => _EditProjectUserWidgetState();
}

class _EditProjectUserWidgetState extends State<EditProjectUserWidget> {
  @override
  Widget build(BuildContext context) {
    ProjectUser projectUser = widget.projectUser;
    final Isar isar = Get.find<Isar>();
    String? roleError;
    String? email;
    String? emailError;

    return FutureBuilder(
      future: isar.roleTypes
          .where()
          .filter()
          .deletedEqualTo(false)
          .sortBySort()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<RoleType> roleTypes = snapshot.data;
            email = projectUser.userEmail;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Focus(
                  onFocusChange: (hasFocus) async {
                    if (!hasFocus && email != projectUser.userEmail) {
                      try {
                        projectUser.userEmail = email;
                        await projectUser.save();
                        emailError = null;
                      } catch (e) {
                        String errorText = e.toString();
                        if (errorText.contains('Unique index violated')) {
                          errorText = 'The name has to be unique';
                        }
                        emailError = errorText;
                      }
                      setState(() {});
                    }
                  },
                  child: FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (String? val) async {
                      projectUser.userEmail = val;
                      await projectUser.save();
                      setState(() {});
                    },
                    validator: FormBuilderValidators.compose([
                      (_) => emailError,
                      FormBuilderValidators.required(context),
                    ]),
                    keyboardType: TextInputType.text,
                    initialValue: projectUser.userEmail ?? '',
                  ),
                ),
                FormBuilderRadioGroup<String?>(
                  name: 'role',
                  validator: (_) => roleError,
                  onChanged: (choosen) async {
                    if (choosen == projectUser.role) choosen = null;
                    print('choosen: $choosen');
                    projectUser.role = choosen;
                    try {
                      await projectUser.save();
                      roleError = null;
                    } catch (e) {
                      print(e);
                      roleError = e.toString();
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'Role',
                  ),
                  initialValue: projectUser.role,
                  options: roleTypes
                      .map((roleType) => FormBuilderFieldOption(
                          value: roleType.value as String))
                      .toList(growable: false),
                  orientation: OptionsOrientation.vertical,
                )
              ],
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
