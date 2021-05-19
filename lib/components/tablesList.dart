import 'package:capturing/store.dart';
import 'package:flutter/material.dart';
import 'package:capturing/components/tableTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';

class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> tableListener;
  final String projectId = Get.parameters['projectId'] ?? '';

  @override
  void initState() {
    super.initState();
    tableListener = isar.ctables
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(projectId)
        .and()
        // show option tables only when editing structure
        .optional(
            editingProject.value != projectId, (q) => q.optionTypeEqualTo(null))
        .watchLazy()
        .listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tableListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.ctables
          .where()
          .filter()
          .projectIdEqualTo(projectId)
          .and()
          .deletedEqualTo(false)
          .and()
          // show option tables only when editing structure
          .optional(editingProject.value != projectId,
              (q) => q.optionTypeEqualTo(null))
          .sortByName()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                return TableTile(
                  table: snapshot.data[index],
                );
              },
              itemCount: snapshot.data.length,
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
