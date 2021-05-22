import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/project.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recase/recase.dart';

class ProjectWidget extends StatefulWidget {
  final List<Project> projects;

  ProjectWidget({required this.projects});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '';
  final name = ''.obs;
  final label = ''.obs;
  final labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    Project project = widget.projects.where((p) => p.id == id).first;
    TextEditingController nameController = TextEditingController();
    nameController.text = project.name ?? '';

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus && label.value != project.label) {
                try {
                  project.label = label.value == '' ? null : label.value;
                  name.value =
                      label.value == '' ? '' : ReCase(label.value).snakeCase;
                  project.name = name.value == '' ? null : name.value;
                  await project.save();
                  if (labelErrorText.value != '') {
                    labelErrorText.value = '';
                  }
                } catch (e) {
                  labelErrorText.value = e.toString();
                }
                setState(() {});
              }
            },
            child: FormBuilderTextField(
              name: 'label',
              decoration: InputDecoration(labelText: 'Name (user-friendly)'),
              onChanged: (String? val) {
                label.value = val ?? '';
              },
              validator: FormBuilderValidators.compose([
                (_) => labelErrorText.value != '' ? labelErrorText.value : null,
                FormBuilderValidators.required(context),
              ]),
              keyboardType: TextInputType.text,
              initialValue: project.label ?? '',
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Database-friendly Name (set automatically)',
            ),
            readOnly: true,
            enabled: false,
          ),
        ],
      ),
    );
  }
}
