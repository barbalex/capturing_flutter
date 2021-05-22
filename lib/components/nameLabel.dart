import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recase/recase.dart';

class NameLabelWidget extends StatefulWidget {
  final dynamic dataset;

  NameLabelWidget({required this.dataset});

  @override
  _NameLabelWidgetState createState() => _NameLabelWidgetState();
}

class _NameLabelWidgetState extends State<NameLabelWidget> {
  @override
  Widget build(BuildContext context) {
    dynamic dataset = widget.dataset;
    TextEditingController nameController = TextEditingController();
    nameController.text = dataset.name ?? '';
    String? label = dataset.label;
    String? labelErrorText;

    return Center(
      child: Column(
        children: <Widget>[
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus && label != dataset.label) {
                try {
                  dataset.label = label;
                  dataset.name =
                      label != null ? ReCase(label as String).snakeCase : null;
                  await dataset.save();
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
              initialValue: dataset.label ?? '',
            ),
          ),
          SizedBox(
            height: 6,
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
