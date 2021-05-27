import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/screens/projectChildren/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';

class ProjectChildren extends StatefulWidget {
  @override
  _ProjectChildrenState createState() => _ProjectChildrenState();
}

class _ProjectChildrenState extends State<ProjectChildren> {
  final String projectId = activeProjectId ?? '';
  final String? tableId = url.length > 3 ? url[url.length - 2] : null;
  final Isar isar = Get.find<Isar>();
  StreamSubscription<String>? editingProjectListener;

  @override
  void dispose() {
    super.dispose();
    editingProjectListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Map',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.arrow_upward,
        ),
        label: 'Project List',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.arrow_upward,
        ),
        label: 'Table List',
      ),
    ];
    if (editingProject.value == projectId) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'Table',
        ),
      );
    }

    editingProjectListener = editingProject.listen((_) {
      setState(() {});
    });

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
            Ctable? table = snapshot.data[0];
            Project project = snapshot.data[1];
            String label = table?.getLabel() ?? project.getLabel();

            return WillPopScope(
              onWillPop: () async {
                print(
                    'Project Children, will pop scope, url: $url, url.length: ${url.length}, url.length.isEven: ${url.length.isEven}');
                List<String> newUrl = [...url];
                if (editingProject.value == activeProjectId) {
                  // if editing: up one
                  newUrl.removeLast();
                } else if (url.length.isEven) {
                  // this is a row
                  newUrl.removeLast();
                } else if (url.length == 5) {
                  // else: up four, if parent is project and only one table exists
                  // else: up tow
                  int parentTablesCount = 0;
                  // only check parent if url is long enough
                  String parentType = url.length.isEven
                      ? url[url.length - 6]
                      : url[url.length - 5];
                  String parentId = url.length.isEven
                      ? url[url.length - 5]
                      : url[url.length - 4];
                  if (parentType == '/projects/') {
                    parentTablesCount = await isar.ctables
                        .where()
                        .filter()
                        .projectIdEqualTo(parentId)
                        .and()
                        .parentIdIsNull()
                        .and()
                        .deletedEqualTo(false)
                        .and()
                        .optionTypeEqualTo(null)
                        .count();
                  }
                  newUrl.removeLast();
                  newUrl.removeLast();
                  if (parentTablesCount == 1) {
                    newUrl.removeLast();
                    newUrl.removeLast();
                  }
                } else {
                  newUrl.removeLast();
                  newUrl.removeLast();
                }
                url.value = newUrl;
                return Future.value(false);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: FormTitle(title: label),
                ),
                body: ChildList(
                  table: table,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  items: bottomNavigationBarItems,
                  currentIndex: 0,
                  onTap: (index) async {
                    switch (index) {
                      case 0:
                        print('TODO:');
                        break;
                      case 1:
                        url.value = ['/projects/'];
                        break;
                      case 2:
                        List<String> newUrl = [...url];
                        newUrl.removeLast();
                        newUrl.removeLast();
                        url.value = newUrl;
                        break;
                      case 3:
                        List<String> newUrl = [...url];
                        newUrl.removeLast();
                        url.value = newUrl;
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
                    Crow newRow = Crow(tableId: tableId);
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
