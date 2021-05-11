import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropdownWidget extends StatelessWidget {
  final Crow row;
  final Field field;

  DropdownWidget({
    required this.row,
    required this.field,
  });

  final Isar isar = Get.find<Isar>();
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.crows
          .where()
          .filter()
          .tableIdEqualTo(field.optionsTable ?? '')
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
            Map<String, dynamic> data = row.getData();

            return FormBuilderDropdown(
              name: field.name ?? 'dropdown',
              validator: (_) {
                if (errorText.value != '') return errorText.value;
                return null;
              },
              onChanged: (choosen) async {
                if (choosen == data['${field.name}']) return;
                data['${field.name}'] = choosen;
                row.data = json.encode(data);
                try {
                  await row.save(field: field.name ?? '', value: choosen);
                  errorText.value = '';
                } catch (e) {
                  print(e);
                  errorText.value = e.toString();
                }
              },
              decoration: InputDecoration(
                labelText: field.name,
              ),
              initialValue:
                  data['${field.name}'] != null ? data['${field.name}'] : null,
              items: options.map((option) {
                Map data = option.getData();
                return DropdownMenuItem(
                  value: data['value'],
                  child: Text(data['value']),
                );
              }).toList(),
              allowClear: true,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
