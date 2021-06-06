import 'dart:async';
import 'package:async/async.dart' show StreamGroup;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import './zoombuttons_plugin_option.dart';
import './scale_layer_plugin_option.dart';
import './marker.dart';
import './polylineMarker.dart';
import './editingPolyline.dart';
import './polyline.dart';
import 'polygon.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:capturing/store.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'menu/index.dart';
import 'package:geodesy/geodesy.dart';

class MapMapWidget extends StatefulWidget {
  @override
  _MapMapWidgetState createState() => _MapMapWidgetState();
}

class _MapMapWidgetState extends State<MapMapWidget> {
  final Isar isar = Get.find<Isar>();
  MapController mapController = MapController();
  String mapEditingMode = 'none'; // none, add, edit, delete
  String mapGeometryType = 'none'; // point, polyline, polygon
  String mapSelectionMode = 'tap'; // tap, crosshair
  double lat = -0.09;
  double lng = 51.5;

  final bounds = LatLngBounds.fromPoints([
    LatLng(51.5071 + 0.008, -0.0873 - 0.008),
    LatLng(51.5071 - 0.008, -0.0873 + 0.008),
  ]).obs;

  final markers = <Marker>[].obs;
  final polylineMarkers = <Marker>[].obs;
  final polygonMarkers = <Marker>[].obs;
  List<LatLng> editingPolylinePoints = [];
  final polylines = <Polyline>[].obs;
  List<LatLng> editingPolygonPoints = [];
  List<Polyline> polygonLines = [];
  final polygons = <Polygon>[].obs;

