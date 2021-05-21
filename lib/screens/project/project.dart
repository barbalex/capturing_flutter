import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/screens/project/bottomNavBar.dart';

class ProjectWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '';

  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    //print('project, id: $id');
    return FutureBuilder(
      //future: isar.projects.where().idEqualTo(id).findFirst(),
      future: isar.projects
          .where()
          .filter()
          .deletedEqualTo(false)
          .sortByName()
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
            List<Project> projects = snapshot.data;
            Project project = projects.where((p) => p.id == id).first;
            var nameTxt = TextEditingController();
            nameTxt.text = project.name ?? '';
            var labelTxt = TextEditingController();
            labelTxt.text = project.label ?? '';

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Project'),
              ),
              body: Center(
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
                                await isar.dbOperations.put(
                                    DbOperation(table: 'projects')
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
                            errorText: nameErrorText.value != ''
                                ? nameErrorText.value
                                : null,
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
              ),
              bottomNavigationBar: BottomNavBar(projects: projects),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
