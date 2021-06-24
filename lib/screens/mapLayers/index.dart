import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/utils/getActiveUserRole.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/models/tileLayer.dart';

class MapLayersContainer extends StatefulWidget {
  @override
  _MapLayersContainerState createState() => _MapLayersContainerState();
}

class _MapLayersContainerState extends State<MapLayersContainer> {
  final String projectId = activeProjectId ?? '';
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;

  final Isar isar = Get.find<Isar>();

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    ever(editingProject, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String? activeUserRole = getActiveUserRole(projectId);
    bool mayEditStructure =
        ['project_manager', 'account_manager'].contains(activeUserRole);

    List<ProjectTileLayer> projectTileLayers = isar.projectTileLayers
        .where()
        .projectIdEqualTo(projectId)
        .findAllSync();

    return WillPopScope(
      onWillPop: () async {
        // need to not add this route to the stack
        // because map returns only with back button
        List<String> newUrl = [...url];
        newUrl.removeLast();
        url.value = newUrl;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Map Layers'),
          actions: <Widget>[
            // only show actions if user is account_admin
            mayEditStructure
                ? Obx(
                    () => IconButton(
                      icon: Icon(Icons.build),
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
                  )
                : Container(),
          ],
        ),
        body: Container(),
        // TODO: only show action button if user is account_admin
        floatingActionButton: editingProject.value == projectId
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                onPressed: () async {
                  if (tableId == null) return;
                  Field newField = Field(tableId: tableId);
                  await newField.create();
                  url.value = [
                    '/projects/',
                    projectId,
                    '/tables/',
                    tableId ?? '',
                    '/fields/',
                    newField.id
                  ];
                },
                tooltip: 'Add Field',
              )
            : null,
      ),
    );
  }
}
