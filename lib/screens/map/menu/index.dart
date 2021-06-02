import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'determinePosition.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapMenu extends StatelessWidget {
  final RxDouble lat;
  final RxDouble lng;
  final Rx<MapController> mapController;
  final RxBool editingPoints;
  final RxBool editingLines;
  final RxBool editingPolygons;

  MapMenu({
    required this.lat,
    required this.lng,
    required this.mapController,
    required this.editingPoints,
    required this.editingLines,
    required this.editingPolygons,
  });

  @override
  Widget build(BuildContext context) {
    final toggleButtonsSelected = <bool>[
      false,
      editingPoints.value,
      editingLines.value,
      editingPolygons.value
    ].obs;
    print('toggleButtonsSelected: ${toggleButtonsSelected}');

    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10),
      child: Obx(
        () => ToggleButtons(
          children: [
            Icon(Icons.my_location),
            Icon(Icons.center_focus_weak_outlined),
            Icon(Icons.linear_scale),
            Icon(FontAwesomeIcons.drawPolygon),
          ],
          isSelected: toggleButtonsSelected,
          onPressed: (int index) async {
            toggleButtonsSelected[index] = true;
            print('child $index was pressed');
            switch (index) {
              case 0:
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
                break;
              case 1:
                editingPoints.value = !editingPoints.value;
                editingLines.value = false;
                editingPolygons.value = false;
                break;
              case 2:
                editingPoints.value = false;
                editingLines.value = !editingLines.value;
                editingPolygons.value = false;
                break;
              case 3:
                editingPoints.value = false;
                editingLines.value = false;
                editingPolygons.value = !editingPolygons.value;
                break;
              default:
            }
          },
          direction: Axis.vertical,
          selectedColor: Theme.of(context).primaryColor,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
    );
  }
}
