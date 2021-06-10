import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';

dynamic MapTaggedPolyline = ({
  required List<LatLng> points,
  required BuildContext context,
}) {
  return TaggedPolyline(
    points: points,
    color: Theme.of(context).primaryColor,
    strokeWidth: 3.0,
    borderColor: Colors.white,
    borderStrokeWidth: 1.0,
  );
};
