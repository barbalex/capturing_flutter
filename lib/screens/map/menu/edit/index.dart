import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapMenuEdit extends StatefulWidget {
  final RxString mapEditingMode;
  final Function setMapEditingMode;

  MapMenuEdit({
    required this.mapEditingMode,
    required this.setMapEditingMode,
  });

  @override
  _MapMenuEditState createState() => _MapMenuEditState();
}

class _MapMenuEditState extends State<MapMenuEdit> {
  @override
  Widget build(BuildContext context) {
    List<bool> toggleButtonsSelected = [];
    List<Widget> children = [];
    void Function(int)? onPressed;

    ever(widget.mapEditingMode, (_) {
      setState(() {});
    });

    switch (widget.mapEditingMode.value) {
      case 'add':
        toggleButtonsSelected = [widget.mapEditingMode.value == 'add'];
        children = [
          Tooltip(
            child: Icon(Icons.add),
            message: 'add new geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (widget.mapEditingMode.value == 'add') {
            widget.setMapEditingMode('none');
          } else {
            widget.setMapEditingMode('add');
          }
        };
        break;
      case 'edit':
        toggleButtonsSelected = [widget.mapEditingMode.value == 'edit'];
        children = [
          Tooltip(
            child: Icon(Icons.edit),
            message: 'edit existing geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (widget.mapEditingMode.value == 'edit') {
            widget.setMapEditingMode('none');
          } else {
            widget.setMapEditingMode('edit');
          }
        };
        break;
      case 'delete':
        toggleButtonsSelected = [widget.mapEditingMode.value == 'delete'];
        children = [
          Tooltip(
            child: Icon(Icons.remove),
            message: 'delete geometries',
          ),
        ];
        onPressed = (int index) {
          toggleButtonsSelected[index] = true;
          if (widget.mapEditingMode.value == 'delete') {
            widget.setMapEditingMode('none');
          } else {
            widget.setMapEditingMode('delete');
          }
        };
        break;
      default:
        toggleButtonsSelected = [
          widget.mapEditingMode.value == 'add',
          widget.mapEditingMode.value == 'edit',
          widget.mapEditingMode.value == 'delete',
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
              if (widget.mapEditingMode.value == 'add') {
                widget.setMapEditingMode('none');
              } else {
                widget.setMapEditingMode('add');
              }
              break;
            case 1:
              if (widget.mapEditingMode.value == 'edit') {
                widget.setMapEditingMode('none');
              } else {
                widget.setMapEditingMode('edit');
              }
              break;
            case 2:
              if (widget.mapEditingMode.value == 'delete') {
                widget.setMapEditingMode('none');
              } else {
                widget.setMapEditingMode('delete');
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
