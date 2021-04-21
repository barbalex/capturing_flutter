import 'package:capturing/models/operation.dart';
import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/isar.g.dart';

class NewProject extends StatelessWidget {
  final name = ''.obs;
  final Isar isar = Get.find<Isar>();

  void onPressAdd() async {
    Project newProject = Project(
      name: name.value,
    );
    await isar.writeTxn((isar) async {
      await isar.projects.put(newProject);
      await isar.operations.put(
        Operation(table: 'projects').setData(newProject.toMap()),
      );
    });
    Project project = await isar.projects
            .where()
            .filter()
            .nameEqualTo(name.value)
            .findFirst() ??
        newProject;
    Get.offAndToNamed('/projects/${project.isarId}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add Project',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name.value = value;
                  },
                ),
                SizedBox(height: 15),
                OutlinedButton(
                  onPressed: onPressAdd,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
