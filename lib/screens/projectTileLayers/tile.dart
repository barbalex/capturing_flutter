import 'package:capturing/models/projectTileLayer.dart';
import 'package:flutter/material.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class ProjectTileLayerTile extends StatelessWidget {
  final ProjectTileLayer projectTileLayer;
  final Key key;

  ProjectTileLayerTile({
    required this.projectTileLayer,
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => CheckboxListTile(
            title: Text(projectTileLayer.getLabel()),
            value: activeLayers.contains(projectTileLayer.id),
            onChanged: (bool? value) {
              if (value == true) {
                activeLayers.addIf(
                  !activeLayers.contains(projectTileLayer.id),
                  projectTileLayer.id,
                );
              } else {
                activeLayers.removeWhere((e) => e == projectTileLayer.id);
              }
            },
            secondary: Icon(
              Icons.drag_handle,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 0,
          color: Theme.of(context).primaryColor.withOpacity(0.4),
        ),
      ],
    );
  }
}
