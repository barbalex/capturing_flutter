import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import './marker.dart';
import './polyline.dart';
import 'polygon.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:geodesy/geodesy.dart';

void addRowGeometryToLayers({
  required BuildContext context,
  GeoJSONGeometryCollection? geomCollection,
  required RxList<Marker> markers,
  required RxList<Polyline> polylines,
  required RxList<Polygon> polygons,
  required Function onTapMarker,
}) {
  if (geomCollection == null) return;
  // draw the geometry of this row
  List<GeoJSONGeometry> geometries = geomCollection.geometries;
  geometries.forEach((geometry) {
    switch (geometry.type) {
      case GeoJSONType.point:
        GeoJSONPoint point = geometry as GeoJSONPoint;
        print('adding point $point');
        markers.add(
          // see: https://github.com/fleaflet/flutter_map/issues/184#issuecomment-446754375
          MapMarker(
            lng: point.coordinates[0],
            lat: point.coordinates[1],
            onTap: onTapMarker,
          ),
        );
        break;
      case GeoJSONType.lineString:
        GeoJSONLineString polyline = geometry as GeoJSONLineString;
        polylines.add(
          MapPolyline(
            points:
                polyline.coordinates.map((e) => LatLng(e[1], e[0])).toList(),
            context: context,
          ),
        );
        break;
      case GeoJSONType.polygon:
        GeoJSONPolygon polygon = geometry as GeoJSONPolygon;
        polygons.add(
          MapPolygon(
            points: polygon.coordinates
                .expand(
                  (a) => a.map((e) => LatLng(e[1], e[0])).toList(),
                )
                .toList(),
            context: context,
          ),
        );
        break;
      default:
        print('don\'t know this geometry\'s type');
    }
  });
}
