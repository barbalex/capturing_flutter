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
  final RxString mapGeometryType;
  final Function setMapGeometryType;
  final RxList<LatLng> editingPolylinePoints;
  final Function resetEditingPolylinePoints;
  final Function resetEditingPolygon;
  final RxList<LatLng> editingPolygonPoints;
  final RxList<Polyline> polygonLines;

  MapMenuGeometry({
    required this.mapGeometryType,
    required this.setMapGeometryType,
    required this.editingPolylinePoints,
    required this.resetEditingPolylinePoints,
    required this.resetEditingPolygon,
    required this.editingPolygonPoints,
    required this.polygonLines,
  });

  @override
  Widget build(BuildContext context) {
    final Isar isar = Get.find<Isar>();
    final toggleButtonsSelected = <bool>[
      ['point', 'all'].contains(mapGeometryType.value),
      ['polyline', 'all'].contains(mapGeometryType.value),
      ['polygon', 'all'].contains(mapGeometryType.value),
    ].obs;

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Obx(
        () => ToggleButtons(
          children: [
            Tooltip(
              child: Icon(Icons.center_focus_weak_outlined),
              message: mapGeometryType.value == 'point'
                  ? 'stop adding points'
                  : 'add points',
            ),
            Tooltip(
              child: Icon(Icons.linear_scale),
              message: mapGeometryType.value == 'polyline'
                  ? 'stop adding lines'
                  : 'add lines',
            ),
            Tooltip(
              child: Icon(FontAwesomeIcons.drawPolygon),
              message: mapGeometryType.value == 'polygon'
                  ? 'stop adding polygons'
                  : 'add polygons',
            ),
          ],
          isSelected: toggleButtonsSelected,
          onPressed: (int index) async {
            toggleButtonsSelected[index] = true;
            switch (index) {
              case 0:
                if (mapGeometryType.value == 'point') {
                  setMapGeometryType('none');
                } else {
                  setMapGeometryType('point');
                }
                break;
              case 1:
                if (mapGeometryType.value == 'polyline') {
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
                if (mapGeometryType.value == 'polygon') {
                  setMapGeometryType('none');
                  // if editingPolygonePoints.length > 2
                  // save it to row.geometry
                  // and reset editingPolygonPoints
                  if (editingPolygonPoints.length < 3) return;
                  GeoJSONGeometryCollection geomCollection =
                      activeRow?.geometry != null
                          ? GeoJSONGeometryCollection.fromJSON(
                              activeRow?.geometry ?? '')
                          : GeoJSONGeometryCollection([]);
                  // need to add last point with same position as first
                  editingPolygonPoints.add(editingPolygonPoints.first);
                  List<List<List<double>>> coordinates = [
                    editingPolygonPoints
                        .map((e) => [e.longitude, e.latitude])
                        .toList()
                  ];
                  polygonLines.add(Polyline(points: [
                    editingPolygonPoints.last,
                    editingPolygonPoints.first,
                  ]));
                  // build polygon
                  GeoJSONGeometry polygon = GeoJSONGeometry.fromMap({
                    "type": "Polygon",
                    "coordinates": coordinates,
                  });
                  geomCollection.geometries.add(polygon);
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
                  resetEditingPolygon();
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
      ),
    );
  }
}
