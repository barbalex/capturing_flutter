import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapMenuEdit extends StatelessWidget {
  final RxString mapEditingMode;
  final Function setMapEditingMode;

  MapMenuEdit({
    required this.mapEditingMode,
    required this.setMapEditingMode,
  });

  @override
  Widget build(BuildContext context) {
    List<bool> toggleButtonsSelected = [];
    List<Widget> children = [];
    void Function(int)? onPressed;

    switch (mapEditingMode.value) {
      case 'add':
        toggleButtonsSelected = [mapEditingMode.value == 'add'];
        children = [
          Tooltip(
            child: Icon(Icons.add),
            message: 'add new geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode.value == 'add') {
            setMapEditingMode('none');
          } else {
            setMapEditingMode('add');
          }
        };
        break;
      case 'edit':
        toggleButtonsSelected = [mapEditingMode.value == 'edit'];
        children = [
          Tooltip(
            child: Icon(Icons.edit),
            message: 'edit existing geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode.value == 'edit') {
            setMapEditingMode('none');
          } else {
            setMapEditingMode('edit');
          }
        };
        break;
      case 'delete':
        toggleButtonsSelected = [mapEditingMode.value == 'delete'];
        children = [
          Tooltip(
            child: Icon(Icons.remove),
            message: 'delete geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode.value == 'delete') {
            setMapEditingMode('none');
          } else {
            setMapEditingMode('delete');
          }
        };
        break;
      default:
        toggleButtonsSelected = [
          mapEditingMode.value == 'add',
          mapEditingMode.value == 'edit',
          mapEditingMode.value == 'delete',
        ];
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
                setMapEditingMode('none');
              } else {
                setMapEditingMode('add');
              }
              break;
            case 1:
              if (mapEditingMode.value == 'edit') {
                setMapEditingMode('none');
              } else {
                setMapEditingMode('edit');
              }
              break;
            case 2:
              if (mapEditingMode.value == 'delete') {
                setMapEditingMode('none');
              } else {
                setMapEditingMode('delete');
              }
              break;
            default:
          }
        };
        break;
    }

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: ToggleButtons(
        children: children,
        isSelected: toggleButtonsSelected,
        onPressed: onPressed,
        direction: Axis.vertical,
        selectedColor: Colors.white,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
        selectedBorderColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
