import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:uuid/uuid.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/isar.g.dart';

class NewProject extends StatelessWidget {
  final name = ''.obs;
  final uuid = Uuid();
  final Isar isar = Get.find<Isar>();

  void onPressAdd() async {
    final IsarCollection<Project> projects = isar.projects;
    print('1');
    Project project = Project(
      id: 0, // TODO: autoincrement
      serverId: uuid.v1(),
      name: name.value,
    );
    print('2');
    await isar.writeTxn((isar) async {
      await projects.put(project);
    });
    print('3');
    Get.back();
    print('4');
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
                    color: Colors.lightBlueAccent,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name.value = value;
                  },
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: onPressAdd,
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
