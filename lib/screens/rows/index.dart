import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/screens/rows/list.dart';
import 'package:capturing/screens/rows/bottomNavBar.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/tree/index.dart';

class RowsContainer extends StatelessWidget {
  final String? tableId = activeTableId;
  final Isar isar = Get.find<Isar>();
  final Function goUp;

  RowsContainer({required this.goUp});

  @override
  Widget build(BuildContext context) {
    Ctable? table =
        isar.ctables.where().filter().idEqualTo(tableId ?? '').findFirstSync();
    Project? project = isar.projects
        .where()
        .filter()
        .idEqualTo(activeProjectId ?? '')
        .findFirstSync();
    String label = table?.getLabel() ?? project?.getLabel() ?? '';

    return WillPopScope(
      onWillPop: () async {
        await goUp();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(label),
        ),
        drawer: Drawer(
          child: Tree(),
          semanticLabel: 'Tree view of the data structure',
        ),
        body: RowsList(table: table),
        bottomNavigationBar: RowsBottomNavBar(
          goUp: goUp,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () async {
            List<String> urlCopied = [...url];
            // remove last rows folder
            urlCopied.removeLast();
            int indexOfLastRowsFolder =
                urlCopied.lastIndexWhere((e) => e == '/rows/');
            String? parentRowId = indexOfLastRowsFolder == -1
                ? null
                : urlCopied.length > indexOfLastRowsFolder
                    ? urlCopied[indexOfLastRowsFolder + 1]
                    : null;
            Crow newRow = Crow(tableId: tableId, parentId: parentRowId);
            await newRow.create();
            url.value = [...url, newRow.id];
          },
          tooltip: 'Add Row',
        ),
      ),
    );
  }
}
