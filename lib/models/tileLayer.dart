import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/utils/toPgArray.dart';
import 'package:capturing/utils/pgArrayToListOfStrings.dart';

part 'tileLayer.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

// the name "Table" is used by a flutter widget which is bad when isar.g.dart is built!!
@Collection()
class CtileLayer {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? label;

  @Index()
  String? projectId;

  String? urlTemplate;

  List<String>? subdomains;

  double? maxZoom;

  double? minZoom;

  double? opacity;

  String? wmsBaseUrl;

  String? wmsFormat;

  List<String>? wmsLayers;

  String? wmsParameters;

  String? wmsRequest;

  String? wmsService;

  List<String>? wmsStyles;

  bool? wmsTransparent;

  String? wmsVersion;

  DateTime? clientRevAt;
  String? clientRevBy;

  @Index()
  DateTime? serverRevAt;

  @Index()
  late bool deleted;

  CtileLayer({
    this.label,
    this.projectId,
    this.urlTemplate,
    this.subdomains,
    this.maxZoom,
    this.minZoom,
    this.opacity,
    this.wmsBaseUrl,
    this.wmsFormat,
    this.wmsLayers,
    this.wmsParameters,
    this.wmsRequest,
    this.wmsService,
    this.wmsStyles,
    this.wmsTransparent,
    this.wmsVersion,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    maxZoom = maxZoom ?? 19;
    minZoom = minZoom ?? 0;
    opacity = opacity ?? 1;
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now();
    clientRevBy = clientRevBy ?? _authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'label': this.label,
        'project_id': this.projectId,
        'url_template': this.urlTemplate,
        'subdomains': toPgArray(this.subdomains),
        'max_zoom': this.maxZoom,
        'min_zoom': this.minZoom,
        'opacity': this.opacity,
        'wms_base_url': this.wmsBaseUrl,
        'wms_format': this.wmsFormat,
        'wms_layers': toPgArray(this.wmsLayers),
        'wms_parameters': this.wmsParameters,
        'wms_request': this.wmsRequest,
        'wms_service': this.wmsService,
        'wms_styles': toPgArray(this.wmsStyles),
        'wms_transparent': this.wmsTransparent,
        'wms_version': this.wmsVersion,
        'client_rev_at': this.clientRevAt?.toIso8601String(),
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt?.toIso8601String(),
        'deleted': this.deleted,
      };

  CtileLayer.fromJson(Map p)
      : id = p['id'],
        label = p['label'],
        projectId = p['project_id'],
        urlTemplate = p['url_template'],
        subdomains = pgArrayToListOfStrings(p['subdomains']),
        maxZoom = p['max_zoom']?.toDouble(),
        minZoom = p['min_zoom']?.toDouble(),
        opacity = p['opacity']?.toDouble(),
        wmsBaseUrl = p['wms_base_url'],
        wmsFormat = p['wms_format'],
        wmsLayers = pgArrayToListOfStrings(p['wms_layers']),
        wmsParameters = p['wms_parameters'],
        wmsRequest = p['wms_request'],
        wmsService = p['wms_service'],
        wmsStyles = pgArrayToListOfStrings(p['wms_styles']),
        wmsTransparent = p['wms_transparent'],
        wmsVersion = p['wms_version'],
        clientRevAt = DateTime.tryParse(p['client_rev_at']),
        clientRevBy = p['client_rev_by'],
        serverRevAt = DateTime.tryParse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'tileLayers').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.ctileLayers.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    DbOperation operation =
        DbOperation(table: 'tileLayers').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.ctileLayers.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    // 1. update other fields
    this.clientRevAt = DateTime.now();
    this.clientRevBy = _authController.userEmail ?? '';
    Map operationData = this.toMap();
    DbOperation dbOperation =
        DbOperation(table: 'tileLayers').setData(operationData);
    // 2. update isar and server
    await isar.writeTxn((isar) async {
      await isar.ctileLayers.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  String getLabel() {
    return this.label ?? '(no name)'.tr;
  }
}
