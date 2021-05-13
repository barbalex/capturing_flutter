import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/dbOperation.dart';

class NameWidget extends StatelessWidget {
  final Ctable table;

  NameWidget({required this.table});

  final Isar isar = Get.find<Isar>();
  final String tableId = Get.parameters['tableId'] ?? '0';

  final RxBool nameIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = table.name ?? '';

    return Obx(
      () => Focus(
        onFocusChange: (hasFocus) async {
          if (!hasFocus && nameIsDirty.value == true) {
            // set label too if is empty
            if (table.label == null) {
              table.label = table.name;
            }
            try {
              await isar.writeTxn((_) async {
                await isar.ctables.put(table);
                await isar.dbOperations.put(DbOperation(table: 'tables')
                    .setData(table.toMapFromModel()));
              });
              nameIsDirty.value = false;
              if (nameErrorText.value != '') {
                nameErrorText.value = '';
              }
            } catch (e) {
              String errorText = e.toString();
              if (errorText.contains('Unique index violated')) {
                errorText = 'The name has to be unique';
              }
              nameErrorText.value = errorText;
            }
          }
        },
        child: TextField(
          controller: nameController,
          onChanged: (value) async {
            table.name = value;
            nameIsDirty.value = true;
          },
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: nameErrorText.value != '' ? nameErrorText.value : null,
          ),
          //autofocus: true,
        ),
      ),
    );
  }
}
