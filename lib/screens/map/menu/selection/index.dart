import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class MapMenuSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> toggleButtonsSelected = [];
    List<Widget> children = [];
    void Function(int)? onPressed;

    switch (mapSelectionMode.value) {
      case 'tap':
        toggleButtonsSelected = [mapSelectionMode.value == 'tap'].obs;
        children = [
          Tooltip(
            child: Icon(Icons.touch_app),
            message: 'tap',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapSelectionMode.value == 'tap') {
            mapSelectionMode.value = 'crosshair';
          } else {
            mapSelectionMode.value = 'tap';
          }
        };
        break;
      case 'crosshair':
        toggleButtonsSelected = [mapSelectionMode.value == 'crosshair'].obs;
        children = [
          Tooltip(
            child: Icon(FontAwesomeIcons.crosshairs),
            message: 'crosshair',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapSelectionMode.value == 'crosshair') {
            mapSelectionMode.value = 'tap';
          } else {
            mapSelectionMode.value = 'crosshair';
          }
        };
        break;
      default:
        toggleButtonsSelected = [
          mapSelectionMode.value == 'tap',
          mapSelectionMode.value == 'crosshair',
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
              if (mapSelectionMode.value == 'tap') {
                mapSelectionMode.value = 'crosshair';
              } else {
                mapSelectionMode.value = 'tap';
              }
              break;
            case 1:
              if (mapSelectionMode.value == 'crosshair') {
                mapSelectionMode.value = 'tap';
              } else {
                mapSelectionMode.value = 'crosshair';
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
