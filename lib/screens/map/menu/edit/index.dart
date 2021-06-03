import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapMenuEdit extends StatelessWidget {
  final bool editingPoints;
  final bool editingLines;
  final bool editingPolygons;
  final Function toggleEditingPoints;
  final Function toggleEditingLines;
  final Function toggleEditingPolygons;

  MapMenuEdit({
    required this.editingPoints,
    required this.toggleEditingPoints,
    required this.editingLines,
    required this.toggleEditingLines,
    required this.editingPolygons,
    required this.toggleEditingPolygons,
  });

  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected =
        <bool>[editingPoints, editingLines, editingPolygons, false].obs;
    print('toggleButtonsSelected: ${toggleButtonsSelected}');

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Obx(
        () => ToggleButtons(
          children: [
            Tooltip(
                child: Icon(Icons.center_focus_weak_outlined),
                message: editingPoints ? 'stop adding points' : 'add points'),
            Tooltip(
                child: Icon(Icons.linear_scale),
                message: editingLines ? 'stop adding lines' : 'add lines'),
            Tooltip(
                child: Icon(FontAwesomeIcons.drawPolygon),
                message:
                    editingPolygons ? 'stop adding polygons' : 'add polygons'),
            Tooltip(child: Icon(Icons.delete), message: 'delete features'),
          ],
          isSelected: toggleButtonsSelected,
          onPressed: (int index) async {
            toggleButtonsSelected[index] = true;
            print('child $index was pressed');
            switch (index) {
              case 0:
                toggleEditingPoints();
                break;
              case 1:
                toggleEditingLines();
                break;
              case 2:
                toggleEditingPolygons();
                break;
              case 3:
                print('TODO:');
                break;
              default:
            }
          },
          direction: Axis.vertical,
          selectedColor: Colors.white,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.7),
          selectedBorderColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
