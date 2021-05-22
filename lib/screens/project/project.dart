import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recase/recase.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;

  ProjectWidget({required this.project});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
    TextEditingController nameController = TextEditingController();
    nameController.text = project.name ?? '';
    String? label = project.label;
    String? labelErrorText;

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus && label != project.label) {
                try {
                  project.label = label;
                  project.name =
                      label != null ? ReCase(label as String).snakeCase : null;
                  await project.save();
                  labelErrorText = null;
                } catch (e) {
                  labelErrorText = e.toString();
                }
                setState(() {});
              }
            },
            child: FormBuilderTextField(
              name: 'label',
              decoration: InputDecoration(labelText: 'Name (user-friendly)'),
              onChanged: (String? val) {
                label = val ?? '';
              },
              validator: FormBuilderValidators.compose([
                (_) => labelErrorText,
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
