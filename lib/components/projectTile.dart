import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

class ProjectTile extends StatelessWidget {
  final int index;
  final Isar isar = Get.find<Isar>();

  ProjectTile({this.index = 0});

  @override
  Widget build(BuildContext context) {
    final projects = isar.projects;

    return FutureBuilder(
      future: projects.get(index),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'An error happened',
              snapshot.error.toString(),
            );
          } else {
            return Dismissible(
              key: Key(index.toString()),
              // Show a red background as the item is swiped away.
              background: Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Text('dismissing',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
              onDismissed: (direction) {
                isar.writeTxn((isar) async {
                  await snapshot.data.delete();
                });
                // Show a snackbar. This snackbar could also contain "Undo" actions.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${snapshot.data!.name} dismissed"),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  snapshot.data!.name!,
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
