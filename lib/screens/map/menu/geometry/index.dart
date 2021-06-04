import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapMenuGeometry extends StatelessWidget {
  final String mapGeometryType;
  final Function setMapGeometryType;

  MapMenuGeometry({
    required this.mapGeometryType,
    required this.setMapGeometryType,
  });

  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected = <bool>[
      ['point', 'all'].contains(mapGeometryType),
      ['line', 'all'].contains(mapGeometryType),
      ['polygon', 'all'].contains(mapGeometryType),
    ].obs;

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: ToggleButtons(
        children: [
          Tooltip(
            child: Icon(Icons.center_focus_weak_outlined),
            message: mapGeometryType == 'point'
                ? 'stop adding points'
                : 'add points',
          ),
          Tooltip(
            child: Icon(Icons.linear_scale),
            message:
                mapGeometryType == 'line' ? 'stop adding lines' : 'add lines',
          ),
          Tooltip(
            child: Icon(FontAwesomeIcons.drawPolygon),
            message: mapGeometryType == 'polygon'
                ? 'stop adding polygons'
                : 'add polygons',
          ),
        ],
        isSelected: toggleButtonsSelected,
        onPressed: (int index) async {
          toggleButtonsSelected[index] = true;
          switch (index) {
            case 0:
              if (mapGeometryType == 'point') {
                setMapGeometryType('none');
              } else {
                setMapGeometryType('point');
              }
              break;
            case 1:
              if (mapGeometryType == 'line') {
                setMapGeometryType('none');
              } else {
                setMapGeometryType('line');
              }
              break;
            case 2:
            default:
              if (mapGeometryType == 'polygon') {
                setMapGeometryType('none');
              } else {
                setMapGeometryType('polygon');
              }
              break;
          }
        },
        direction: Axis.vertical,
        selectedColor: Colors.white,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
        selectedBorderColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
