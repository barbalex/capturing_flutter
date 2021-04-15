import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/components/newProject.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:isar/isar.dart';

class Projects extends StatelessWidget {
  static const String id = 'capturing_screen';

  final AuthController controller = Get.find<AuthController>();
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
            tooltip: 'logout',
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
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ProjectList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => NewProject(),
          );
        },
      ),
    );
  }
}
