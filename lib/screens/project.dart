import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';

class ProjectWidget extends StatefulWidget {
  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  final Isar isar = Get.find<Isar>();
  final String id = Get.parameters['id'] ?? '0';
  final RxBool dirty = false.obs;
  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    //print('project, id: $id');
    return FutureBuilder(
      future: isar.projects.where().idEqualTo(id).findFirst(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Project project = snapshot.data;
            var nameTxt = TextEditingController();
            nameTxt.text = project.name ?? '';
            var labelTxt = TextEditingController();
            labelTxt.text = project.label ?? '';

            return Scaffold(
              appBar: AppBar(
                leading: null,
                title: Row(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          size: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Text('Project'),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Focus(
                      onFocusChange: (hasFocus) async {
                        if (!hasFocus && nameIsDirty.value == true) {
                          try {
                            await isar.writeTxn((_) async {
                              isar.projects.put(project);
                            });
                            nameIsDirty.value = false;
                            if (nameErrorText.value != '') {
                              nameErrorText.value = '';
                              setState(() {});
                            }
                          } catch (e) {
                            String errorText = e.toString();
                            if (errorText.contains('Unique index violated')) {
                              errorText = 'The name has to be unique';
                            }
                            nameErrorText.value = errorText;
                            setState(() {});
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
                        autofocus: true,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Focus(
                      onFocusChange: (hasFocus) async {
                        if (!hasFocus && labelIsDirty.value == true) {
                          try {
                            await isar.writeTxn((_) async {
                              isar.projects.put(project);
                            });
                            labelIsDirty.value = false;
                            if (labelErrorText.value != '') {
                              labelErrorText.value = '';
                              setState(() {});
                            }
                          } catch (e) {
                            labelErrorText.value = e.toString();
                            setState(() {});
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
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
