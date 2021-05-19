import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/components/rowsList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/utils/getActiveUserRole.dart';

class Rows extends StatefulWidget {
  @override
  _RowsState createState() => _RowsState();
}

class _RowsState extends State<Rows> {
  final String projectId = Get.parameters['projectId'] ?? '';
  final String tableId = Get.parameters['tableId'] ?? '';
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
      future: isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Ctable table = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Rows of ${table.label ?? table.name}'),
              ),
              body: RowList(
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
                        Get.toNamed('/projects/${projectId}/tables/');
                        break;
                      case 2:
                        Get.toNamed('/projects/${projectId}/tables/${tableId}');
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
                  Get.toNamed(
                      '/projects/${projectId}/tables/${tableId}/rows/${newRow.id}');
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
