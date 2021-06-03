import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:capturing/store.dart';

class MapMenuEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected = <bool>[
      mapGeometryType.value == 'point',
      mapGeometryType.value == 'line',
      mapGeometryType.value == 'polygon',
      false
    ].obs;

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Obx(
        () => ToggleButtons(
          children: [
            Tooltip(
                child: Icon(Icons.center_focus_weak_outlined),
                message: mapGeometryType.value == 'point'
                    ? 'stop adding points'
                    : 'add points'),
            Tooltip(
                child: Icon(Icons.linear_scale),
                message: mapGeometryType.value == 'line'
                    ? 'stop adding lines'
                    : 'add lines'),
            Tooltip(
                child: Icon(FontAwesomeIcons.drawPolygon),
                message: mapGeometryType.value == 'polygon'
                    ? 'stop adding polygons'
                    : 'add polygons'),
            Tooltip(child: Icon(Icons.delete), message: 'delete features'),
          ],
          isSelected: toggleButtonsSelected,
          onPressed: (int index) async {
            toggleButtonsSelected[index] = true;
            print('child $index was pressed');
            switch (index) {
              case 0:
                if (mapGeometryType.value == 'point') {
                  mapGeometryType.value = 'none';
                } else {
                  mapGeometryType.value = 'point';
                }
                break;
              case 1:
                if (mapGeometryType.value == 'line') {
                  mapGeometryType.value = 'none';
                } else {
                  mapGeometryType.value = 'line';
                }
                break;
              case 2:
                if (mapGeometryType.value == 'polygon') {
                  mapGeometryType.value = 'none';
                } else {
                  mapGeometryType.value = 'polygon';
                }
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
