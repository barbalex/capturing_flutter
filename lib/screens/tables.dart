import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/tablesList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class Tables extends StatelessWidget {
  final String projectId = Get.parameters['projectId'] ?? '0';
  final Isar isar = Get.find<Isar>();
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.projects.where().filter().idEqualTo(projectId).findFirst(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
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
                title: FormTitle(title: 'Tables of ${snapshot.data?.name}'),
              ),
              body: TableList(),
              bottomNavigationBar: Obx(
                () => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  items: <BottomNavigationBarItem>[
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
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.arrow_upward,
                      ),
                      label: 'Project',
                    ),
                  ],
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
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                onPressed: () async {
                  Ctable newTable = Ctable(projectId: projectId);
                  await newTable.create();
                  Get.toNamed('/projects/${projectId}/tables/${newTable.id}');
                },
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
