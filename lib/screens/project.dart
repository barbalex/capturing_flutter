import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/dbOperation.dart';

class ProjectWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '';
  final RxBool dirty = false.obs;
  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;

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
            int ownIndex = projects.indexOf(project);
            bool existsNextProject = projects.length > ownIndex + 1;
            Project? nextProject =
                existsNextProject ? projects[ownIndex + 1] : null;
            bool existsPreviousProject = ownIndex > 0;
            Project? previousProject =
                existsPreviousProject ? projects[ownIndex - 1] : null;
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
              bottomNavigationBar: Obx(() => BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map),
                        label: 'Map',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.arrow_upward,
                        ),
                        label: 'List',
                      ),
                      existsPreviousProject
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_back),
                              label: 'Previous',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'New',
                            ),
                      existsNextProject
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_forward),
                              label: 'Next',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'New',
                            ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.arrow_downward),
                        label: 'Tables',
                      ),
                    ],
                    currentIndex: bottomBarIndex.value,
                    onTap: (index) async {
                      bottomBarIndex.value = index;
                      switch (index) {
                        case 0:
                          print('TODO:');
                          break;
                        case 1:
                          Get.toNamed('/projects/');
                          break;
                        case 2:
                          {
                            if (!existsPreviousProject) {
                              Project newProject = Project();
                              await newProject.create();
                              Get.toNamed('/projects/${newProject.id}');
                              break;
                            }
                            Get.toNamed('/projects/${previousProject?.id}');
                            break;
                          }
                        case 3:
                          {
                            if (!existsNextProject) {
                              Project newProject = Project();
                              await newProject.create();
                              Get.toNamed('/projects/${newProject.id}');
                              break;
                            }
                            Get.toNamed('/projects/${nextProject?.id}');
                            break;
                          }
                        case 4:
                          Get.toNamed('/projects/${project.id}/tables/');
                          break;
                      }
                    },
                  )),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
