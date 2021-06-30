import 'dart:async';
import 'package:async/async.dart' show StreamGroup;
import 'package:capturing/screens/projects/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/models/tileLayer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import './zoombuttons_plugin_option.dart';
import './scale_layer_plugin_option.dart';
import './editingPolyline.dart';
import './onTapMap.dart';
import './popup.dart';
import 'addRowGeometryToLayers.dart';
import 'addTableGeometryToLayers.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:capturing/store.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'menu/index.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:capturing/screens/map/transformProjection.dart';

class MapWidget extends StatefulWidget {
  final MapController mapController;
  MapWidget({required this.mapController});
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Isar isar = Get.find<Isar>();
  final mapEditingMode = 'none'.obs; // none, add, edit, delete
  final mapGeometryType = 'none'.obs; // point, polyline, polygon
  String mapSelectionMode = 'tap'; // tap, crosshair
  final lat = RxDouble(-0.09);
  final lng = 51.5.obs;

  final bounds = LatLngBounds.fromPoints([
    LatLng(51.5071 + 0.008, -0.0873 - 0.008),
    LatLng(51.5071 - 0.008, -0.0873 + 0.008),
  ]).obs;

  final markers = <Marker>[].obs;
  final polylineMarkers = <Marker>[].obs;
  final polygonMarkers = <Marker>[].obs;
  final editingPolylinePoints = <LatLng>[].obs;
  final polylines = <TaggedPolyline>[].obs;
  final editingPolygonPoints = <LatLng>[].obs;
  final editingPolygonLines = <Polyline>[].obs;
  final polygons = <Polygon>[].obs;
  final popupMarkers = <Marker>[].obs;
  late StreamSubscription<void> rowGeometryListener;
  final polyEditorPoints = <LatLng>[].obs;
  final polyEditorLines = <Polyline>[].obs;
  late Rx<PolyEditor> editingPoly;

  // TODO: set collection with empty geometry once this is possible
  // see: https://github.com/chuyentt/geojson_vi/issues/16
  GeoJSONGeometryCollection geomCollection = GeoJSONGeometryCollection([]);
  //GeoJSONGeometryCollection? geomCollection;