  @override
  Widget build(BuildContext context) {
    GeoJSONGeometryCollection? geomCollection;
    final editingPolyline = MapEditingPolyline(points: editingPolylinePoints);
    polylines.add(editingPolyline);
    // final editingPolygon = MapEditingPolyline(points: editingPolygonPoints);
    // polygonLines.add(editingPolygon);
    Geodesy geodesy = Geodesy();

    ever(markers, (_) {
      setState(() {});
    });
    ever(polylineMarkers, (_) {
      setState(() {});
    });

    Function setMapEditingMode = (String val) {
      setState(() {
        mapEditingMode = val;
      });
    };
    Function setMapGeometryType = (String val) {
      setState(() {
        mapGeometryType = val;
      });
    };
    Function setMapSelectionMode = (String val) {
      setState(() {
        mapSelectionMode = val;
      });
    };
    Function resetEditingPolylinePoints = () {
      polylineMarkers.value = [];
      setState(() {
        editingPolylinePoints = [];
      });
    };
    Function resetEditingPolygon = () {
      polygonMarkers.value = [];
      setState(() {
        polygonLines = [];
        editingPolygonPoints = [];
      });
    };

    Function onTapMarker = ({double? lng, double? lat}) {
      switch (mapEditingMode) {
        case 'none':
          // TODO: this marker needs state open
          // on press open
          // info window needs close ui to close
          print('TODO: add pop up');
          break;
        case 'delete':
          // 1. remove geometry
          geomCollection?.geometries.removeWhere(
            (g) =>
                (g.bbox?.contains(lng) ?? false) &&
                (g.bbox?.contains(lat) ?? false),
          );
          // 2. remove marker
          markers.removeWhere(
            (m) => m.point.latitude == lat && m.point.longitude == lng,
          );
          List<double>? bbox = geomCollection?.bbox;
          // 2. load from row
          Crow? row =
              isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
          if (row != null) {
            row.geometry = geomCollection?.toJSON();
            row.geometryW = bbox?[0];
            row.geometryS = bbox?[1];
            row.geometryE = bbox?[2];
            row.geometryN = bbox?[3];
            row.save();
          }
          break;
        default:
        // Do nothiing
      }
    };

    if (activeRow?.geometry != null) {
      // draw the geometry of this row
      // TODO: expand to any geometry type
      geomCollection =
          GeoJSONGeometryCollection.fromJSON(activeRow?.geometry ?? '');
      List<double> bbox = geomCollection.bbox;
      // use bbox to zoom
      bounds.value = LatLngBounds.fromPoints([
        LatLng(
          bbox[1] + 0.008,
          bbox[0] - 0.008,
        ),
        LatLng(
          bbox[3] - 0.008,
          bbox[2] + 0.008,
        )
      ]);
      List<GeoJSONGeometry> geometries = geomCollection.geometries;
      geometries.forEach((geometry) {
        switch (geometry.type) {
          case GeoJSONType.point:
            GeoJSONPoint point = geometry as GeoJSONPoint;
            markers.add(
              // see: https://github.com/fleaflet/flutter_map/issues/184#issuecomment-446754375
              MapMarker(
                lng: point.coordinates[0],
                lat: point.coordinates[1],
                onTap: onTapMarker,
              ),
            );
            break;
          case GeoJSONType.lineString:
            GeoJSONLineString polyline = geometry as GeoJSONLineString;
            polylines.add(
              MapPolyline(
                points: polyline.coordinates
                    .map((e) => LatLng(e[1], e[0]))
                    .toList(),
                context: context,
              ),
            );
            break;
          case GeoJSONType.polygon:
            GeoJSONPolygon polygon = geometry as GeoJSONPolygon;
            polygons.add(
              MapPolygon(
                points: polygon.coordinates
                    .expand(
                      (a) => a.map((e) => LatLng(e[1], e[0])).toList(),
                    )
                    .toList(),
                context: context,
              ),
            );
            break;
          // TODO: add lines and polygons
          default:
            print('don\'t know this geometry\'s type');
        }
      });
    }

    MarkerLayerOptions markerLayerOptions =
        MarkerLayerOptions(markers: markers.value);
    MarkerLayerOptions polylineMarkerLayerOptions =
        MarkerLayerOptions(markers: polylineMarkers.value);
    MarkerLayerOptions polygonMarkerLayerOptions =
        MarkerLayerOptions(markers: polygonMarkers.value);
    PolylineLayerOptions polylineLayerOptions =
        PolylineLayerOptions(polylines: polylines.value);
    PolylineLayerOptions polygonLineLayerOptions =
        PolylineLayerOptions(polylines: polygonLines);
    PolygonLayerOptions polygonLayerOptions =
        PolygonLayerOptions(polygons: polygons.value);
    List<LayerOptions> layerGroup = mapGeometryType == 'point'
        ? [
            polygonLayerOptions,
            polygonMarkerLayerOptions,
            polygonLineLayerOptions,
            polylineMarkerLayerOptions,
            polylineLayerOptions,
            markerLayerOptions,
          ]
        : mapGeometryType == 'polyline'
            ? [
                polygonLayerOptions,
                polygonMarkerLayerOptions,
                polygonLineLayerOptions,
                markerLayerOptions,
                polylineLayerOptions,
                polylineMarkerLayerOptions,
              ]
            : [
                markerLayerOptions,
                polylineMarkerLayerOptions,
                polylineLayerOptions,
                polygonLayerOptions,
                polygonLineLayerOptions,
                polygonMarkerLayerOptions,
              ];

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        bounds: bounds.value,
        controller: mapController,
        plugins: [
          ZoomButtonsPlugin(),
          ScaleLayerPlugin(),
        ],
        // DANGER: this callback needs to be async because flutter calls it
        // before the widget is finished building
        // see: https://stackoverflow.com/a/51273797/712005
        // and https://github.com/fleaflet/flutter_map/issues/374#issuecomment-854527680
        onPositionChanged: (MapPosition position, bool hasGesture) async {
          double? newLat = position.center?.latitude;
          double? newLng = position.center?.longitude;
          if (newLat != null && newLng != null) {
            setState(() {
              lat = newLat;
              lng = newLng;
            });
          }
        },
        onTap: (LatLng location) {
          // TODO:
          // modularize this
          // and pass in location
          // (aimingMode crosshair: map center, else tap location)
          // deleting polygons
          print(
              'onTap, mapEditingMode: $mapEditingMode, mapGeometryType: $mapGeometryType');
          // Check if an active Row exists
          if (activeRowId == null) return;
          if (mapGeometryType == 'none') {
            Get.snackbar(
              'Geometry not set',
              'Please choose a geometry type to work with',
              snackPosition: SnackPosition.BOTTOM,
            );
            setMapGeometryType('all');
            Timer(Duration(seconds: 1), () {
              setMapGeometryType('none');
              Timer(Duration(seconds: 1), () {
                setMapGeometryType('all');
                Timer(Duration(seconds: 1), () {
                  setMapGeometryType('none');
                });
              });
            });
            return;
          }
          GeoJSONGeometryCollection geomCollection =
              GeoJSONGeometryCollection.fromJSON(activeRow?.geometry ?? '[]');
          switch (mapGeometryType) {
            case 'point':
              switch (mapEditingMode) {
                case 'add':
                  markers.add(
                    MapMarker(
                      lng: location.longitude,
                      lat: location.latitude,
                      onTap: onTapMarker,
                    ),
                  );
                  geomCollection.geometries.add(GeoJSONGeometry.fromMap({
                    'type': 'Point',
                    'coordinates': [location.longitude, location.latitude]
                  }));
                  break;
                case 'delete':
                  // this is caught in the onPressed of the marker
                  break;
                case 'edit':
                default:
                  return Get.snackbar(
                    '$mapEditingMode is not yet implemented',
                    'Sorry, this feature is in development',
                    snackPosition: SnackPosition.BOTTOM,
                  );
              }
              break;
            case 'polyline':
              switch (mapEditingMode) {
                case 'add':
                  // on first click: need to create point and add to map
                  // on next clicks: additionally add line
                  // on end: additionally save polyline to isar
                  polylineMarkers.add(
                    MapPolylineMarker(
                      lng: location.longitude,
                      lat: location.latitude,
                      onTap: onTapMarker,
                    ),
                  );
                  editingPolylinePoints.add(location);
                  setState(() {});
                  break;
                default:
              }
              break;
            case 'polygon':
              switch (mapEditingMode) {
                case 'add':
                  // TODO:
                  // on first click: need to create point and add to map
                  // on next clicks: additionally add line
                  // on end: additionally save polygon to isar
                  polygonMarkers.add(
                    MapPolylineMarker(
                      lng: location.longitude,
                      lat: location.latitude,
                      onTap: onTapMarker,
                    ),
                  );
                  editingPolygonPoints.add(location);
                  // remember: editingPolygonPoints will not update before setState!
                  if (editingPolygonPoints.length > 0) {
                    List<LatLng> newPoints = [
                      editingPolygonPoints.last,
                      location
                    ];
                    polygonLines.add(Polyline(points: newPoints));
                  }
                  setState(() {});
                  break;
                case 'delete':
                  // find clicked polygon
                  List<Polygon> tappedPolygons = polygons
                      .where(
                        (polygon) => geodesy.isGeoPointInPolygon(
                          location,
                          polygon.points,
                        ),
                      )
                      .toList();
                  print('onTap, tappedPolygons: $tappedPolygons');
                  // find row. Assume activeRowId
                  // TODO: extend for case without geometries of all rows
                  tappedPolygons.forEach((polygon) {
                    geomCollection.geometries
                        .where((g) => g.type == GeoJSONType.polygon)
                        .toList()
                        .removeWhere(
                          (g) =>
                              (g as GeoJSONPolygon).coordinates ==
                              polygon.points,
                        );
                  });
                  polygons.removeWhere((e) => tappedPolygons.contains(e));
                  break;
                default:
              }
              break;
            default:
              return Get.snackbar(
                mapEditingMode == 'add'
                    ? '$mapEditingMode is not yet implemented for $mapGeometryType'
                    : '$mapEditingMode is not yet implemented',
                'Sorry, this feature is in development',
                snackPosition: SnackPosition.BOTTOM,
              );
          }
          List<double>? bbox = geomCollection.bbox;
          // 2. load from row
          Crow? row =
              isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
          if (row != null) {
            row.geometry = geomCollection.toJSON();
            row.geometryW = bbox[0];
            row.geometryS = bbox[1];
            row.geometryE = bbox[2];
            row.geometryN = bbox[3];
            row.save();
          }
        },
      ),
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        LocationMarkerLayerWidget(),
        // need Obx? but errors...
        GroupLayerWidget(
          options: GroupLayerOptions(
            key: Key('grouplayer'),
            group: layerGroup,
            rebuild: StreamGroup.merge([
              markers.stream,
              polylineMarkers.stream,
              polylines.stream,
              polygonMarkers.stream,
              //polygonLines.stream,
            ]).map((event) => null),
          ),
        ),
      ],
      nonRotatedLayers: [
        ZoomButtonsPluginOption(
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomRight,
        ),
        ScaleLayerPluginOption(
          lineColor: Theme.of(context).primaryColor,
          lineWidth: 2,
          textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
          ),
          padding: EdgeInsets.all(10),
        ),
      ],
      nonRotatedChildren: [
        // show coordinates widget
        Padding(
          padding: EdgeInsets.only(top: 33, left: 10),
          child: Align(
            child: Text(
              'Lat: ${lat.toPrecision(4)}, Lng: ${lng.toPrecision(4)}',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            alignment: Alignment.topLeft,
          ),
        ),
        MapMenu(
          mapEditingMode: mapEditingMode,
          setMapEditingMode: setMapEditingMode,
          mapGeometryType: mapGeometryType,
          setMapGeometryType: setMapGeometryType,
          mapSelectionMode: mapSelectionMode,
          setMapSelectionMode: setMapSelectionMode,
          mapController: mapController,
          editingPolylinePoints: editingPolylinePoints,
          resetEditingPolylinePoints: resetEditingPolylinePoints,
          resetEditingPolygon: resetEditingPolygon,
          editingPolygonPoints: editingPolygonPoints,
          polygonLines: polygonLines,
        ),
      ],
    );
  }
}
