import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';

class ProjectWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['projectId'] ?? '0';
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
              body: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Obx(
                      () => Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus && nameIsDirty.value == true) {
                            try {
                              await isar.writeTxn((_) async {
                                isar.projects.put(project);
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
                          controller: nameTxt,
                          onChanged: (value) async {
                            project.name = value;
                            nameIsDirty.value = true;
                          },
                          onEditingComplete: () => print('onEditingComplete'),
                          onSubmitted: (_) => print('onSubmitted'),
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
                        label: 'Up to List',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.arrow_back,
                          color: existsPreviousProject
                              ? Colors.white
                              : Colors.purple.shade800,
                        ),
                        label: 'Previous',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: existsNextProject
                              ? Colors.white
                              : Colors.purple.shade800,
                        ),
                        label: 'Next',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.arrow_downward),
                        label: 'Children',
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
                          Get.toNamed('/projects');
                          break;
                        case 2:
                          {
                            if (!existsPreviousProject) {
                              Get.snackbar(
                                'First Project reached',
                                'There is no previous',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              break;
                            }
                            Get.toNamed('/projects/${previousProject?.id}');
                            break;
                          }
                        case 3:
                          {
                            if (!existsNextProject) {
                              Get.snackbar(
                                'Last Project reached',
                                'There is no next',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              break;
                            }
                            Get.toNamed('/projects/${nextProject?.id}');
                            break;
                          }
                        case 4:
                          Get.toNamed('/projects/${project.id}/tables');
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
