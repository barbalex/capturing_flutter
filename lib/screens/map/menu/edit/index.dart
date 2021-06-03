import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class MapMenuEdit extends StatelessWidget {
  final String renderEnforcer;

  MapMenuEdit({required this.renderEnforcer});

  @override
  Widget build(BuildContext context) {
    List<bool> toggleButtonsSelected = [];
    List<Widget> children = [];
    void Function(int)? onPressed;

    switch (mapEditingMode.value) {
      case 'add':
        toggleButtonsSelected = [
          mapEditingMode.value == 'add',
        ].obs;
        children = [
          Tooltip(
            child: Icon(Icons.add),
            message: 'add new geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode.value == 'add') {
            mapEditingMode.value = 'none';
          } else {
            mapEditingMode.value = 'add';
          }
        };
        break;
      case 'edit':
        toggleButtonsSelected = [
          mapEditingMode.value == 'edit',
        ].obs;
        children = [
          Tooltip(
            child: Icon(Icons.edit),
            message: 'edit existing geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode.value == 'edit') {
            mapEditingMode.value = 'none';
          } else {
            mapEditingMode.value = 'edit';
          }
        };
        break;
      case 'delete':
        toggleButtonsSelected = [
          mapEditingMode.value == 'delete',
        ].obs;
        children = [
          Tooltip(
            child: Icon(Icons.remove),
            message: 'delete geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode.value == 'delete') {
            mapEditingMode.value = 'none';
          } else {
            mapEditingMode.value = 'delete';
          }
        };
        break;
      default:
        toggleButtonsSelected = [
          mapEditingMode.value == 'add',
          mapEditingMode.value == 'edit',
          mapEditingMode.value == 'delete',
        ].obs;
        children = [
          Tooltip(
            child: Icon(Icons.add),
            message: 'add new geometries',
          ),
          Tooltip(
            child: Icon(Icons.edit),
            message: 'edit existing geometries',
          ),
          Tooltip(
            child: Icon(Icons.remove),
            message: 'delete geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          switch (index) {
            case 0:
              if (mapEditingMode.value == 'add') {
                mapEditingMode.value = 'none';
              } else {
                mapEditingMode.value = 'add';
              }
              break;
            case 1:
              if (mapEditingMode.value == 'edit') {
                mapEditingMode.value = 'none';
              } else {
                mapEditingMode.value = 'edit';
              }
              break;
            case 2:
              if (mapEditingMode.value == 'delete') {
                mapEditingMode.value = 'none';
              } else {
                mapEditingMode.value = 'delete';
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
