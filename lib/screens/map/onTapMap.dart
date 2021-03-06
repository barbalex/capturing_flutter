import 'dart:async';
import 'package:capturing/models/row.dart';
import 'package:capturing/screens/map/polylineMarker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:geodesy/geodesy.dart';
import './marker.dart';
import 'package:isar/isar.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';

void onTapMap({
  required LatLng location,
  required String mapEditingMode,
  required String mapGeometryType,
  required RxList<Marker> markers,
  required RxList<Marker> polylineMarkers,
  required RxList<LatLng> editingPolylinePoints,
  required RxList<Marker> polygonMarkers,
  required RxList<LatLng> editingPolygonPoints,
  required RxList<Polyline> editingPolygonLines,
  required RxList<Polygon> polygons,
  required Function setMapGeometryType,
  required Function onTapMarker,
  required Rx<PolyEditor> editingPoly,
  required RxList<LatLng> polyEditorPoints,
}) {
  Geodesy geodesy = Geodesy();
  final Isar isar = Get.find<Isar>();
  // TODO:
  // modularize this
  // and pass in location
  // (aimingMode crosshair: map center, else tap location)
  // deleting polygons
  print(
      'onTap, mapEditingMode: ${mapEditingMode}, mapGeometryType: ${mapGeometryType}');
  // Check if an active Row exists
  if (activeRowId == null) {
    // TODO:
    // 1. get id of row clicked
    // 2. ask user if he wants to edit and change url to this row
    // 3. or use this id to edit without changing url
    // 4. instead of returning, go on
    Get.snackbar(
      'Editing not possibe',
      'You need to access the map from a row to edit it\'s geometry',
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }
  if (mapGeometryType == 'none' && mapEditingMode != 'none') {
    Get.snackbar(
      'Geometry not set',
      'Please choose a geometry type to work with',
      snackPosition: SnackPosition.BOTTOM,
    );
    setMapGeometryType('all');
    Timer(Duration(seconds: 1), () {
      setMapGeometryType('none');
      Timer(Duration(seconds: 1), () {
        setMapGeometryType('all');
        Timer(Duration(seconds: 1), () {
          setMapGeometryType('none');
        });
      });
    });
    return;
  }
  GeoJSONPoint? fakePoint;
  GeoJSONGeometryCollection? geomCollection;
  if (activeRow?.geometry == null) {
    // geojson_vi accepts no empty geometry: https://github.com/chuyentt/geojson_vi/issues/16
    fakePoint = GeoJSONPoint([0.01, 0.01]);
    geomCollection = GeoJSONGeometryCollection([fakePoint]);
  } else {
    geomCollection =
        GeoJSONGeometryCollection.fromJSON(activeRow?.geometry ?? '');
  }
  switch (mapGeometryType) {
    case 'point':
      switch (mapEditingMode) {
        case 'add':
          markers.add(
            MapMarker(
              lng: location.longitude,
              lat: location.latitude,
              onTap: onTapMarker,
            ),
          );
          geomCollection.geometries.add(GeoJSONGeometry.fromMap({
            'type': 'Point',
            'coordinates': [location.longitude, location.latitude]
          }));
          break;
        case 'delete':
          // this is caught in the onPressed of the marker
          break;
        case 'none':
          // do nothing
          break;
        case 'edit':
        default:
          Get.snackbar(
            '${mapEditingMode} is not yet implemented',
            'Sorry, this feature is in development',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
      }
      break;
    case 'polyline':
      switch (mapEditingMode) {
        case 'add':
          // on first click: need to create point and add to map
          // on next clicks: additionally add line
          // on end: additionally save polyline to isar
          polylineMarkers.add(
            MapPolylineMarker(
              lng: location.longitude,
              lat: location.latitude,
              onTap: onTapMarker,
            ),
          );
          editingPolylinePoints.add(location);
          break;
        case 'edit':
          editingPoly.value.add(polyEditorPoints.value, location);
          polyEditorPoints.value.add(location);
          break;
        default:
      }
      break;
    case 'polygon':
      switch (mapEditingMode) {
        case 'add':
          // on first click: need to create point and add to map
          // on next clicks: additionally add line
          // on end: additionally save polygon to isar
          polygonMarkers.add(
            MapPolylineMarker(
              lng: location.longitude,
              lat: location.latitude,
              onTap: onTapMarker,
            ),
          );
          editingPolygonPoints.add(location);
          if (editingPolygonPoints.length > 0) {
            List<LatLng> newPoints = [editingPolygonPoints.last, location];
            editingPolygonLines.add(Polyline(points: newPoints));
          }
          break;
        case 'delete':
          // find clicked polygon
          List<Polygon> tappedPolygons = polygons
              .where(
                (polygon) => geodesy.isGeoPointInPolygon(
                  location,
                  polygon.points,
                ),
              )
              .toList();
          List<GeoJSONGeometry> geomsToDelete = geomCollection.geometries
              .where(
                (g) =>
                    g.type == GeoJSONType.polygon &&
                    geodesy.isGeoPointInPolygon(
                      location,
                      (g as GeoJSONPolygon)
                          .coordinates[0]
                          .map((e) => LatLng(e[1], e[0]))
                          .toList(),
                    ),
              )
              .toList();
          // find row. Assume activeRowId
          // TODO: extend for case with geometries of all rows
          geomsToDelete.forEach((element) {
            geomCollection?.geometries.remove(element);
          });
          tappedPolygons.forEach((element) {
            polygons.remove(element);
          });
          break;
        default:
      }
      break;
    case 'none':
      // do nothing
      break;
    default:
      Get.snackbar(
        mapEditingMode == 'add'
            ? '${mapEditingMode} is not yet implemented for ${mapGeometryType}'
            : '${mapEditingMode} is not yet implemented',
        'Sorry, this feature is in development',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
  }
  List<double?>? bbox;
  String? geometry;
  if (fakePoint != null) {
    if (geomCollection.geometries.length > 1) {
      geomCollection.geometries.remove(fakePoint);
    } else {
      geometry = null;
    }
  }
  if (geomCollection.geometries.length > 0) {
    bbox = geomCollection.bbox;
    geometry = geomCollection.toJSON();
  }
  // 2. change and save row
  Crow? row = isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
  if (row != null) {
    //print('saving. geometry: $geometry, bbox?[0]: ${bbox?[0]}');
    row.geometry = geometry;
    row.geometryW = bbox?[0];
    row.geometryS = bbox?[1];
    row.geometryE = bbox?[2];
    row.geometryN = bbox?[3];
    row.save();
  }
}