  @override
  void initState() {
    super.initState();

    if (activeLayers.length == 0) {
      activeLayers.value = isar.projectTileLayers
          .where()
          .activeEqualTo(true)
          .idProperty()
          .findAllSync();
    }

    everAll([
      markers,
      polylineMarkers,
      polygonMarkers,
      polyEditorPoints,
      polyEditorLines,
      activeLayers,
      mapEditing,
    ], (_) async {
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
    if (activeRow?.geometry != null) {
      geomCollection =
          GeoJSONGeometryCollection.fromJSON(activeRow?.geometry as String);
    }
    polyEditorLines.value.addAll(geomCollection.geometries
        .where((g) => g.type == GeoJSONType.lineString)
        .map((e) {
      GeoJSONLineString geoJSONLineString = e as GeoJSONLineString;
      List<List<double>> coordinates = geoJSONLineString.coordinates;
      return Polyline(
          points: coordinates.map((e) => LatLng(e[1], e[0])).toList());
    }));
    editingPoly = PolyEditor(
      addClosePathMarker: true,
      points: polyEditorLines.expand((l) => l.points).toList(),
      pointIcon: Icon(Icons.crop_square, size: 23),
      intermediateIcon: Icon(Icons.lens, size: 15, color: Colors.grey),
      callbackRefresh: () {
        print('callback refresh');
        //setState(() {});
      },
    ).obs;

    proj4.Projection.add(
      'EPSG:2056', // CH
      '+proj=somerc +lat_0=46.95240555555556 +lon_0=7.439583333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +towgs84=674.374,15.056,405.346,0,0,0,0 +units=m +no_defs',
    );
    proj4.Projection.add(
      'EPSG:3034', // EU https://epsg.io/3034
      '+proj=lcc +lat_1=35 +lat_2=65 +lat_0=52 +lon_0=10 +x_0=4000000 +y_0=2800000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
    );
    proj4.Projection.add(
      'EPSG:3035', // EU https://epsg.io/3035
      '+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
    );
    proj4.Projection.add(
      'EPSG:4839', // DE http://epsg.io/4839
      '+proj=lcc +lat_1=48.66666666666666 +lat_2=53.66666666666666 +lat_0=51 +lon_0=10.5 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
    );
    proj4.Projection.add(
      'EPSG:5243', // DE http://epsg.io/5243
      '+proj=lcc +lat_1=48.66666666666666 +lat_2=53.66666666666666 +lat_0=51 +lon_0=10.5 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
    );
    proj4.Projection.add(
      'EPSG:31287', // Austria http://epsg.io/31287
      '+proj=lcc +lat_1=49 +lat_2=46 +lat_0=47.5 +lon_0=13.33333333333333 +x_0=400000 +y_0=400000 +ellps=bessel +towgs84=577.326,90.129,463.919,5.137,1.474,5.297,2.4232 +units=m +no_defs',
    );
  }

  @override
  void dispose() {
    rowGeometryListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapController mapController = widget.mapController;
    proj4.Projection epsg2056 = proj4.Projection.add('EPSG:2056',
        '+proj=somerc +lat_0=46.95240555555556 +lon_0=7.439583333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +towgs84=674.374,15.056,405.346,0,0,0,0 +units=m +no_defs');
    final resolutions = <double>[
      32768,
      16384,
      8192,
      4096,
      2048,
      1024,
      512,
      256,
      128,
    ];
    final epsg2056Bounds = Bounds<double>(
      CustomPoint<double>(5.96, 45.82),
      CustomPoint<double>(10.49, 47.81),
    );
    double maxZoom = (resolutions.length - 1).toDouble();
    Proj4Crs epsg2056CRS = Proj4Crs.fromFactory(
      code: 'EPSG:2056',
      proj4Projection: epsg2056,
      resolutions: resolutions,
      bounds: epsg2056Bounds,
      origins: [CustomPoint(0, 0)],
      scales: null,
      transformation: null,
    );

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
          geomCollection.geometries.removeWhere(
            (g) =>
                g.type == GeoJSONType.point &&
                (g.bbox?.contains(lng) ?? false) &&
                (g.bbox?.contains(lat) ?? false),
          );
          // 2. remove marker
          markers.removeWhere(
            (m) => m.point.latitude == lat && m.point.longitude == lng,
          );
          Crow? row =
              isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
          bool geometryExists = geomCollection.geometries.length > 0;
          if (row != null) {
            // 2. load from row
            row.geometry = geometryExists ? geomCollection.toJSON() : null;
            row.geometryW = geometryExists ? geomCollection.bbox[0] : null;
            row.geometryS = geometryExists ? geomCollection.bbox[1] : null;
            row.geometryE = geometryExists ? geomCollection.bbox[2] : null;
            row.geometryN = geometryExists ? geomCollection.bbox[3] : null;
            row.save();
          }
          break;
        default:
        // Do nothiing
      }
    };

    /// Used to trigger showing/hiding of popups.
    final PopupController _popupLayerController = PopupController();

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
        geometries: geomCollection.geometries,
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
    TappablePolylineLayerOptions tappablePolylineLayerOptions =
        TappablePolylineLayerOptions(
      polylines: polylines.value,
      onTap: (TaggedPolyline polyline) =>
          print('polyline tapped: ${polyline.tag}'),
      onMiss: () => print("No polyline tapped"),
      rebuild: polylines.stream.map((event) => null),
    );
    PolylineLayerOptions polygonLineLayerOptions =
        PolylineLayerOptions(polylines: editingPolygonLines.value);
    PolygonLayerOptions polygonLayerOptions =
        PolygonLayerOptions(polygons: polygons.value);
    List<LayerOptions> layerGroup = [];
    switch (mapGeometryType.value) {
      case 'point':
        layerGroup = [
          polygonLayerOptions,
          polygonMarkerLayerOptions,
          polygonLineLayerOptions,
          polylineMarkerLayerOptions,
          //tappablePolylineLayerOptions,
          markerLayerOptions,
        ];
        break;
      case 'polyline':
        layerGroup = [
          polygonLayerOptions,
          polygonMarkerLayerOptions,
          polygonLineLayerOptions,
          markerLayerOptions,
          //tappablePolylineLayerOptions,
          polylineMarkerLayerOptions,
        ];
        break;
      case 'polygon':
        layerGroup = [
          markerLayerOptions,
          polylineMarkerLayerOptions,
          //tappablePolylineLayerOptions,
          polygonLayerOptions,
          polygonLineLayerOptions,
          polygonMarkerLayerOptions,
        ];
        break;
      default:
        layerGroup = [
          markerLayerOptions,
          polylineMarkerLayerOptions,
          polygonLayerOptions,
          polygonLineLayerOptions,
          polygonMarkerLayerOptions,
          //tappablePolylineLayerOptions,
        ];
    }
    // use bbox to zoom
    if (geomCollection.geometries.length > 0) {
      bounds.value = LatLngBounds.fromPoints([
        LatLng(
          geomCollection.bbox[1] + 0.008,
          geomCollection.bbox[0] - 0.008,
        ),
        LatLng(
          geomCollection.bbox[3] - 0.008,
          geomCollection.bbox[2] + 0.008,
        )
      ]);
    }

    List<TileLayerWidget> layerWidgets = [];
    List<ProjectTileLayer> allLayers = isar.projectTileLayers
        .where()
        .deletedEqualTo(false)
        .sortByOrd()
        .findAllSync();
    List<ProjectTileLayer> activeLayersForWidget =
        allLayers.where((e) => activeLayers.contains(e.id)).toList();
    activeLayersForWidget.forEach((e) {
      if (e.wmsBaseUrl != null) {
        layerWidgets.add(
          TileLayerWidget(
            options: TileLayerOptions(
              opacity: e.opacity ?? 1,
              minZoom: e.minZoom ?? 0,
              maxZoom: e.maxZoom ?? 25,
              backgroundColor: Color(0x00000000),
              wmsOptions: WMSTileLayerOptions(
                //crs: epsg2056CRS,
                baseUrl: e.wmsBaseUrl ?? '',
                layers: e.wmsLayers ?? [],
                format: e.wmsFormat ?? 'image/png',
                version: e.wmsVersion ?? '1.3.0',
                transparent: e.wmsTransparent ?? true,
              ),
            ),
          ),
        );
      } else {
        layerWidgets.add(
          TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate: e.urlTemplate ??
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: e.subdomains ?? ['a', 'b', 'c'],
            ),
          ),
        );
      }
    });

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        //crs: epsg2056CRS,
        bounds: bounds.value,
        //center: LatLng(47.3782, 8.5367),
        //zoom: 3,
        //maxZoom: maxZoom,
        //controller: mapController,
        plugins: [
          ZoomButtonsPlugin(),
          ScaleLayerPlugin(),
          TappablePolylineMapPlugin(),
          DragMarkerPlugin(),
        ],
        // DANGER: this callback needs to be async because flutter calls it
        // before the widget is finished building
        // see: https://stackoverflow.com/a/51273797/712005
        // and https://github.com/fleaflet/flutter_map/issues/374#issuecomment-854527680
        onPositionChanged: (MapPosition position, bool hasGesture) async {
          double? newLat = position.center?.latitude;
          double? newLng = position.center?.longitude;
          if (newLat != null && newLng != null) {
            lat.value = newLat;
            lng.value = newLng;
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
            editingPoly: editingPoly,
            polyEditorPoints: polyEditorPoints,
          );
        },
      ),
      children: <Widget>[
        ...layerWidgets,
        LocationMarkerLayerWidget(),
        // GroupLayerWidget(
        //   options: GroupLayerOptions(
        //     key: Key('grouplayer'),
        //     group: layerGroup,
        //     rebuild: StreamGroup.merge([
        //       markers.stream,
        //       polylineMarkers.stream,
        //       editingPolylinePoints.stream,
        //       //polylines.stream,
        //       polygonMarkers.stream,
        //       editingPolygonPoints.stream,
        //       editingPolygonLines.stream,
        //       polygons.stream,
        //     ]).map((event) => null),
        //   ),
        // ),
        // PolylineLayerWidget(options: tappablePolylineLayerOptions),
        Obx(
          () => PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
                markers: markers.value,
                popupSnap: PopupSnap.markerTop,
                popupController: _popupLayerController,
                // TODO:
                // from markers lat/lng fetch row
                // and present data plus options to edit data or geometry?
                popupBuilder: (BuildContext context, Marker marker) =>
                    PopupWidget(marker),
                markerRotate: true,
                markerRotateAlignment:
                    PopupMarkerLayerOptions.rotationAlignmentFor(
                  AnchorAlign.center,
                ),
                popupAnimation:
                    PopupAnimation.fade(duration: Duration(milliseconds: 700)),
                rebuild: markers.stream.map((event) => null)),
          ),
        ),
      ],
      layers: [
        //PolylineLayerOptions(polylines: polyEditorLines),
        //DragMarkerPluginOptions(markers: editingPoly.value.edit()),
        //   DragMarkerPluginOptions(
        //     markers: [
        //       DragMarker(
        //         point: markers.value[0].point,
        //         width: 80.0,
        //         height: 80.0,
        //         offset: Offset(0.0, -8.0),
        //         builder: (ctx) => Container(
        //             child: Icon(
        //           Icons.center_focus_weak_outlined,
        //           color: Theme.of(context).primaryColor,
        //         )),
        //         onDragStart: (details, point) => print("Start point $point"),
        //         onDragEnd: (details, point) => print("End point $point"),
        //         onDragUpdate: (details, point) {},
        //         onTap: (point) {
        //           print("on tap");
        //         },
        //         onLongPress: (point) {
        //           print("on long press");
        //         },
        //         feedbackBuilder: (ctx) => Container(
        //             child: Icon(
        //           Icons.center_focus_weak_outlined,
        //           color: Colors.red,
        //         )),
        //         feedbackOffset: Offset(0.0, -18.0),
        //         updateMapNearEdge:
        //             true, // Experimental, move the map when marker close to edge
        //         nearEdgeRatio: 2.0, // Experimental
        //         nearEdgeSpeed: 1.0, // Experimental
        //       ),
        //       DragMarker(
        //         point: markers.value[1].point,
        //         width: 80.0,
        //         height: 80.0,
        //         builder: (ctx) => Container(
        //             child: Icon(
        //           Icons.center_focus_weak_outlined,
        //           color: Theme.of(context).primaryColor,
        //         )),
        //         onDragEnd: (details, point) {
        //           print('Finished Drag $details $point');
        //         },
        //         updateMapNearEdge: false,
        //       )
        //     ],
        //   ),
      ],
      nonRotatedLayers: [
        ZoomButtonsPluginOption(
          minZoom: 0,
          maxZoom: 25,
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
            child: Obx(() {
              return Text(
                locationByCrs(
                  lat: lat.value,
                  lng: lng.value,
                  crs: activeProject?.crs?.toString() ?? '4326',
                ),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              );
            }),
            alignment: Alignment.topLeft,
          ),
        ),
        mapEditing.value == true
            ? MapMenu(
                mapEditingMode: mapEditingMode,
                setMapEditingMode: setMapEditingMode,
                mapGeometryType: mapGeometryType,
                setMapGeometryType: setMapGeometryType,
                mapSelectionMode: mapSelectionMode,
                setMapSelectionMode: setMapSelectionMode,
                editingPolylinePoints: editingPolylinePoints,
                resetEditingPolylinePoints: resetEditingPolylinePoints,
                resetEditingPolygon: resetEditingPolygon,
                editingPolygonPoints: editingPolygonPoints,
                editingPolygonLines: editingPolygonLines,
              )
            : Container(),
      ],
    );
  }
}
