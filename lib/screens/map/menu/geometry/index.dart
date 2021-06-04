import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:capturing/store.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:latlong2/latlong.dart';

class MapMenuGeometry extends StatelessWidget {
  final String mapGeometryType;
  final Function setMapGeometryType;
  final List<LatLng> editingPolylinePoints;
  final Function resetEditingPolylinePoints;

  MapMenuGeometry({
    required this.mapGeometryType,
    required this.setMapGeometryType,
    required this.editingPolylinePoints,
    required this.resetEditingPolylinePoints,
  });

  @override
  Widget build(BuildContext context) {
    final Isar isar = Get.find<Isar>();
    final toggleButtonsSelected = <bool>[
      ['point', 'all'].contains(mapGeometryType),
      ['polyline', 'all'].contains(mapGeometryType),
      ['polygon', 'all'].contains(mapGeometryType),
    ].obs;

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: ToggleButtons(
        children: [
          Tooltip(
            child: Icon(Icons.center_focus_weak_outlined),
            message: mapGeometryType == 'point'
                ? 'stop adding points'
                : 'add points',
          ),
          Tooltip(
            child: Icon(Icons.linear_scale),
            message: mapGeometryType == 'polyline'
                ? 'stop adding lines'
                : 'add lines',
          ),
          Tooltip(
            child: Icon(FontAwesomeIcons.drawPolygon),
            message: mapGeometryType == 'polygon'
                ? 'stop adding polygons'
                : 'add polygons',
          ),
        ],
        isSelected: toggleButtonsSelected,
        onPressed: (int index) async {
          toggleButtonsSelected[index] = true;
          switch (index) {
            case 0:
              if (mapGeometryType == 'point') {
                setMapGeometryType('none');
              } else {
                setMapGeometryType('point');
              }
              break;
            case 1:
              if (mapGeometryType == 'polyline') {
                setMapGeometryType('none');
                // if editingPolylinePoints.length > 1
                // save it to row.geometry
                // and reset editingPolylinePoints
                if (editingPolylinePoints.length < 2) return;
                GeoJSONGeometryCollection geomCollection =
                    activeRow?.geometry != null
                        ? GeoJSONGeometryCollection.fromJSON(
                            activeRow?.geometry ?? '')
                        : GeoJSONGeometryCollection([]);
                // TODO:
                // Unhandled Exception: type 'Polyline' is not a subtype of type 'GeoJSONGeometry' of 'value'
                GeoJSONGeometry line = GeoJSONGeometry.fromMap({
                  "type": "LineString",
                  "coordinates": editingPolylinePoints
                      .map((e) => [e.longitude, e.latitude])
                      .toList()
                });
                geomCollection.geometries.add(line);
                List<double>? bbox = geomCollection.bbox;
                // 2. load from row
                Crow? row = isar.crows
                    .where()
                    .idEqualTo(activeRowId ?? '')
                    .findFirstSync();
                if (row != null) {
                  row.geometry = geomCollection.toJSON();
                  row.geometryW = bbox[0];
                  row.geometryS = bbox[1];
                  row.geometryE = bbox[2];
                  row.geometryN = bbox[3];
                  row.save();
                }
                resetEditingPolylinePoints();
              } else {
                setMapGeometryType('polyline');
              }
              break;
            case 2:
            default:
              if (mapGeometryType == 'polygon') {
                setMapGeometryType('none');
              } else {
                setMapGeometryType('polygon');
              }
              break;
          }
        },
        direction: Axis.vertical,
        selectedColor: Colors.white,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
        selectedBorderColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
