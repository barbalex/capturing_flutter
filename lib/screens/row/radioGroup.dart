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
  Widget build(BuildContext context) {
    ever(errorText, (_) {
      setState(() {});
    });

    return FutureBuilder(
      future: isar.crows
          .where()
          .filter()
          .tableIdEqualTo(widget.field.optionsTable ?? '')
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
            List<Crow> options = snapshot.data;
            Map<String, dynamic> data = widget.row.getData();
            //print('DropdownWidget, options: $options, data: $data');

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
                      .save(fieldName: widget.field.name ?? '', value: choosen);
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
        return CircularProgressIndicator();
      },
    );
  }
}