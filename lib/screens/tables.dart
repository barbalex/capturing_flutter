import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/tablesList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class Tables extends StatefulWidget {
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  final String projectId = Get.parameters['projectId'] ?? '0';
  final Isar isar = Get.find<Isar>();
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;
  StreamSubscription<bool>? editingStructureListener;

  @override
  void dispose() {
    super.dispose();
    editingStructureListener?.cancel();
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
    if (editingStructure.value) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'Project',
        ),
      );
    }
    editingStructureListener = editingStructure.listen((_) {
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
                // TODO: only show actions if user is account_admin
                actions: <Widget>[
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        Icons.build,
                      ),
                      onPressed: () {
                        editingStructure.value = !editingStructure.value;
                      },
                      tooltip: editingStructure.value
                          ? 'Editing data structure. Click to stop.'
                          : 'Edit data structure',
                      color: editingStructure.value
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
                        Get.toNamed('/projects/');
                        break;
                      case 2:
                        Get.toNamed('/projects/${projectId}');
                        break;
                    }
                  },
                ),
              ),
              // TODO: only show action button if user is account_admin
              floatingActionButton: editingStructure.value
                  ? FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.add,
                        size: 40,
                      ),
                      onPressed: () async {
                        Ctable newTable = Ctable(projectId: projectId);
                        await newTable.create();
                        Get.toNamed(
                            '/projects/${projectId}/tables/${newTable.id}');
                      },
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
