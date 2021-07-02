import 'package:capturing/models/projectTileLayer.dart';
import 'package:flutter/material.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class ProjectTileLayerTileEditable extends StatelessWidget {
  final ProjectTileLayer projectTileLayer;
  final Key key;

  ProjectTileLayerTileEditable({
    required this.projectTileLayer,
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(projectTileLayer.isarId.toString()),
      // Show a red background as the item is swiped away.
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: Text(
            'delete'.tr,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        projectTileLayer.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${projectTileLayer.getLabel()} dismissed"),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(projectTileLayer.getLabel()),
            onTap: () {
              url.value = [...url, projectTileLayer.id];
            },
            leading: Icon(
              Icons.drag_handle,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
