import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapPolyline = ({
  required List<LatLng> points,
}) {
  return Polyline(
    points: points,
    color: Colors.black,
    strokeWidth: 5,
    borderColor: Colors.white,
    borderStrokeWidth: 3,
  );
};
