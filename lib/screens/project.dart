import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';

class ProjectWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String isarIdString = Get.parameters['isarId'] ?? '0';
  final Rx<String> name = ''.obs;
  final Rx<String> label = ''.obs;

  @override
  Widget build(BuildContext context) {
    int id = int.parse(isarIdString);

    return FutureBuilder(
      future: isar.projects.get(id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
            );
          } else {
            Project project = snapshot.data;
            print(
                'project, data: name: ${snapshot.data.name}, label: ${snapshot.data.label}');
            print('project, data: name: ${snapshot.data}');
            print('project: ${project}');
            name.value = project.name ?? '';
            var nameTxt = TextEditingController();
            nameTxt.text = name.value;
            label.value = project.label ?? '';
            var labelTxt = TextEditingController();
            labelTxt.text = label.value;

            return Scaffold(
              appBar: AppBar(
                leading: null,
                title: Text('Register'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: nameTxt,
                    onChanged: (value) async {
                      name.value = value;
                      await isar.writeTxn((_) async {
                        Project project = snapshot.data;
                        project.name = value;
                        isar.projects.put(project);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: labelTxt,
                    onChanged: (value) async {
                      label.value = value;
                      Project project = snapshot.data;
                      project.label = value;
                      await isar.writeTxn((_) async {
                        isar.projects.put(project);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Label',
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  OutlinedButton(
                    child: Text('save'),
                    onPressed: () async {
                      // await isar.writeTxn(()  {
                      //   //await project.save();
                      // });
                    },
                  ),
                ],
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
