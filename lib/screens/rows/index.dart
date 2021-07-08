import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/screens/rows/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/screens/tree/index.dart';

class RowsListContainer extends StatelessWidget {
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;
  final Isar isar = Get.find<Isar>();

  goUp() async {
    List<String> newUrl = [...url];
    if (url.length.isEven && url.length > 0) {
      // this is a row > go up to it's list
      newUrl.removeLast();
    } else if (url.length == 5) {
      // up four, if grandParent is project and only one table exists
      // else: up two
      int parentTablesCount = 0;
      // only check parent if url is long enough
      String? grandParentType = url.length > 4 ? url[url.length - 5] : null;
      String? grandParentId = url.length > 3 ? url[url.length - 4] : null;
      if (grandParentType == '/projects/') {
        parentTablesCount = await isar.ctables
            .where()
            .filter()
            .projectIdEqualTo(grandParentId)
            .and()
            .parentIdIsNull()
            .and()
            .deletedEqualTo(false)
            .and()
            .optionTypeEqualTo(null)
            .count();
      }
      if (newUrl.length > 3) {
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
      }
      if (parentTablesCount == 1 && newUrl.length > 3) {
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
      }
    } else {
      // if grandParent is not project, never go up four
      // because there are or can be created rows next to tables!
      if (newUrl.length > 3) {
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
      }
    }
    url.value = newUrl;
  }

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
          title: FormTitle(title: label),
        ),
        drawer: Drawer(
          child: Tree(),
          semanticLabel: 'Tree view of the data structure',
        ),
        body: RowsList(table: table),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward),
              label: 'Up'.tr,
            ),
          ],
          currentIndex: 0,
          onTap: (index) async {
            switch (index) {
              case 0:
                url.value = [...url, 'map/'];
                break;
              case 1:
                goUp();
                break;
            }
          },
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
