import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/tables/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class Tables extends StatefulWidget {
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();
  final RxBool bottomBarInactive = true.obs;
  StreamSubscription<String>? editingProjectListener;
  // needed to manage child tables in separate views
  int level = 1;
  void setLevel(val) {
    setState(() {
      level = val;
    });
  }

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
        label: 'Project list',
      ),
    ];
    if (editingProject.value == projectId) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'Project',
        ),
      );
    }
    editingProjectListener = editingProject.listen((_) {
      setState(() {});
    });

    return FutureBuilder(
      future: isar.projects.where().filter().idEqualTo(projectId).findFirst(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        Icons.build,
                      ),
                      onPressed: () {
                        editingProject.value =
                            editingProject.value == projectId ? '' : projectId;
                      },
                      tooltip: editingProject.value == projectId
                          ? 'Editing data structure. Click to stop.'
                          : 'Edit data structure',
                      color: editingProject.value == projectId
                          ? Theme.of(context).accentColor
                          : Colors.white,
                    ),
                  ),
                ],
                title: FormTitle(
                    title:
                        'Tables of ${snapshot.data?.label ?? snapshot.data?.name}'),
              ),
              body: TableList(),
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
                      print('TODO: show map with all tables of this project');
                      break;
                    case 1:
                      url.value = ['/projects/'];
                      break;
                    case 2:
                      url.value = ['/projects/', projectId];
                      break;
                    case 3:
                      // TODO: set url of parent
                      //Get.toNamed();
                      break;
                  }
                },
              ),
              // only show action button if user is account_admin
              floatingActionButton: editingProject.value == projectId
                  ? FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.add,
                        size: 40,
                      ),
                      onPressed: () async {
                        Ctable newTable = Ctable(projectId: projectId);
                        await newTable.save();
                        url.value = [
                          '/projects/',
                          projectId,
                          '/tables/',
                          newTable.id
                        ];
                      },
                      tooltip: 'Add Table',
                    )
                  : null,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
