import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';

class ProjectWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String isarIdString = Get.parameters['isarId'] ?? '0';

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
                    TextField(
                      controller: nameTxt,
                      onChanged: (value) async {
                        project.name = value;
                        await isar.writeTxn((_) async {
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
                        project.label = value;
                        await isar.writeTxn((_) async {
                          isar.projects.put(project);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Label',
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
