import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:capturing/screens/map/menu/edit/index.dart';
import 'package:capturing/screens/map/menu/geometry/index.dart';
import 'package:capturing/screens/map/menu/locate/index.dart';
import 'package:capturing/store.dart';

class MapMenu extends StatelessWidget {
  final RxDouble lat;
  final RxDouble lng;
  final Rx<MapController> mapController;

  MapMenu({
    required this.lat,
    required this.lng,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
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
                'Edit mode',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              border: Border(
                left: BorderSide(color: Theme.of(context).primaryColor),
                right: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            child: MapMenuEdit(),
          ),
          Visibility(
            visible: mapEditingMode.value == 'add',
            child: Container(
              transform: Matrix4.translationValues(0, -1, 0),
              width: 50,
              child: Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  'Geometry',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                border: Border(
                  left: BorderSide(color: Theme.of(context).primaryColor),
                  right: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          Visibility(
            visible: mapEditingMode.value == 'add',
            child: Container(
              transform: Matrix4.translationValues(0, -1, 0),
              child: MapMenuGeometry(),
            ),
          ),
        ],
      ),
    );
  }
}
