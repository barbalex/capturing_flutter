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
  final String tableId = activeTableId ?? '';
  final Isar isar = Get.find<Isar>();
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;
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
        isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
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

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Children of ${label}'),
              ),
              body: ChildList(
                table: table,
              ),
              bottomNavigationBar: Obx(
                () => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  items: bottomNavigationBarItems,
                  currentIndex: bottomBarIndex.value,
                  onTap: (index) async {
                    bottomBarIndex.value = index;
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
                        print('Project Children, newUrl: $newUrl');
                        url.value = newUrl;
                        break;
                      case 3:
                        url.value = [
                          '/projects/',
                          projectId,
                          '/children/',
                          tableId
                        ];
                        break;
                    }
                  },
                ),
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
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
