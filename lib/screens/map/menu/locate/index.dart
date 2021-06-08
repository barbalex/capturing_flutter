import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'determinePosition.dart';
import 'package:geolocator/geolocator.dart';
import 'package:capturing/store.dart';
import 'package:flutter_map/flutter_map.dart';

class MapMenuLocate extends StatelessWidget {
  final MapController mapController;
  MapMenuLocate({required this.mapController});

  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected = <bool>[false].obs;

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: ToggleButtons(
        children: [
          Tooltip(
              child: Icon(Icons.my_location),
              message: 'Pan to current location'),
        ],
        isSelected: toggleButtonsSelected,
        onPressed: (int index) async {
          toggleButtonsSelected[index] = true;
          Timer(
            Duration(seconds: 1),
            () {
              toggleButtonsSelected[index] = false;
            },
          );
          Position? position;
          try {
            position = await determinePosition();
          } catch (e) {
            Get.snackbar(
              'Error accessing position',
              e.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          if (position?.latitude != null && position?.longitude != null) {
            print('moving to $position');
            mapController.move(
              LatLng(
                position?.latitude ?? 0,
                position?.longitude ?? 0,
              ),
              13,
            );
          }
        },
        direction: Axis.vertical,
        selectedColor: Colors.white,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
        selectedBorderColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
