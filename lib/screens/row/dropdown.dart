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
  final data = <String, dynamic>{}.obs;
  final value = ''.obs;
  final RxBool isDirty = false.obs;
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
            List<Crow> rows = snapshot.data;
            Map<String, dynamic> rowMap = row.toMapFromServer();
            Map<String, dynamic> _data = {};
            // somehow
            // when fetched from server data is encoded TWICE
            // but not when saved in app...
            if (rowMap['data'] != null) {
              var temp = rowMap['data'];
              while (temp.runtimeType == String) {
                temp = json.decode(temp);
              }
              _data = temp;
            }

            data.value = Map<String, dynamic>.from(_data);
            value.value = data['${field.name}'] ?? '';

            return Obx(
              () => FormBuilderDropdown(
                name: field.name ?? 'dropdown',
                onChanged: (choosen) async {
                  if (choosen == value.value) return;
                  value.value = choosen == null ? '' : choosen as String;
                  data['${field.name}'] = choosen;
                  row.data = json.encode(data);
                  try {
                    await row.save(field: field.name ?? '', value: choosen);
                    if (errorText.value != '') {
                      errorText.value = '';
                    }
                  } catch (e) {
                    print(e);
                    errorText.value = e.toString();
                  }
                },
                decoration: InputDecoration(
                  labelText: field.name,
                ),
                initialValue: data['${field.name}'] != null
                    ? data['${field.name}']
                    : null,
                items: rows.map((row) {
                  Map data = row.getData();
                  return DropdownMenuItem(
                    value: data['value'],
                    child: Text(data['value']),
                  );
                }).toList(),
                allowClear: true,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
