import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recase/recase.dart';
import 'package:get/get.dart';

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
              // print('namelabel, onFocusChange, hasFocus: $hasFocus');
              if (!hasFocus && label != dataset.label) {
                try {
                  // print(
                  //     'namelabel, onFocusChange, will set dataset.label to: $label');
                  dataset.label = label;
                  // remove symbols and convert to snake_case
                  dataset.name = label != null
                      ? ReCase(label?.replaceAll(RegExp(r'[^\w\s]+'), '') ?? '')
                          .snakeCase
                      : null;
                  await dataset.saveData();
                  labelErrorText = null;
                } catch (e) {
                  print(e);
                  String errorText = e.toString();
                  if (errorText.contains('Unique index violated')) {
                    errorText = 'The name has to be unique'.tr;
                  }
                  labelErrorText = errorText;
                }
                setState(() {});
              }
            },
            child: FormBuilderTextField(
              name: 'label',
              decoration:
                  InputDecoration(labelText: 'Label (user-friendly)'.tr),
              onChanged: (String? val) {
                // print('onChangedLabel, will set label to: $val');
                String? valToSet = val == '' ? null : val;
                // print('onChangedLabel, valToSet: $valToSet');
                // print('onChangedLabel, valToSet is null: ${valToSet == null}');
                label = valToSet;
              },
              validator: FormBuilderValidators.compose([
                (_) => labelErrorText,
                //FormBuilderValidators.required(context),
              ]),
              keyboardType: TextInputType.text,
              initialValue: dataset.label ?? '',
            ),
          ),
          SizedBox(height: 6),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Database-friendly Name (set automatically)'.tr,
            ),
            readOnly: true,
            enabled: false,
          ),
        ],
      ),
    );
  }
}
