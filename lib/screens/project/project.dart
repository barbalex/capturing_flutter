import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/project.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  final nameErrorText = ''.obs;
  final label = ''.obs;
  final labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    Project project = widget.projects.where((p) => p.id == id).first;
    ever(nameErrorText, (_) {
      setState(() {});
    });
    ever(labelErrorText, (_) {
      setState(() {});
    });

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus && name.value != project.name) {
                try {
                  project.name = name.value;
                  project.save();
                  nameErrorText.value = '';
                } catch (e) {
                  print(e);
                  String errorText = e.toString();
                  if (errorText.contains('Unique index violated')) {
                    errorText = 'The name has to be unique';
                  }
                  nameErrorText.value = errorText;
                }
              }
            },
            child: FormBuilderTextField(
              name: 'name',
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (String? val) {
                name.value = val == null ? '' : val;
              },
              validator: FormBuilderValidators.compose([
                (_) => nameErrorText.value != '' ? nameErrorText.value : null,
                FormBuilderValidators.required(context),
              ]),
              keyboardType: TextInputType.emailAddress,
              initialValue: project.name ?? '',
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus && label.value != project.label) {
                try {
                  project.label = label.value;
                  project.save();
                  labelErrorText.value = '';
                } catch (e) {
                  labelErrorText.value = e.toString();
                }
              }
            },
            child: FormBuilderTextField(
              name: 'label',
              decoration: InputDecoration(labelText: 'Label'),
              onChanged: (String? val) {
                label.value = val == null ? '' : val;
              },
              validator: FormBuilderValidators.compose([
                (_) => labelErrorText.value != '' ? labelErrorText.value : null,
                FormBuilderValidators.required(context),
              ]),
              keyboardType: TextInputType.emailAddress,
              initialValue: project.label ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
