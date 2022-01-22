import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RadioGroupWidget extends StatefulWidget {
  final Crow row;
  final Field field;

  RadioGroupWidget({
    required this.row,
    required this.field,
  });

  @override
  _RadioGroupWidgetState createState() => _RadioGroupWidgetState();
}

class _RadioGroupWidgetState extends State<RadioGroupWidget> {
  final Isar isar = Get.find<Isar>();
  final RxString errorText = ''.obs;

  @override
  void initState() {
    super.initState();

    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Field field = widget.field;

    List<Crow> options = isar.crows
        .filter()
        .tableIdEqualTo(field.optionsTable ?? '')
        .findAllSync();
    List<String> optionsList = options
        .map((option) {
          Map data = option.getData();
          return data['value'];
        })
        .where((e) => e != null)
        .map((e) => e as String)
        .toSet()
        .toList();
    Map<String, dynamic> data = widget.row.getData();

    return FormBuilderRadioGroup<String?>(
      key: Key('${field.id}/${data['${field.name}']?.toString() ?? ''}'),
      name: field.id,
      validator: (_) {
        if (errorText.value != '') return errorText.value;
        return null;
      },
      onChanged: (choosen) async {
        if (choosen == data['${field.name}']) choosen = null;
        //print('choosen: $choosen');
        data['${field.name}'] = choosen;
        widget.row.data = json.encode(data);
        try {
          await widget.row
              .saveData(fieldName: field.name ?? '', value: choosen);
          errorText.value = '';
        } catch (e) {
          print(e);
          errorText.value = e.toString();
        }
      },
      decoration: InputDecoration(labelText: field.label ?? field.name),
      initialValue:
          data['${field.name}'] != null ? data['${field.name}'] : null,
      options: optionsList.map((option) {
        return FormBuilderFieldOption(value: option);
      }).toList(growable: false),
      orientation: OptionsOrientation.vertical,
    );
  }
}
