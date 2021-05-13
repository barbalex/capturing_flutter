import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/dbOperation.dart';

class LabelWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  final Ctable table;

  LabelWidget({required this.table});

  final RxBool labelIsDirty = false.obs;
  final RxString labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    TextEditingController labelController = TextEditingController();
    labelController.text = table.label ?? '';

    return Obx(
      () => Focus(
        onFocusChange: (hasFocus) async {
          if (!hasFocus && labelIsDirty.value == true) {
            try {
              await isar.writeTxn((_) async {
                await isar.ctables.put(table);
                await isar.dbOperations.put(DbOperation(table: 'tables')
                    .setData(table.toMapFromModel()));
              });
              labelIsDirty.value = false;
              if (labelErrorText.value != '') {
                labelErrorText.value = '';
              }
            } catch (e) {
              labelErrorText.value = e.toString();
            }
          }
        },
        child: TextField(
          controller: labelController,
          onChanged: (value) async {
            table.label = value;
            labelIsDirty.value = true;
          },
          decoration: InputDecoration(
            labelText: 'Label',
            errorText: labelErrorText.value != '' ? labelErrorText.value : null,
          ),
        ),
      ),
    );
  }
}
