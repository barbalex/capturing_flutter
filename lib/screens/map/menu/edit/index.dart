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
  void initState() {
    super.initState();

    ever(widget.mapEditingMode, (_) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    RxString mapEditingMode = widget.mapEditingMode;
    List<bool> toggleButtonsSelected = [];
    List<Widget> children = [];
    void Function(int)? onPressed;

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
            widget.setMapEditingMode('none');
          } else {
            widget.setMapEditingMode('add');
          }
          break;
        case 1:
          if (mapEditingMode.value == 'edit') {
            widget.setMapEditingMode('none');
          } else {
            widget.setMapEditingMode('edit');
          }
          break;
        case 2:
          if (mapEditingMode.value == 'delete') {
            widget.setMapEditingMode('none');
          } else {
            widget.setMapEditingMode('delete');
          }
          break;
        default:
      }
    };

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
