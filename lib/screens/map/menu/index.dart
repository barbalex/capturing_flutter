import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'locate/determinePosition.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:capturing/screens/map/menu/edit/index.dart';
import 'package:capturing/screens/map/menu/locate/index.dart';

class MapMenu extends StatelessWidget {
  final RxDouble lat;
  final RxDouble lng;
  final Rx<MapController> mapController;
  final bool editingPoints;
  final bool editingLines;
  final bool editingPolygons;
  final Function toggleEditingPoints;
  final Function toggleEditingLines;
  final Function toggleEditingPolygons;

  MapMenu({
    required this.lat,
    required this.lng,
    required this.mapController,
    required this.editingPoints,
    required this.toggleEditingPoints,
    required this.editingLines,
    required this.toggleEditingLines,
    required this.editingPolygons,
    required this.toggleEditingPolygons,
  });

  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected =
        <bool>[false, editingPoints, editingLines, editingPolygons, false].obs;
    print('toggleButtonsSelected: ${toggleButtonsSelected}');

    return Padding(
      padding: EdgeInsets.only(top: 50, left: 10),
      child: Column(
        children: [
          MapMenuLocate(
            lat: lat,
            lng: lng,
            mapController: mapController,
          ),
          Container(
            width: 50,
            child: Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                'Edit:',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              border: Border(
                left: BorderSide(color: Theme.of(context).primaryColor),
                right: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            child: MapMenuEdit(
              editingPoints: editingPoints,
              toggleEditingPoints: toggleEditingPoints,
              editingLines: editingLines,
              toggleEditingLines: toggleEditingLines,
              editingPolygons: editingPolygons,
              toggleEditingPolygons: toggleEditingPolygons,
            ),
          ),
        ],
      ),
    );
  }
}