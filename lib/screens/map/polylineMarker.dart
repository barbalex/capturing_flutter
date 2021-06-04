import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapPolylineMarker = ({
  required Function onTap,
  required double lng,
  required double lat,
}) {
  LatLng latLng = LatLng(lat, lng);

  // see: https://github.com/fleaflet/flutter_map/issues/184#issuecomment-446754375
  // TODO: add Draggable for editing?
  return Marker(
    point: latLng,
    builder: (ctx) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Icon(
        Icons.adjust,
        color: Colors.red,
      ),
      onTap: () => onTap(
        lng: lng,
        lat: lat,
      ),
    ),
  );
};
