import 'package:flutter/material.dart';
import 'package:capturing/components/projectTile.dart';
import 'package:capturing/models/project.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

class ProjectList extends StatelessWidget {
  final List<Project>? projects;
  ProjectList(this.projects);
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.projects.where().count(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('connectionstate is done');
          if (snapshot.hasError) {
            print('pshot.has');
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ProjectTile(
                  index: index,
                );
              },
              itemCount: snapshot.data,
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
