import 'package:flutter/material.dart';
import 'package:capturing/components/projectTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

class ProjectList extends StatefulWidget {
  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    final updateState = () {
      setState(() {});
    };
    isar.projects.watchLazy().listen((event) {
      updateState();
    });

    return FutureBuilder(
      future: isar.projects.where().findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ProjectTile(
                  project: snapshot.data[index],
                  updateState: updateState,
                );
              },
              itemCount: snapshot.data.length, // TODO:
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
