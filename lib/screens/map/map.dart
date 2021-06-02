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
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'menu/index.dart';

class MapMapWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final lat = RxDouble(-0.09);
  final lng = 51.5.obs;
  final bounds = LatLngBounds.fromPoints([
    LatLng(51.5071 + 0.008, -0.0873 - 0.008),
    LatLng(51.5071 - 0.008, -0.0873 + 0.008),
  ]).obs;
  final mapController = MapController().obs;
  final markers = <Marker>[].obs;
  final toggleButtonsSelected = <bool>[false, false, false, false].obs;

  @override
  Widget build(BuildContext context) {
    if (activeRowId != null) {
      if (activeRow?.geometry != null) {
        // draw the geometry of this row
        // TODO: expand to any geometry type
        GeoJSONGeometryCollection geomCollection =
            GeoJSONGeometryCollection.fromJSON(activeRow?.geometry ?? '');
        // use geomCollection.bbox to zoom
        bounds.value = LatLngBounds.fromPoints([
          LatLng(
            geomCollection.bbox[1] + 0.008,
            geomCollection.bbox[0] - 0.008,
          ),
          LatLng(
            geomCollection.bbox[3] - 0.008,
            geomCollection.bbox[2] + 0.008,
          )
        ]);
        List<GeoJSONGeometry> geometries = geomCollection.geometries;
        geometries.forEach((geometry) {
          print('geometry: $geometry, type: ${geometry.type}');
          switch (geometry.type) {
            case GeoJSONType.point:
              print('geometry is a point');
              break;
            default:
              print('don\'t know this geometry\'s type');
          }
        });
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
      }
    }

    print('toggleButtonsSelected: ${toggleButtonsSelected}');

    return FlutterMap(
      mapController: mapController.value,
      options: MapOptions(
        //center: LatLng(lng.value, lat.value),
        //zoom: 13.0,
        bounds: bounds.value,
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
        LocationMarkerLayerWidget(),
        // show coordinates widget
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
        MapMenu(
          lat: lat,
          lng: lng,
          mapController: mapController,
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
      nonRotatedChildren: [],
    );
  }
}
