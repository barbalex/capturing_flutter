import 'package:capturing/store.dart';
import 'package:flutter/material.dart';
import 'package:capturing/screens/tables/noneditable/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/table.dart';

class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> tableListener;
  final String projectId = activeProjectId ?? '';

  @override
  void initState() {
    super.initState();
    tableListener = isar.ctables
        .where()
        .filter()
        .projectIdEqualTo(projectId)
        .and()
        .parentIdIsNull()
        .and()
        .deletedEqualTo(false)
        .and()
        // show tables with parent id only when editing structure
        .optional(editingProject.value != projectId, (q) => q.parentIdIsNull())
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
    //print('Table List, build, parentTableId: $parentTableId');
    return FutureBuilder(
      future: isar.ctables
          .where()
          .filter()
          .projectIdEqualTo(projectId)
          .and()
          .deletedEqualTo(false)
          .and()
          // show tables with parent id only when editing structure
          .optional(
              editingProject.value != projectId, (q) => q.parentIdIsNull())
          .and()
          // show option tables only when editing structure
          .optional(
              editingProject.value != projectId, (q) => q.optionTypeIsNull())
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
            List<Ctable> tables = snapshot.data;
            //print('TablesList, tables: $tables, projectId: $projectId');

            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TableTile(
                      table: tables[index],
                    ),
                    Divider(
                      height: 0,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ],
                );
              },
              itemCount: tables.length,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
