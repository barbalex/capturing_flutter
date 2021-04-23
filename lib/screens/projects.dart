import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/store.dart';
import 'package:animate_do/animate_do.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final AuthController authController = Get.find<AuthController>();
  Rx<String?> token = Rx<String?>(null);

  @override
  void initState() {
    super.initState();
    token = authController.token;
  }

  @override
  Widget build(BuildContext context) {
    print('projects, building, editingStructure: ${editingStructure.value}');
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Obx(
              () => SpinPerfect(
                animate: editingStructure.value,
                duration: Duration(seconds: 4000000000),
                spins: 1000000000,
                child: Icon(
                  Icons.build,
                ),
              ),
            ),
            onPressed: () {
              editingStructure.value = !editingStructure.value;
            },
            tooltip: 'Edit data structure',
          ),
        ],
        title: Row(
          children: <Widget>[
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
            Text('Projects'),
          ],
        ),
      ),
      body: ProjectList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          Project newProject = Project();
          await newProject.create();
          Get.toNamed('/projects/${newProject.id}');
        },
      ),
    );
  }
}
