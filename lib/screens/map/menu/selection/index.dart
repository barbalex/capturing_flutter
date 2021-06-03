import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MapMenuSelection extends StatelessWidget {
  final String mapSelectionMode;
  final Function setMapSelectionMode;

  MapMenuSelection({
    required this.mapSelectionMode,
    required this.setMapSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    List<bool> toggleButtonsSelected = [];
    List<Widget> children = [];
    void Function(int)? onPressed;

    switch (mapSelectionMode) {
      case 'tap':
        toggleButtonsSelected = [mapSelectionMode == 'tap'].obs;
        children = [
          Tooltip(
            child: Icon(Icons.touch_app),
            message: 'tap',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapSelectionMode == 'tap') {
            setMapSelectionMode('crosshair');
          } else {
            setMapSelectionMode('tap');
          }
        };
        break;
      case 'crosshair':
        toggleButtonsSelected = [mapSelectionMode == 'crosshair'].obs;
        children = [
          Tooltip(
            child: Icon(FontAwesomeIcons.crosshairs),
            message: 'crosshair',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapSelectionMode == 'crosshair') {
            setMapSelectionMode('tap');
          } else {
            setMapSelectionMode('crosshair');
          }
        };
        break;
      default:
        toggleButtonsSelected = [
          mapSelectionMode == 'tap',
          mapSelectionMode == 'crosshair',
        ].obs;
        children = [
          Tooltip(
            child: Icon(Icons.touch_app),
            message: 'tap',
          ),
          Tooltip(
            child: Icon(Icons.add),
            message: 'crosshair',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          switch (index) {
            case 0:
              if (mapSelectionMode == 'tap') {
                setMapSelectionMode('crosshair');
              } else {
                setMapSelectionMode('tap');
              }
              break;
            case 1:
              if (mapSelectionMode == 'crosshair') {
                setMapSelectionMode('tap');
              } else {
                setMapSelectionMode('crosshair');
              }
              break;
            default:
          }
        };
        break;
    }

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Obx(
        () => ToggleButtons(
          children: children,
          isSelected: toggleButtonsSelected,
          onPressed: onPressed,
          direction: Axis.vertical,
          selectedColor: Colors.white,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
          selectedBorderColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
