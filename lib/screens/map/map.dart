import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import './zoombuttons_plugin_option.dart';
import './scale_layer_plugin_option.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:capturing/store.dart';
import './determinePosition.dart';

class MapMapWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final lat = RxDouble(-0.09);
  final lng = 51.5.obs;
  final mapController = MapController().obs;
  final markers = <Marker>[].obs;

  @override
  Widget build(BuildContext context) {
    if (activeRowId != null) {
      if (activeRow?.geometry != null) {
        GeoJSONGeometryCollection geomCollection =
            GeoJSONGeometryCollection.fromJSON(activeRow?.geometry ?? '');
        List<GeoJSONGeometry> geometries = geomCollection.geometries;
        GeoJSONPoint point = geometries[0] as GeoJSONPoint;
        LatLng latLng = LatLng(point.coordinates[1], point.coordinates[0]);
        markers.add(
          Marker(
            width: 40.0,
            height: 40.0,
            point: latLng,
            builder: (ctx) => Container(
              child: IconButton(
                onPressed: () {
                  print('pop up');
                  // TODO: this marker needs state open
                  // on press open
                  // info window needs close ui to close
                },
                icon: Icon(Icons.center_focus_weak_outlined),
              ),
            ),
          ),
        );
        // TODO: zoom to coordinates
        lat.value = point.coordinates[0];
        lng.value = point.coordinates[1];
      }
    }

    return FlutterMap(
      mapController: mapController.value,
      options: MapOptions(
        center: LatLng(lng.value, lat.value),
        zoom: 13.0,
        controller: mapController.value,
        plugins: [
          ZoomButtonsPlugin(),
          ScaleLayerPlugin(),
        ],
        onPositionChanged: (MapPosition position, bool hasGesture) {
          double? newLat = position.center?.latitude;
          double? newLng = position.center?.longitude;
          if (newLat != null &&
              newLng != null &&
              (newLat != lat.value || newLng != lng.value)) {
            lat.value = newLat;
            lng.value = newLng;
          }
        },
        onTap: (LatLng location) {
          // find active row and check if map is editing
          print(
              'activeRowId: $activeRowId, mapIsEditing: ${mapIsEditing.value}');
          print('tapped $location');
          // Check if map is editing and an active Row exists
          if (!mapIsEditing.value && activeRowId != null) return;
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
                  icon: Icon(Icons.center_focus_weak_outlined),
                ),
              ),
            ),
          );
          // 1. write position to row
          Map<String, dynamic> pointMap = {
            'type': 'Point',
            'coordinates': [location.longitude, location.latitude]
          };
          Map<String, dynamic> map = {
            'type': 'GeometryCollection',
            'geometries': [pointMap],
          };
          final geometryCollection = GeoJSONGeometryCollection.fromMap(map);
          List<double>? bbox = geometryCollection.bbox;
          // 2. load from row
          Crow? row =
              isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
          if (row != null) {
            row.geometry = geometryCollection.toJSON();
            row.geometryW = bbox[0];
            row.geometryS = bbox[1];
            row.geometryE = bbox[2];
            row.geometryN = bbox[3];
            row.save();
          }
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
          //rebuild: lat.stream.cast(),
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
            ),
            alignment: Alignment.topLeft,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 33, left: 10),
          child: Align(
            child: Obx(
              () => Text(
                'Lat: ${lat.value.toPrecision(4)}, Lng: ${lng.value.toPrecision(4)}',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            alignment: Alignment.topLeft,
          ),
        ),
      ],
    );
  }
}
