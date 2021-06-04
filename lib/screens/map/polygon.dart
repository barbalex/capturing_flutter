import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapPolygon = ({
  required List<LatLng> points,
  required BuildContext context,
}) {
  return Polygon(
    points: points,
    color: Theme.of(context).primaryColor.withOpacity(0.05),
    borderStrokeWidth: 2,
    borderColor: Theme.of(context).primaryColor,
  );
};
