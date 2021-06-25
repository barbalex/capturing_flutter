import 'package:flutter/material.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/store.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import './map.dart';
import 'determinePosition.dart';

class MapContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();

    return WillPopScope(
      onWillPop: () {
        List<String> newUrl = [...url];
        newUrl.removeLast();
        url.value = newUrl;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: FormTitle(title: 'Project Map'),
        ),
        body: MapWidget(mapController: mapController),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.my_location),
              label: 'To current',
              tooltip: 'Pan to current location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.layers),
              label: 'Background Layers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.layers),
              label: 'Vector Layers',
            ),
          ],
          currentIndex: 0,
          onTap: (index) async {
            switch (index) {
              case 0:
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
                  mapController.move(
                    LatLng(
                      position?.latitude ?? 0,
                      position?.longitude ?? 0,
                    ),
                    13,
                  );
                }
                break;
              case 1:
                url.value = [...url, 'layers/'];
                break;
              case 2:
                url.value = [...url, 'layers/'];
                break;
            }
          },
        ),
      ),
    );
  }
}
