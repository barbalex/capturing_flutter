import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/screens/fields/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/utils/getActiveUserRole.dart';

class Fields extends StatefulWidget {
  @override
  _FieldsState createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  final String projectId = activeProjectId ?? '';
  final String tableId = url[url.length - 2];

  final Isar isar = Get.find<Isar>();

  StreamSubscription<String>? editingProjectListener;
  final AuthController authController = Get.find<AuthController>();

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
        label: 'Table list',
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
    String? activeUserRole = getActiveUserRole(projectId);
    bool mayEditStructure =
        ['project_manager', 'account_manager'].contains(activeUserRole);

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
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  // only show actions if user is account_admin
                  mayEditStructure
                      ? Obx(
                          () => IconButton(
                            icon: Icon(
                              Icons.build,
                            ),
                            onPressed: () {
                              editingProject.value =
                                  editingProject.value == projectId
                                      ? ''
                                      : projectId;
                            },
                            tooltip: editingProject.value == projectId
                                ? 'Editing data structure. Click to stop.'
                                : 'Edit data structure',
                            color: editingProject.value == projectId
                                ? Theme.of(context).accentColor
                                : Colors.white,
                          ),
                        )
                      : Container(),
                ],
                title: FormTitle(
                    title:
                        'Fields of ${snapshot.data?.label ?? snapshot.data?.name}'),
              ),
              body: FieldList(),
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
                      url.value = ['/projects/', projectId, '/children/'];
                      break;
                    case 2:
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
              // TODO: only show action button if user is account_admin
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                onPressed: () async {
                  Field newField = Field(tableId: tableId);
                  await newField.create();
                  url.value = [
                    '/projects/',
                    projectId,
                    '/children/',
                    tableId,
                    '/children/',
                    newField.id
                  ];
                },
                tooltip: 'Add Field',
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
