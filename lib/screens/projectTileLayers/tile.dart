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
            value: activeTileLayerFromStore.value != ''
                ? activeTileLayerFromStore.value == projectTileLayer.id
                : projectTileLayer.active,
            onChanged: (bool? value) {
              print('value: $value');
              activeTileLayerFromStore.value =
                  value == true ? projectTileLayer.id : '';
            },
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
