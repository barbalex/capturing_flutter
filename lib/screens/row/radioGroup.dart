import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
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
    List<Crow> options = isar.crows
        .where()
        .filter()
        .tableIdEqualTo(widget.field.optionsTable ?? '')
        .findAllSync();
    Map<String, dynamic> data = widget.row.getData();

    return FormBuilderRadioGroup<String?>(
      name: widget.field.id,
      validator: (_) {
        if (errorText.value != '') return errorText.value;
        return null;
      },
      onChanged: (choosen) async {
        if (choosen == data['${widget.field.name}']) choosen = null;
        print('choosen: $choosen');
        data['${widget.field.name}'] = choosen;
        widget.row.data = json.encode(data);
        try {
          await widget.row
              .saveData(fieldName: widget.field.name ?? '', value: choosen);
          errorText.value = '';
        } catch (e) {
          print(e);
          errorText.value = e.toString();
        }
      },
      decoration: InputDecoration(
        labelText: widget.field.label ?? widget.field.name,
      ),
      initialValue: data['${widget.field.name}'] != null
          ? data['${widget.field.name}']
          : null,
      options: options.map((option) {
        Map data = option.getData();
        return FormBuilderFieldOption(value: data['value'] as String);
      }).toList(growable: false),
      orientation: OptionsOrientation.vertical,
    );
  }
}
