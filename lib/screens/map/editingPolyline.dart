import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';

dynamic MapEditingPolyline = ({
  required List<LatLng> points,
}) {
  return TaggedPolyline(
    points: points,
    color: Colors.red,
    strokeWidth: 2.0,
  );
};
