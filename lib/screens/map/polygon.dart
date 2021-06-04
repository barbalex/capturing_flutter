import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapPolygon = ({
  required List<LatLng> points,
}) {
  return Polygon(
    points: points,
    color: Colors.black,
    borderStrokeWidth: 5,
  );
};
