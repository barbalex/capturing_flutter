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

class RowsListWidget extends StatelessWidget {
  final String? tableId = url.length > 3 ? url[url.length - 2] : null;
  final Isar isar = Get.find<Isar>();

  goUp() async {
    List<String> newUrl = [...url];
    if (url.length.isEven) {
      // this is a row > go up to it's list
      newUrl.removeLast();
    } else if (url.length == 5) {
      // up four, if grandParent is project and only one table exists
      // else: up two
      int parentTablesCount = 0;
      // only check parent if url is long enough
      String grandParentType = url[url.length - 5];
      String grandParentId = url[url.length - 4];
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
      //print('ProjectChildren, parentTablesCount: ${parentTablesCount}');
      newUrl.removeLast();
      newUrl.removeLast();
      newUrl.removeLast();
      newUrl.removeLast();
      if (parentTablesCount == 1) {
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
        newUrl.removeLast();
      }
    } else {
      // if grandParent is not project, never go up four
      // because there are or can be created rows next to tables!
      newUrl.removeLast();
      newUrl.removeLast();
      newUrl.removeLast();
      newUrl.removeLast();
    }
    url.value = newUrl;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isar.ctables.where().filter().idEqualTo(tableId ?? '').findFirst(),
        isar.projects
            .where()
            .filter()
            .idEqualTo(activeProjectId ?? '')
            .findFirst(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            if (snapshot.data == null) return Container();
            Ctable? table = snapshot.data[0];
            Project project = snapshot.data[1];
            String label = table?.getLabel() ?? project.getLabel();

            return WillPopScope(
              onWillPop: () async {
                await goUp();
                return Future.value(false);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: FormTitle(title: label),
                ),
                body: RowsList(
                  table: table,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      label: 'Map',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.arrow_upward,
                      ),
                      label: 'Up',
                    ),
                  ],
                  currentIndex: 0,
                  onTap: (index) async {
                    switch (index) {
                      case 0:
                        print('TODO:');
                        break;
                      case 1:
                        goUp();
                        break;
                    }
                  },
                ),
                // TODO: only show action button if user is account_admin
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
                        : urlCopied[indexOfLastRowsFolder + 1];
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
        return CircularProgressIndicator();
      },
    );
  }
}
