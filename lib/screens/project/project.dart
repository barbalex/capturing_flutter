import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/dbOperation.dart';

class ProjectWidget extends StatelessWidget {
  final List<Project> projects;

  ProjectWidget({required this.projects});

  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '';

  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    Project project = projects.where((p) => p.id == id).first;
    TextEditingController nameTxt = TextEditingController();
    nameTxt.text = project.name ?? '';
    TextEditingController labelTxt = TextEditingController();
    labelTxt.text = project.label ?? '';

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          Obx(
            () => Focus(
              onFocusChange: (hasFocus) async {
                if (!hasFocus && nameIsDirty.value == true) {
                  try {
                    await isar.writeTxn((_) async {
                      isar.projects.put(project);
                      await isar.dbOperations.put(DbOperation(table: 'projects')
                          .setData(project.toMap()));
                    });
                    nameIsDirty.value = false;
                    if (nameErrorText.value != '') {
                      nameErrorText.value = '';
                    }
                  } catch (e) {
                    print(e);
                    String errorText = e.toString();
                    if (errorText.contains('Unique index violated')) {
                      errorText = 'The name has to be unique';
                    }
                    nameErrorText.value = errorText;
                  }
                }
              },
              child: TextField(
                controller: nameTxt,
                onChanged: (value) async {
                  if (value == '') {
                    nameErrorText.value = 'a name is required';
                    return;
                  }
                  project.name = value;
                  nameIsDirty.value = true;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText:
                      nameErrorText.value != '' ? nameErrorText.value : null,
                ),
                //autofocus: true,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Obx(() => Focus(
                onFocusChange: (hasFocus) async {
                  if (!hasFocus && labelIsDirty.value == true) {
                    try {
                      await isar.writeTxn((_) async {
                        isar.projects.put(project);
                        await isar.dbOperations.put(
                            DbOperation(table: 'projects')
                                .setData(project.toMap()));
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
                  controller: labelTxt,
                  onChanged: (value) async {
                    project.label = value;
                    labelIsDirty.value = true;
                  },
                  decoration: InputDecoration(
                    labelText: 'Label',
                    errorText: labelErrorText.value != ''
                        ? labelErrorText.value
                        : null,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
