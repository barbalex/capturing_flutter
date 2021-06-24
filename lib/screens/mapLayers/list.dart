import 'package:flutter/material.dart';
import 'package:capturing/screens/mapLayers/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/store.dart';

class ProjectTileLayerList extends StatefulWidget {
  @override
  _ProjectTileLayerListState createState() => _ProjectTileLayerListState();
}

class _ProjectTileLayerListState extends State<ProjectTileLayerList> {
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
        .sortByOrd()
        .findAllSync();

    return ReorderableListView(
      children: <Widget>[
        for (int index = 0; index < projectTileLayers.length; index++)
          LayerTile(
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
            projectTileLayer.ord = index;
            projectTileLayer.save();
          }
        });
      },
    );
  }
}
