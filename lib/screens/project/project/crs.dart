import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/models/project.dart';

class CrsWidget extends StatefulWidget {
  final Project project;

  CrsWidget({required this.project});

  @override
  _CrsWidgetState createState() => _CrsWidgetState();
}

class _CrsWidgetState extends State<CrsWidget> {
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
    String? errorText;
    String? crs;

    return Center(
      child: Column(
        children: <Widget>[
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus) {
                try {
                  // remove symbols and convert to snake_case
                  project.crs = crs == null
                      ? null
                      : crs == ''
                          ? null
                          : int.parse(crs ?? '');
                  await project.save();
                  errorText = null;
                } catch (e) {
                  errorText = e.toString();
                }
                setState(() {});
              }
            },
            child: FormBuilderTextField(
              name: 'crs',
              decoration: InputDecoration(labelText: 'CRS'),
              onChanged: (String? val) {
                crs = val ?? '';
              },
              validator: FormBuilderValidators.compose([(_) => errorText]),
              keyboardType: TextInputType.number,
              initialValue: project.crs.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
