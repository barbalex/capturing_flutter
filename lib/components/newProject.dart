import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';

class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final name = ''.obs;
  final errorText = ''.obs;

  final Isar isar = Get.find<Isar>();

  void onPressAdd() async {
    errorText.value = '';
    try {
      Project newProject = Project(name: name.value);
      await newProject.create();
      Get.offAndToNamed('/projects/${newProject.id}');
    } catch (e) {
      errorText.value = e.toString();
      setState(() {});
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('newProject, errorText: ${errorText.value}');
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
                    errorText: errorText.value != '' ? errorText.value : null,
                  ),
                  autofocus: true,
                  //textAlign: TextAlign.center,
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
