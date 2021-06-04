import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapPolyline = ({
  required List<LatLng> points,
  required BuildContext context,
}) {
  return Polyline(
    points: points,
    color: Theme.of(context).primaryColor,
    strokeWidth: 3,
    borderColor: Colors.white,
    borderStrokeWidth: 1,
  );
};
