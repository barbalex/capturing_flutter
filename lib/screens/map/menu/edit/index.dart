import 'package:flutter/material.dart';

class MapMenuEdit extends StatelessWidget {
  final String mapEditingMode;
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

    switch (mapEditingMode) {
      case 'add':
        toggleButtonsSelected = [mapEditingMode == 'add'];
        children = [
          Tooltip(
            child: Icon(Icons.add),
            message: 'add new geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode == 'add') {
            setMapEditingMode('none');
          } else {
            setMapEditingMode('add');
          }
        };
        break;
      case 'edit':
        toggleButtonsSelected = [mapEditingMode == 'edit'];
        children = [
          Tooltip(
            child: Icon(Icons.edit),
            message: 'edit existing geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode == 'edit') {
            setMapEditingMode('none');
          } else {
            setMapEditingMode('edit');
          }
        };
        break;
      case 'delete':
        toggleButtonsSelected = [mapEditingMode == 'delete'];
        children = [
          Tooltip(
            child: Icon(Icons.remove),
            message: 'delete geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (mapEditingMode == 'delete') {
            setMapEditingMode('none');
          } else {
            setMapEditingMode('delete');
          }
        };
        break;
      default:
        toggleButtonsSelected = [
          mapEditingMode == 'add',
          mapEditingMode == 'edit',
          mapEditingMode == 'delete',
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
              if (mapEditingMode == 'add') {
                setMapEditingMode('none');
              } else {
                setMapEditingMode('add');
              }
              break;
            case 1:
              if (mapEditingMode == 'edit') {
                setMapEditingMode('none');
              } else {
                setMapEditingMode('edit');
              }
              break;
            case 2:
              if (mapEditingMode == 'delete') {
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
