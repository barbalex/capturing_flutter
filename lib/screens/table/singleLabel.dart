import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recase/recase.dart';
import 'package:capturing/models/table.dart';
import 'package:get/get.dart';

class SingleLabelWidget extends StatefulWidget {
  final Ctable table;

  SingleLabelWidget({required this.table});

  @override
  _SingleLabelWidgetState createState() => _SingleLabelWidgetState();
}

class _SingleLabelWidgetState extends State<SingleLabelWidget> {
  @override
  Widget build(BuildContext context) {
    Ctable table = widget.table;
    String? singleLabel = table.singleLabel;
    String? singleLabelErrorText;

    return Center(
      child: Column(
        children: <Widget>[
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus && singleLabel != table.singleLabel) {
                try {
                  table.singleLabel = singleLabel;
                  // remove symbols and convert to snake_case
                  table.name = singleLabel != null
                      ? ReCase(singleLabel?.replaceAll(
                                  RegExp(r'[^\w\s]+'), '') ??
                              '')
                          .snakeCase
                      : null;
                  await table.save();
                  singleLabelErrorText = null;
                } catch (e) {
                  String errorText = e.toString();
                  if (errorText.contains('Unique index violated')) {
                    errorText = 'The name has to be unique'.tr;
                  }
                  singleLabelErrorText = errorText;
                }
                setState(() {});
              }
            },
            child: FormBuilderTextField(
              name: 'singleLabel',
              decoration: InputDecoration(labelText: 'Label for a single row'),
              onChanged: (String? val) {
                singleLabel = val ?? '';
              },
              validator: FormBuilderValidators.compose([
                (_) => singleLabelErrorText,
              ]),
              keyboardType: TextInputType.text,
              initialValue: table.singleLabel ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
