import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'determinePosition.dart';
import 'package:geolocator/geolocator.dart';

class MapMenuLocate extends StatelessWidget {
  final RxDouble lat;
  final RxDouble lng;
  final Rx<MapController> mapController;

  MapMenuLocate({
    required this.lat,
    required this.lng,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected = <bool>[false].obs;

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Obx(
        () => ToggleButtons(
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
              lat.value = position?.latitude ?? 0;
              lng.value = position?.longitude ?? 0;
              mapController.value.move(LatLng(lat.value, lng.value), 13);
            }
          },
          direction: Axis.vertical,
          selectedColor: Colors.white,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
          selectedBorderColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
