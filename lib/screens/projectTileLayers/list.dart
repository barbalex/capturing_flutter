import 'package:flutter/material.dart';
import 'package:capturing/screens/projectTileLayers/tileEditable.dart';
import 'package:capturing/screens/projectTileLayers/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/store.dart';

class ProjectTileLayersList extends StatefulWidget {
  @override
  _ProjectTileLayersListState createState() => _ProjectTileLayersListState();
}

class _ProjectTileLayersListState extends State<ProjectTileLayersList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> projectTileLayerListener;
  final String projectId = activeProjectId ?? '';

  @override
  void initState() {
    super.initState();
    projectTileLayerListener =
        isar.projectTileLayers.watchLazy().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    projectTileLayerListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProjectTileLayer> projectTileLayers = isar.projectTileLayers
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(projectId)
        .sortByOrdDesc()
        .findAllSync();

    return ReorderableListView(
      children: <Widget>[
        for (int index = 0; index < projectTileLayers.length; index++)
          editingProject.value == projectId
              ? ProjectTileLayerTileEditable(
                  key: Key('$index'),
                  projectTileLayer: projectTileLayers[index],
                )
              : ProjectTileLayerTile(
                  key: Key('$index'),
                  projectTileLayer: projectTileLayers[index],
                ),
      ],
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        ProjectTileLayer movedLayer = projectTileLayers.removeAt(oldIndex);
        projectTileLayers.insert(newIndex, movedLayer);
        projectTileLayers.asMap().forEach((index, projectTileLayer) {
          if (projectTileLayer.ord != index) {
            projectTileLayer.ord = projectTileLayers.length - index;
            projectTileLayer.save();
          }
        });
      },
    );
  }
}
