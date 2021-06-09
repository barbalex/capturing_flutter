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
import './editingPolyline.dart';
import './onTapMap.dart';
import 'addRowGeometryToLayers.dart';
import 'addTableGeometryToLayers.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:capturing/store.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'menu/index.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Isar isar = Get.find<Isar>();
  MapController mapController = MapController();
  final mapEditingMode = 'none'.obs; // none, add, edit, delete
  final mapGeometryType = 'none'.obs; // point, polyline, polygon
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
  final editingPolylinePoints = <LatLng>[].obs;
  final polylines = <Polyline>[].obs;
  final editingPolygonPoints = <LatLng>[].obs;
  final editingPolygonLines = <Polyline>[].obs;
  final polygons = <Polygon>[].obs;
  final popupMarkers = <Marker>[].obs;
  late StreamSubscription<void> rowGeometryListener;

  @override
  void initState() {
    super.initState();

    ever(markers, (_) async {
      setState(() {});
    });
    ever(polylineMarkers, (_) async {
      setState(() {});
    });
    ever(polygonMarkers, (_) async {
      setState(() {});
    });
    if (activeRowId != null) {
      rowGeometryListener = isar.crows
          .where()
          .idEqualTo(activeRowId as String)
          .geometryProperty()
          .watchLazy()
          .listen((event) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    rowGeometryListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: set collection with empty geometry once this is possible
    // see: https://github.com/chuyentt/geojson_vi/issues/16
    GeoJSONGeometryCollection geomCollection = GeoJSONGeometryCollection([]);
    //GeoJSONGeometryCollection? geomCollection;
    final editingPolyline =
        MapEditingPolyline(points: editingPolylinePoints.value);
    polylines.add(editingPolyline);
    final editingPolygonline =
        MapEditingPolyline(points: editingPolygonPoints.value);
    editingPolygonLines.add(editingPolygonline);

    Function setMapEditingMode = (String val) {
      mapEditingMode.value = val;
    };
    Function setMapGeometryType = (String val) {
      mapGeometryType.value = val;
    };
    Function setMapSelectionMode = (String val) {
      setState(() {
        mapSelectionMode = val;
      });
    };
    Function resetEditingPolylinePoints = () {
      polylineMarkers.value = [];
      editingPolylinePoints.value = [];
    };
    Function resetEditingPolygon = () {
      polygonMarkers.value = [];
      editingPolygonLines.value = [];
      editingPolygonPoints.value = [];
    };

    Function onTapMarker = ({double? lng, double? lat}) {
      // TODO:
      // 1. if no activeRowId exists, open popup
      // 2. show some data
      //    let user choose edit or showing row
      //    maybe always edit if mapEditingMode and ...geometry are set
      if (activeRowId == null) {
        if (mapEditingMode == 'none' || mapGeometryType == 'none') {
          // user does not want to edit > open popup
          // TODO:
          return;
        }
      }
      switch (mapEditingMode.value) {
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
                g.type == GeoJSONType.point &&
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

    // TODO: decide what data to show
    // if activeRow exists: it's geometry
    // else if activeTable exists: it's geometry
    // else if activeProject exists: it's geometry
    // else: all project's geometries
    bool activeRowExists = activeRowId != null;
    bool activeTableExists = activeTableId != null;
    bool activeProjectExists = activeProjectId != null;
    bool showActiveRow = activeRowExists;
    bool showActiveTable = !activeRowExists && activeTableExists;
    bool showActiveProject =
        !activeRowExists && !activeTableExists && activeProjectExists;
    bool showAllProjects =
        !activeRowExists && !activeTableExists && !activeProjectExists;

    if (showActiveRow) {
      // TODO:
      // need to pass in empty GeoJSONGeometryCollection and ensure all tables are added
      // wait for geojson_vi to enable this: https://github.com/chuyentt/geojson_vi/issues/16
      if (activeRow?.geometry != null) {
        geomCollection =
            GeoJSONGeometryCollection.fromJSON(activeRow?.geometry as String);
      }
      addRowGeometryToLayers(
        context: context,
        geometries: geomCollection?.geometries,
        markers: markers,
        polylines: polylines,
        polygons: polygons,
        onTapMarker: onTapMarker,
      );
    }
    if (showActiveTable) {
      // TODO: create own layer
      addTableGeometryToLayers(
        context: context,
        markers: markers,
        polylines: polylines,
        polygons: polygons,
        onTapMarker: onTapMarker,
        tableId: activeTableId as String,
        geomCollection: geomCollection,
      );
    }
    if (showActiveProject) {
      // 1. fetch this projects tables
      List<String> tableIds = isar.ctables
          .where()
          .filter()
          .projectIdEqualTo(activeProjectId)
          .and()
          .deletedEqualTo(false)
          .idProperty()
          .findAllSync();
      tableIds.forEach((tableId) {
        // TODO: create own layer
        addTableGeometryToLayers(
          context: context,
          markers: markers,
          polylines: polylines,
          polygons: polygons,
          onTapMarker: onTapMarker,
          tableId: tableId,
          geomCollection: geomCollection,
        );
      });
    }
    if (showAllProjects) {
      // 0fetch all projects
      // 1. fetch this projects tables
      List<String> projectIds = isar.projects
          .where()
          .filter()
          .deletedEqualTo(false)
          .idProperty()
          .findAllSync();
      projectIds.forEach((projectId) {
        List<String> tableIds = isar.ctables
            .where()
            .filter()
            .projectIdEqualTo(projectId)
            .and()
            .deletedEqualTo(false)
            .idProperty()
            .findAllSync();
        tableIds.forEach((tableId) {
          // TODO: create own layer
          addTableGeometryToLayers(
            context: context,
            markers: markers,
            polylines: polylines,
            polygons: polygons,
            onTapMarker: onTapMarker,
            tableId: tableId,
            geomCollection: geomCollection,
          );
        });
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
        PolylineLayerOptions(polylines: editingPolygonLines.value);
    PolygonLayerOptions polygonLayerOptions =
        PolygonLayerOptions(polygons: polygons.value);
    List<LayerOptions> layerGroup = mapGeometryType.value == 'point'
        ? [
            polygonLayerOptions,
            polygonMarkerLayerOptions,
            polygonLineLayerOptions,
            polylineMarkerLayerOptions,
            polylineLayerOptions,
            markerLayerOptions,
          ]
        : mapGeometryType.value == 'polyline'
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
    if (geomCollection?.bbox != null) {
      List<double> bbox = geomCollection?.bbox as List<double>;
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
    }

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
          onTapMap(
            location: location,
            mapEditingMode: mapEditingMode.value,
            mapGeometryType: mapGeometryType.value,
            markers: markers,
            polylineMarkers: polylineMarkers,
            editingPolylinePoints: editingPolylinePoints,
            polygonMarkers: polygonMarkers,
            editingPolygonPoints: editingPolygonPoints,
            editingPolygonLines: editingPolygonLines,
            polygons: polygons,
            setMapGeometryType: setMapGeometryType,
            onTapMarker: onTapMarker,
          );
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
              editingPolylinePoints.stream,
              polylines.stream,
              polygonMarkers.stream,
              editingPolygonPoints.stream,
              editingPolygonLines.stream,
              polygons.stream,
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
          editingPolygonLines: editingPolygonLines,
        ),
      ],
    );
  }
}
