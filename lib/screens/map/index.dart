import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import './zoombuttons_plugin_option.dart';
import './scale_layer_plugin_option.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:capturing/store.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
/// https://pub.dev/packages/geolocator
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  // use getPositionStream for updates
  return await Geolocator.getCurrentPosition();
}

class MapWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final lat = 51.5.obs;
  final lng = RxDouble(-0.09);
  final mapController = MapController().obs;
  final markers = <Marker>[].obs;

  @override
  Widget build(BuildContext context) {
    //print('project, id: $id');
    return FutureBuilder(
      //future: isar.projects.where().idEqualTo(id).findFirst(),
      future: isar.projects
          .where()
          .filter()
          .deletedEqualTo(false)
          .sortByName()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Project> projects = snapshot.data;

            // StreamSubscription<MapEvent> mapEvents =
            //     mapController.value.mapEventStream.listen((event) {
            //   print(
            //       'event: ${event}, source: ${event.source}, center: ${event.center}');
            // });

            return WillPopScope(
              onWillPop: () {
                // TODO:
                List<String> newUrl = [...url];
                newUrl.removeLast();
                url.value = newUrl;
                return Future.value(false);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: FormTitle(title: 'Project Map'),
                ),
                body: Obx(
                  () => FlutterMap(
                    mapController: mapController.value,
                    options: MapOptions(
                      center: LatLng(lat.value, lng.value),
                      zoom: 13.0,
                      controller: mapController.value,
                      plugins: [
                        ZoomButtonsPlugin(),
                        ScaleLayerPlugin(),
                      ],
                      onTap: (LatLng location) {
                        // Check if map is editing and an active Row exists
                        if (!mapIsEditing.value && activeRow != null) return;
                        print('tapped $location');
                        if (markers.length > 0) markers.removeLast();
                        markers.add(
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: location,
                            builder: (ctx) => Container(
                              child: IconButton(
                                onPressed: () {
                                  print('pop up');
                                  // TODO: this marker needs state open
                                  // on press open
                                  // info window needs close ui to close
                                },
                                icon: Icon(Icons.ac_unit),
                              ),
                            ),
                          ),
                        );
                        // TODO:
                        // 1. write position to row
                        final Map<String, dynamic> point = {
                          'type': 'Point',
                          'coordinates': [
                            location.longitude,
                            location.latitude
                          ],
                        };
                        print('point: $point');
                        final pointFromMap = GeoJSON.fromMap(point);
                        print('pointFromMap: $pointFromMap');
                        // find active row and check if map is editing
                        print('activeRow: $activeRow');
                        // 2. load from row
                      },
                    ),
                    children: <Widget>[
                      TileLayerWidget(
                          options: TileLayerOptions(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'])),
                      Obx(
                        () => MarkerLayerWidget(
                          options: MarkerLayerOptions(
                            markers: markers.value,
                          ),
                        ),
                      ),
                    ],
                    nonRotatedLayers: [
                      ZoomButtonsPluginOption(
                        minZoom: 4,
                        maxZoom: 19,
                        mini: true,
                        padding: 10,
                        alignment: Alignment.bottomRight,
                      ),
                      ScaleLayerPluginOption(
                        lineColor: Theme.of(context).primaryColor,
                        lineWidth: 2,
                        textStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                    nonRotatedChildren: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, left: 10),
                        child: Align(
                          child: IconButton(
                            icon: Icon(Icons.my_location),
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              Position? position;
                              try {
                                position = await _determinePosition();
                              } catch (e) {
                                Get.snackbar(
                                  'Error accessing position',
                                  e.toString(),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                              if (position?.latitude != null &&
                                  position?.longitude != null) {
                                lat.value = position?.latitude ?? 0;
                                lng.value = position?.longitude ?? 0;
                                mapController.value
                                    .move(LatLng(lat.value, lng.value), 13);
                              }
                            },
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 33, left: 10),
                        child: Align(
                          child: Text(
                            'Lat: ${lat.value}, Lng: ${lng.value}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ],
                  ),
                ),
                // bottomNavigationBar: BottomNavigationBar(
                //   type: BottomNavigationBarType.fixed,
                //   backgroundColor: Theme.of(context).primaryColor,
                //   selectedItemColor: Colors.white,
                //   unselectedItemColor: Colors.white,
                //   items: <BottomNavigationBarItem>[
                //     BottomNavigationBarItem(
                //       icon: Icon(
                //         Icons.list_alt,
                //       ),
                //       label: 'Forms',
                //     ),
                //   ],
                //   currentIndex: 0,
                //   onTap: (index) async {
                //     switch (index) {
                //       case 0:
                //         List<String> newUrl = [...url];
                //         newUrl.removeLast();
                //         url.value = newUrl;
                //         break;
                //     }
                //   },
                // ),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
