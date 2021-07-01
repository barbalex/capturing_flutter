import 'package:flutter/material.dart';
import 'package:capturing/screens/map/menu/edit/index.dart';
import 'package:capturing/screens/map/menu/geometry/index.dart';
//import 'package:capturing/screens/map/menu/selection/index.dart';
import 'package:capturing/screens/map/menu/title.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapMenu extends StatefulWidget {
  final RxString mapEditingMode;
  final Function setMapEditingMode;
  final RxString mapGeometryType;
  final Function setMapGeometryType;
  final String mapSelectionMode;
  final Function setMapSelectionMode;
  final RxList<LatLng> editingPolylinePoints;
  final Function resetEditingPolylinePoints;
  final Function resetEditingPolygon;
  final RxList<LatLng> editingPolygonPoints;
  final RxList<Polyline> editingPolygonLines;

  MapMenu({
    required this.mapEditingMode,
    required this.setMapEditingMode,
    required this.mapGeometryType,
    required this.setMapGeometryType,
    required this.mapSelectionMode,
    required this.setMapSelectionMode,
    required this.editingPolylinePoints,
    required this.resetEditingPolylinePoints,
    required this.resetEditingPolygon,
    required this.editingPolygonPoints,
    required this.editingPolygonLines,
  });

  @override
  _MapMenuState createState() => _MapMenuState();
}

class _MapMenuState extends State<MapMenu> {
  @override
  Widget build(BuildContext context) {
    RxString mapEditingMode = widget.mapEditingMode;
    Function setMapEditingMode = widget.setMapEditingMode;
    RxString mapGeometryType = widget.mapGeometryType;
    Function setMapGeometryType = widget.setMapGeometryType;
    //String mapSelectionMode = widget.mapSelectionMode;
    //Function setMapSelectionMode = widget.setMapSelectionMode;
    RxList<LatLng> editingPolylinePoints = widget.editingPolylinePoints;
    Function resetEditingPolylinePoints = widget.resetEditingPolylinePoints;
    Function resetEditingPolygon = widget.resetEditingPolygon;
    RxList<LatLng> editingPolygonPoints = widget.editingPolygonPoints;
    RxList<Polyline> editingPolygonLines = widget.editingPolygonLines;

    return Padding(
      padding: EdgeInsets.only(top: 50, left: 10),
      child: Column(
        children: [
          // MapTitle(title: 'Selection'),
          // Container(
          //   transform: Matrix4.translationValues(0, -1, 0),
          //   child: MapMenuSelection(
          //     mapSelectionMode: mapSelectionMode,
          //     setMapSelectionMode: setMapSelectionMode,
          //   ),
          // ),
          MapTitle(title: 'Edit'.tr, top: true),
          MapTitle(title: 'Mode'.tr, top: true),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            child: MapMenuEdit(
              mapEditingMode: mapEditingMode,
              setMapEditingMode: setMapEditingMode,
            ),
          ),
          MapTitle(title: 'Geometry'.tr),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            child: MapMenuGeometry(
              mapGeometryType: mapGeometryType,
              setMapGeometryType: setMapGeometryType,
              editingPolylinePoints: editingPolylinePoints,
              resetEditingPolylinePoints: resetEditingPolylinePoints,
              resetEditingPolygon: resetEditingPolygon,
              editingPolygonPoints: editingPolygonPoints,
              editingPolygonLines: editingPolygonLines,
            ),
          ),
        ],
      ),
    );
  }
}
