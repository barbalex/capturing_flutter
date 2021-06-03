import 'package:flutter/material.dart';
import 'package:capturing/screens/map/menu/edit/index.dart';
import 'package:capturing/screens/map/menu/geometry/index.dart';
import 'package:capturing/screens/map/menu/locate/index.dart';
//import 'package:capturing/screens/map/menu/selection/index.dart';
import 'package:capturing/screens/map/menu/title.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class MapMenu extends StatefulWidget {
  @override
  _MapMenuState createState() => _MapMenuState();
}

class _MapMenuState extends State<MapMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 10),
      child: Column(
        children: [
          MapMenuLocate(),
          // MapTitle(title: 'Selection'),
          // Container(
          //   transform: Matrix4.translationValues(0, -1, 0),
          //   child: MapMenuSelection(),
          // ),
          MapTitle(title: 'Edit mode'),
          Obx(
            () => Container(
              transform: Matrix4.translationValues(0, -1, 0),
              // MapMenuEdit needs to rerender when mapEditingMode changes
              // need to enforce because it is used in build function
              child: MapMenuEdit(renderEnforcer: mapEditingMode.value),
            ),
          ),
          Obx(
            () => Visibility(
              visible: mapEditingMode.value == 'add',
              child: MapTitle(title: 'Geometry'),
            ),
          ),
          Obx(
            () => Visibility(
              visible: mapEditingMode.value == 'add',
              child: Obx(
                () => Container(
                  transform: Matrix4.translationValues(0, -1, 0),
                  // MapMenuGeometry needs to rerender when mapGeometryType changes
                  // need to enforce because it is used in build function
                  child: MapMenuGeometry(renderEnforcer: mapGeometryType.value),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
