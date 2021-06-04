import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapEditingPolyline = ({
  required List<LatLng> points,
}) {
  return Polyline(
    points: points,
    color: Colors.red,
    strokeWidth: 2,
  );
};
