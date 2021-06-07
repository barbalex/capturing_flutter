import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'addRowGeometryToLayers.dart';
import 'package:capturing/store.dart';

void addTableGeometryToLayers({
  required BuildContext context,
  required RxList<Marker> markers,
  required RxList<Polyline> polylines,
  required RxList<Polygon> polygons,
  required Function onTapMarker,
}) {
  final Isar isar = Get.find<Isar>();
  GeoJSONGeometryCollection? geomCollection;
  // 1. fetch this tables rows
  dynamic geometries = isar.crows
      .where()
      .filter()
      .tableIdEqualTo(activeTableId as String)
      .and()
      .deletedEqualTo(false)
      .and()
      .not()
      .geometryIsNull()
      .geometryProperty()
      .findAllSync();
  // 2. and add each geometry
  geometries.forEach((geometry) {
    if (geomCollection == null) {
      geomCollection = GeoJSONGeometryCollection.fromJSON(geometry as String);
    }
    GeoJSONGeometryCollection? thisGeomCollection =
        GeoJSONGeometryCollection.fromJSON(geometry);
    addRowGeometryToLayers(
      context: context,
      geomCollection: thisGeomCollection,
      markers: markers,
      polylines: polylines,
      polygons: polygons,
      onTapMarker: onTapMarker,
    );
    geomCollection?.geometries.addAll(thisGeomCollection.geometries);
  });
}
