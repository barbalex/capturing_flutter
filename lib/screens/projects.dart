import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/components/newProject.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:isar/isar.dart';

class Projects extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('TODO:');
            },
            tooltip: 'Menu',
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
