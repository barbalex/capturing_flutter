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
import './marker.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:capturing/store.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'menu/index.dart';

class MapMapWidget extends StatefulWidget {
  @override
  _MapMapWidgetState createState() => _MapMapWidgetState();
}

class _MapMapWidgetState extends State<MapMapWidget> {
  final Isar isar = Get.find<Isar>();
  String mapEditingMode = 'none'; // none, add, edit, delete
  String mapGeometryType = 'none'; // point, line, polygon

  final bounds = LatLngBounds.fromPoints([
    LatLng(51.5071 + 0.008, -0.0873 - 0.008),
    LatLng(51.5071 - 0.008, -0.0873 + 0.008),
  ]).obs;

  final markers = <Marker>[].obs;

  @override
  Widget build(BuildContext context) {
    GeoJSONGeometryCollection? geomCollection;

    Function setMapEditingMode = (String val) {
      setState(() {
        mapEditingMode = val;
      });
    };

    Function setMapGeometryType = (String val) {
      setState(() {
        mapGeometryType = val;
      });
    };

    Function onTapMarker = ({double? lng, double? lat}) {
      if (mapEditingMode == 'none') {
        print('TODO: add pop up');
      }
      // TODO: this marker needs state open
      // on press open
      // info window needs close ui to close
      if (mapEditingMode == 'delete') {
        // 1. remove geometry
        geomCollection?.geometries.removeWhere(
          (g) =>
              (g.bbox?.contains(lng) ?? false) &&
              (g.bbox?.contains(lat) ?? false),
        );
        // 2. remove marker
        markers.removeWhere(
          (m) => m.point.latitude == lat && m.point.longitude == lng,
        );
        List<double>? bbox = geomCollection?.bbox;
        // 2. load from row
        Crow? row =
            isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
        if (row != null) {
          row.geometry = geomCollection?.toJSON();
          row.geometryW = bbox?[0];
          row.geometryS = bbox?[1];
          row.geometryE = bbox?[2];
          row.geometryN = bbox?[3];
          row.save();
        }
      }
    };
    if (activeRow?.geometry != null) {
      // draw the geometry of this row
      // TODO: expand to any geometry type
      geomCollection =
          GeoJSONGeometryCollection.fromJSON(activeRow?.geometry ?? '');
      List<double> bbox = geomCollection.bbox;
      // use bbox to zoom
      bounds.value = LatLngBounds.fromPoints([
        LatLng(
          bbox[1] + 0.008,
          bbox[0] - 0.008,
        ),
        LatLng(
          bbox[3] - 0.008,
          bbox[2] + 0.008,
        )
      ]);
      List<GeoJSONGeometry> geometries = geomCollection.geometries;
      geometries.forEach((geometry) {
        //print('geometry: $geometry, type: ${geometry.type}');
        switch (geometry.type) {
          case GeoJSONType.point:
            GeoJSONPoint point = geometry as GeoJSONPoint;
            markers.add(
              // see: https://github.com/fleaflet/flutter_map/issues/184#issuecomment-446754375
              MapMarker(
                lng: point.coordinates[0],
                lat: point.coordinates[1],
                onTap: onTapMarker,
              ),
            );
            break;
          // TODO: add lines and polygons
          default:
            print('don\'t know this geometry\'s type');
        }
      });
    }

// doesn't this need an Obx?
    return FlutterMap(
      mapController: mapController.value,
      options: MapOptions(
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
          // TODO:
          // modularize this
          // and pass in location
          // (aimingMode crosshair: map center, else tap location)
          print('activeRowId: $activeRowId');
          print('tapped $location');
          // Check if an active Row exists
          if (activeRowId == null) return;
          if (mapEditingMode == 'add' && mapGeometryType == 'none') {
            Get.snackbar(
              'Geometry not set',
              'Please choose a geometry type to add',
              snackPosition: SnackPosition.BOTTOM,
            );
            Timer(Duration(milliseconds: 1500), () {
              setMapGeometryType('point');
              Timer(Duration(seconds: 1), () {
                setMapGeometryType('line');
                Timer(Duration(seconds: 1), () {
                  setMapGeometryType('polygon');
                  Timer(Duration(seconds: 1), () {
                    setMapGeometryType('none');
                  });
                });
              });
            });
            return;
          }
          Map<String, dynamic> map = geomCollection?.toMap() ??
              {
                'type': 'GeometryCollection',
                'geometries': [],
              };
          //List<Map<String, dynamic>> geometries = map['geometries'];
          List<dynamic> geometries = map['geometries'];
          switch (mapEditingMode) {
            case 'add':
              markers.add(
                MapMarker(
                  lng: location.longitude,
                  lat: location.latitude,
                  onTap: onTapMarker,
                ),
              );
              geometries.add({
                'type': 'Point',
                'coordinates': [location.longitude, location.latitude]
              });
              break;
            case 'delete':
              // this is caught in the onPressed of the marker
              break;
            default:
              return Get.snackbar(
                'Not yet implemented',
                'Sorry, this feature is still worked on',
                snackPosition: SnackPosition.BOTTOM,
              );
          }
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
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        LocationMarkerLayerWidget(),
        Obx(
          () => MarkerLayerWidget(
            options: MarkerLayerOptions(markers: markers.value),
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
          mapEditingMode: mapEditingMode,
          setMapEditingMode: setMapEditingMode,
          mapGeometryType: mapGeometryType,
          setMapGeometryType: setMapGeometryType,
        ),
      ],
    );
  }
}
