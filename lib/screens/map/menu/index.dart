import 'package:flutter/material.dart';
import 'package:capturing/screens/map/menu/edit/index.dart';
import 'package:capturing/screens/map/menu/geometry/index.dart';
import 'package:capturing/screens/map/menu/locate/index.dart';
//import 'package:capturing/screens/map/menu/selection/index.dart';
import 'package:capturing/screens/map/menu/title.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapMenu extends StatefulWidget {
  final String mapEditingMode;
  final Function setMapEditingMode;
  final String mapGeometryType;
  final Function setMapGeometryType;
  final String mapSelectionMode;
  final Function setMapSelectionMode;
  final List<LatLng> editingPolylinePoints;
  final MapController mapController;
  final Function resetEditingPolylinePoints;

  MapMenu({
    required this.mapEditingMode,
    required this.setMapEditingMode,
    required this.mapGeometryType,
    required this.setMapGeometryType,
    required this.mapSelectionMode,
    required this.setMapSelectionMode,
    required this.editingPolylinePoints,
    required this.mapController,
    required this.resetEditingPolylinePoints,
  });

  @override
  _MapMenuState createState() => _MapMenuState();
}

class _MapMenuState extends State<MapMenu> {
  @override
  Widget build(BuildContext context) {
    String mapEditingMode = widget.mapEditingMode;
    Function setMapEditingMode = widget.setMapEditingMode;
    String mapGeometryType = widget.mapGeometryType;
    Function setMapGeometryType = widget.setMapGeometryType;
    //String mapSelectionMode = widget.mapSelectionMode;
    //Function setMapSelectionMode = widget.setMapSelectionMode;
    MapController mapController = widget.mapController;
    List<LatLng> editingPolylinePoints = widget.editingPolylinePoints;
    Function resetEditingPolylinePoints = widget.resetEditingPolylinePoints;

    return Padding(
      padding: EdgeInsets.only(top: 50, left: 10),
      child: Column(
        children: [
          MapMenuLocate(
            mapController: mapController,
          ),
          // MapTitle(title: 'Selection'),
          // Container(
          //   transform: Matrix4.translationValues(0, -1, 0),
          //   child: MapMenuSelection(
          //     mapSelectionMode: mapSelectionMode,
          //     setMapSelectionMode: setMapSelectionMode,
          //   ),
          // ),
          MapTitle(title: 'Edit mode'),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            child: MapMenuEdit(
              mapEditingMode: mapEditingMode,
              setMapEditingMode: setMapEditingMode,
            ),
          ),
          MapTitle(title: 'Geometry'),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            child: MapMenuGeometry(
              mapGeometryType: mapGeometryType,
              setMapGeometryType: setMapGeometryType,
              editingPolylinePoints: editingPolylinePoints,
              resetEditingPolylinePoints: resetEditingPolylinePoints,
            ),
          ),
        ],
      ),
    );
  }
}
