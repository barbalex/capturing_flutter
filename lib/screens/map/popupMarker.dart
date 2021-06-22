import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

dynamic PopupMarker = ({
  required double lng,
  required double lat,
}) =>
    Marker(
      point: LatLng(lat, lng),
      builder: (context) => Icon(
        Icons.center_focus_weak_outlined,
        color: Theme.of(context).primaryColor,
      ),
    );
