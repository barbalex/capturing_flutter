import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
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
    //print('date field');
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
        onChanged: (Object choosen) async {
          print('choosen: $choosen');
          if (choosen != null) {
            // final DateFormat formatter = DateFormat('M/d/yyyy');
            // final String formatted = formatter.format(choosen);
            // if (formatted == value.value) return;
            // value.value = formatted;
            // data['${field.name}'] = formatted;
            // row.data = json.encode(data);
            // // TODO: accept null to empty field?
            // try {
            //   await row.save(field: field.name ?? '', value: formatted);
            //   if (errorText.value != '') {
            //     errorText.value = '';
            //   }
            // } catch (e) {
            //   print(e);
            //   errorText.value = e.toString();
            // }
          }
        },
        decoration: InputDecoration(
          labelText: field.name,
        ),
        initialValue:
            data['${field.name}'] != null ? data['${field.name}'] : null,
      ),
    );
  }
}
