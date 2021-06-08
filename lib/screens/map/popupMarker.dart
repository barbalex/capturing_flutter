import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic MapMarker = ({
  required Function onTap,
  required double lng,
  required double lat,
}) {
  LatLng latLng = LatLng(lat, lng);

  // see: https://github.com/fleaflet/flutter_map/issues/184#issuecomment-446754375
  // TODO: add Draggable for editing?
  return Marker(
    //width: 40.0,
    //height: 40.0,
    point: latLng,
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Icon(
        Icons.center_focus_weak_outlined,
        color: Theme.of(context).primaryColor,
      ),
      onTap: () => onTap(
        lng: lng,
        lat: lat,
      ),
    ),
  );
};
