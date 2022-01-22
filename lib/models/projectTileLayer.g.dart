// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectTileLayer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetProjectTileLayerCollection on Isar {
  IsarCollection<ProjectTileLayer> get projectTileLayers {
    return getCollection('ProjectTileLayer');
  }
}

final ProjectTileLayerSchema = CollectionSchema(
  name: 'ProjectTileLayer',
  schema:
      '{"name":"ProjectTileLayer","properties":[{"name":"active","type":"Byte"},{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Byte"},{"name":"id","type":"String"},{"name":"label","type":"String"},{"name":"maxZoom","type":"Double"},{"name":"minZoom","type":"Double"},{"name":"opacity","type":"Double"},{"name":"ord","type":"Long"},{"name":"projectId","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"subdomains","type":"StringList"},{"name":"urlTemplate","type":"String"},{"name":"wmsBaseUrl","type":"String"},{"name":"wmsFormat","type":"String"},{"name":"wmsLayers","type":"StringList"},{"name":"wmsParameters","type":"String"},{"name":"wmsRequest","type":"String"},{"name":"wmsService","type":"String"},{"name":"wmsStyles","type":"StringList"},{"name":"wmsTransparent","type":"Byte"},{"name":"wmsVersion","type":"String"}],"indexes":[{"name":"active","unique":false,"properties":[{"name":"active","type":"Value","caseSensitive":false}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"label","unique":false,"properties":[{"name":"label","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _ProjectTileLayerAdapter(),
  idName: 'isarId',
  propertyIds: {
    'active': 0,
    'clientRevAt': 1,
    'clientRevBy': 2,
    'deleted': 3,
    'id': 4,
    'label': 5,
    'maxZoom': 6,
    'minZoom': 7,
    'opacity': 8,
    'ord': 9,
    'projectId': 10,
    'serverRevAt': 11,
    'subdomains': 12,
    'urlTemplate': 13,
    'wmsBaseUrl': 14,
    'wmsFormat': 15,
    'wmsLayers': 16,
    'wmsParameters': 17,
    'wmsRequest': 18,
    'wmsService': 19,
    'wmsStyles': 20,
    'wmsTransparent': 21,
    'wmsVersion': 22
  },
  indexIds: {
    'active': 0,
    'deleted': 1,
    'id': 2,
    'label': 3,
    'ord': 4,
    'projectId': 5,
    'serverRevAt': 6
  },
  indexTypes: {
    'active': [
      NativeIndexType.bool,
    ],
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'label': [
      NativeIndexType.stringHash,
    ],
    'ord': [
      NativeIndexType.long,
    ],
    'projectId': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) => obj.isarId,
  setId: (obj, id) => obj.isarId = id,
  getLinks: (obj) => [],
  version: 0,
);

class _ProjectTileLayerAdapter extends IsarTypeAdapter<ProjectTileLayer> {
  const _ProjectTileLayerAdapter();

  @override
  int serialize(IsarCollection<ProjectTileLayer> collection,
      IsarRawObject rawObj, ProjectTileLayer object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.autoIncrement;
    var dynamicSize = 0;
    final value0 = object.active;
    final _active = value0;
    final value1 = object.clientRevAt;
    final _clientRevAt = value1;
    final value2 = object.clientRevBy;
    IsarUint8List? _clientRevBy;
    if (value2 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value3 = object.deleted;
    final _deleted = value3;
    final value4 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += _id.length;
    final value5 = object.label;
    IsarUint8List? _label;
    if (value5 != null) {
      _label = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _label?.length ?? 0;
    final value6 = object.maxZoom;
    final _maxZoom = value6;
    final value7 = object.minZoom;
    final _minZoom = value7;
    final value8 = object.opacity;
    final _opacity = value8;
    final value9 = object.ord;
    final _ord = value9;
    final value10 = object.projectId;
    IsarUint8List? _projectId;
    if (value10 != null) {
      _projectId = BinaryWriter.utf8Encoder.convert(value10);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value11 = object.serverRevAt;
    final _serverRevAt = value11;
    final value12 = object.subdomains;
    dynamicSize += (value12?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList12;
    if (value12 != null) {
      bytesList12 = [];
      for (var str in value12) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList12.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _subdomains = bytesList12;
    final value13 = object.urlTemplate;
    IsarUint8List? _urlTemplate;
    if (value13 != null) {
      _urlTemplate = BinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += _urlTemplate?.length ?? 0;
    final value14 = object.wmsBaseUrl;
    IsarUint8List? _wmsBaseUrl;
    if (value14 != null) {
      _wmsBaseUrl = BinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += _wmsBaseUrl?.length ?? 0;
    final value15 = object.wmsFormat;
    IsarUint8List? _wmsFormat;
    if (value15 != null) {
      _wmsFormat = BinaryWriter.utf8Encoder.convert(value15);
    }
    dynamicSize += _wmsFormat?.length ?? 0;
    final value16 = object.wmsLayers;
    dynamicSize += (value16?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList16;
    if (value16 != null) {
      bytesList16 = [];
      for (var str in value16) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList16.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsLayers = bytesList16;
    final value17 = object.wmsParameters;
    IsarUint8List? _wmsParameters;
    if (value17 != null) {
      _wmsParameters = BinaryWriter.utf8Encoder.convert(value17);
    }
    dynamicSize += _wmsParameters?.length ?? 0;
    final value18 = object.wmsRequest;
    IsarUint8List? _wmsRequest;
    if (value18 != null) {
      _wmsRequest = BinaryWriter.utf8Encoder.convert(value18);
    }
    dynamicSize += _wmsRequest?.length ?? 0;
    final value19 = object.wmsService;
    IsarUint8List? _wmsService;
    if (value19 != null) {
      _wmsService = BinaryWriter.utf8Encoder.convert(value19);
    }
    dynamicSize += _wmsService?.length ?? 0;
    final value20 = object.wmsStyles;
    dynamicSize += (value20?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList20;
    if (value20 != null) {
      bytesList20 = [];
      for (var str in value20) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList20.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsStyles = bytesList20;
    final value21 = object.wmsTransparent;
    final _wmsTransparent = value21;
    final value22 = object.wmsVersion;
    IsarUint8List? _wmsVersion;
    if (value22 != null) {
      _wmsVersion = BinaryWriter.utf8Encoder.convert(value22);
    }
    dynamicSize += _wmsVersion?.length ?? 0;
    final size = dynamicSize + 165;

    late int bufferSize;
    if (existingBufferSize != null) {
      if (existingBufferSize < size) {
        isarFree(rawObj.buffer);
        rawObj.buffer = isarMalloc(size);
        bufferSize = size;
      } else {
        bufferSize = existingBufferSize;
      }
    } else {
      rawObj.buffer = isarMalloc(size);
      bufferSize = size;
    }
    rawObj.buffer_length = size;
    final buffer = bufAsBytes(rawObj.buffer, size);
    final writer = BinaryWriter(buffer, 165);
    writer.writeBool(offsets[0], _active);
    writer.writeDateTime(offsets[1], _clientRevAt);
    writer.writeBytes(offsets[2], _clientRevBy);
    writer.writeBool(offsets[3], _deleted);
    writer.writeBytes(offsets[4], _id);
    writer.writeBytes(offsets[5], _label);
    writer.writeDouble(offsets[6], _maxZoom);
    writer.writeDouble(offsets[7], _minZoom);
    writer.writeDouble(offsets[8], _opacity);
    writer.writeLong(offsets[9], _ord);
    writer.writeBytes(offsets[10], _projectId);
    writer.writeDateTime(offsets[11], _serverRevAt);
    writer.writeStringList(offsets[12], _subdomains);
    writer.writeBytes(offsets[13], _urlTemplate);
    writer.writeBytes(offsets[14], _wmsBaseUrl);
    writer.writeBytes(offsets[15], _wmsFormat);
    writer.writeStringList(offsets[16], _wmsLayers);
    writer.writeBytes(offsets[17], _wmsParameters);
    writer.writeBytes(offsets[18], _wmsRequest);
    writer.writeBytes(offsets[19], _wmsService);
    writer.writeStringList(offsets[20], _wmsStyles);
    writer.writeBool(offsets[21], _wmsTransparent);
    writer.writeBytes(offsets[22], _wmsVersion);
    return bufferSize;
  }

  @override
  ProjectTileLayer deserialize(IsarCollection<ProjectTileLayer> collection,
      int id, BinaryReader reader, List<int> offsets) {
    final object = ProjectTileLayer(
      active: reader.readBoolOrNull(offsets[0]),
      clientRevAt: reader.readDateTimeOrNull(offsets[1]),
      clientRevBy: reader.readStringOrNull(offsets[2]),
      label: reader.readStringOrNull(offsets[5]),
      maxZoom: reader.readDoubleOrNull(offsets[6]),
      minZoom: reader.readDoubleOrNull(offsets[7]),
      opacity: reader.readDoubleOrNull(offsets[8]),
      ord: reader.readLongOrNull(offsets[9]),
      projectId: reader.readStringOrNull(offsets[10]),
      subdomains: reader.readStringList(offsets[12]),
      urlTemplate: reader.readStringOrNull(offsets[13]),
      wmsBaseUrl: reader.readStringOrNull(offsets[14]),
      wmsFormat: reader.readStringOrNull(offsets[15]),
      wmsLayers: reader.readStringList(offsets[16]),
      wmsParameters: reader.readStringOrNull(offsets[17]),
      wmsRequest: reader.readStringOrNull(offsets[18]),
      wmsService: reader.readStringOrNull(offsets[19]),
      wmsStyles: reader.readStringList(offsets[20]),
      wmsTransparent: reader.readBoolOrNull(offsets[21]),
      wmsVersion: reader.readStringOrNull(offsets[22]),
    );
    object.deleted = reader.readBool(offsets[3]);
    object.id = reader.readString(offsets[4]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[11]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readBoolOrNull(offset)) as P;
      case 1:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readBool(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readDoubleOrNull(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readDoubleOrNull(offset)) as P;
      case 9:
        return (reader.readLongOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readDateTime(offset)) as P;
      case 12:
        return (reader.readStringList(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readStringOrNull(offset)) as P;
      case 16:
        return (reader.readStringList(offset)) as P;
      case 17:
        return (reader.readStringOrNull(offset)) as P;
      case 18:
        return (reader.readStringOrNull(offset)) as P;
      case 19:
        return (reader.readStringOrNull(offset)) as P;
      case 20:
        return (reader.readStringList(offset)) as P;
      case 21:
        return (reader.readBoolOrNull(offset)) as P;
      case 22:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension ProjectTileLayerQueryWhereSort
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QWhere> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyActive() {
    return addWhereClause(const WhereClause(indexName: 'active'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyLabel() {
    return addWhereClause(const WhereClause(indexName: 'label'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyOrd() {
    return addWhereClause(const WhereClause(indexName: 'ord'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyProjectId() {
    return addWhereClause(const WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere>
      anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }
}

extension ProjectTileLayerQueryWhere
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QWhereClause> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdNotEqualTo(int? isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdBetween(
    int? lowerIsarId,
    int? upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [lowerIsarId],
      includeLower: includeLower,
      upper: [upperIsarId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      activeEqualTo(bool? active) {
    return addWhereClause(WhereClause(
      indexName: 'active',
      lower: [active],
      includeLower: true,
      upper: [active],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      activeNotEqualTo(bool? active) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'active',
        upper: [active],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'active',
        lower: [active],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'active',
        lower: [active],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'active',
        upper: [active],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      activeIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'active',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      activeIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'active',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      deletedNotEqualTo(bool deleted) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause> idEqualTo(
      String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      idNotEqualTo(String id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      labelEqualTo(String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [label],
      includeLower: true,
      upper: [label],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      labelNotEqualTo(String? label) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'label',
        upper: [label],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'label',
        lower: [label],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'label',
        lower: [label],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'label',
        upper: [label],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      labelIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      labelIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'label',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: true,
      upper: [ord],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordNotEqualTo(int? ord) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordGreaterThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordLessThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordBetween(
    int? lowerOrd,
    int? upperOrd, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [lowerOrd],
      includeLower: includeLower,
      upper: [upperOrd],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      projectIdEqualTo(String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [projectId],
      includeLower: true,
      upper: [projectId],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      projectIdNotEqualTo(String? projectId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      projectIdIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      projectIdIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtEqualTo(DateTime serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtNotEqualTo(DateTime serverRevAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtGreaterThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtBetween(
    DateTime lowerServerRevAt,
    DateTime upperServerRevAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [lowerServerRevAt],
      includeLower: includeLower,
      upper: [upperServerRevAt],
      includeUpper: includeUpper,
    ));
  }
}

extension ProjectTileLayerQueryFilter
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QFilterCondition> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      activeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'active',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      activeEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'active',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtEqualTo(DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevBy',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'label',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'maxZoom',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomGreaterThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomLessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomBetween(double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'maxZoom',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      minZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'minZoom',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      minZoomGreaterThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      minZoomLessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      minZoomBetween(double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'minZoom',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      opacityIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'opacity',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      opacityGreaterThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      opacityLessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      opacityBetween(double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'opacity',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'projectId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtEqualTo(DateTime value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'subdomains',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'subdomains',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'urlTemplate',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'urlTemplate',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'urlTemplate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsBaseUrl',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsBaseUrl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsBaseUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsFormat',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsFormat',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsFormat',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsLayers',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsLayers',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsParameters',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsParameters',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsParameters',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsRequest',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsRequest',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsRequest',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsService',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsService',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsService',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsStyles',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsStyles',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsTransparentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsTransparent',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsTransparentEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsTransparent',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsVersion',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsVersion',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsVersion',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ProjectTileLayerQueryWhereSortBy
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QSortBy> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByActive() {
    return addSortByInternal('active', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByActiveDesc() {
    return addSortByInternal('active', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByMinZoom() {
    return addSortByInternal('minZoom', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByOpacity() {
    return addSortByInternal('opacity', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByOpacityDesc() {
    return addSortByInternal('opacity', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsService() {
    return addSortByInternal('wmsService', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.desc);
  }
}

extension ProjectTileLayerQueryWhereSortThenBy
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QSortThenBy> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByActive() {
    return addSortByInternal('active', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByActiveDesc() {
    return addSortByInternal('active', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByMinZoom() {
    return addSortByInternal('minZoom', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByOpacity() {
    return addSortByInternal('opacity', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByOpacityDesc() {
    return addSortByInternal('opacity', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsService() {
    return addSortByInternal('wmsService', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.desc);
  }
}

extension ProjectTileLayerQueryWhereDistinct
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByActive() {
    return addDistinctByInternal('active');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByClientRevBy({bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByMaxZoom() {
    return addDistinctByInternal('maxZoom');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByMinZoom() {
    return addDistinctByInternal('minZoom');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByOpacity() {
    return addDistinctByInternal('opacity');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByProjectId({bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByUrlTemplate({bool caseSensitive = true}) {
    return addDistinctByInternal('urlTemplate', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsBaseUrl({bool caseSensitive = true}) {
    return addDistinctByInternal('wmsBaseUrl', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsFormat({bool caseSensitive = true}) {
    return addDistinctByInternal('wmsFormat', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsParameters({bool caseSensitive = true}) {
    return addDistinctByInternal('wmsParameters', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsRequest({bool caseSensitive = true}) {
    return addDistinctByInternal('wmsRequest', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsService({bool caseSensitive = true}) {
    return addDistinctByInternal('wmsService', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsTransparent() {
    return addDistinctByInternal('wmsTransparent');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByWmsVersion({bool caseSensitive = true}) {
    return addDistinctByInternal('wmsVersion', caseSensitive: caseSensitive);
  }
}

extension ProjectTileLayerQueryProperty
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QQueryProperty> {
  QueryBuilder<ProjectTileLayer, bool?, QQueryOperations> activeProperty() {
    return addPropertyName('active');
  }

  QueryBuilder<ProjectTileLayer, DateTime?, QQueryOperations>
      clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<ProjectTileLayer, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<ProjectTileLayer, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<ProjectTileLayer, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<ProjectTileLayer, double?, QQueryOperations> maxZoomProperty() {
    return addPropertyName('maxZoom');
  }

  QueryBuilder<ProjectTileLayer, double?, QQueryOperations> minZoomProperty() {
    return addPropertyName('minZoom');
  }

  QueryBuilder<ProjectTileLayer, double?, QQueryOperations> opacityProperty() {
    return addPropertyName('opacity');
  }

  QueryBuilder<ProjectTileLayer, int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<ProjectTileLayer, DateTime, QQueryOperations>
      serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<ProjectTileLayer, List<String>?, QQueryOperations>
      subdomainsProperty() {
    return addPropertyName('subdomains');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      urlTemplateProperty() {
    return addPropertyName('urlTemplate');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      wmsBaseUrlProperty() {
    return addPropertyName('wmsBaseUrl');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      wmsFormatProperty() {
    return addPropertyName('wmsFormat');
  }

  QueryBuilder<ProjectTileLayer, List<String>?, QQueryOperations>
      wmsLayersProperty() {
    return addPropertyName('wmsLayers');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      wmsParametersProperty() {
    return addPropertyName('wmsParameters');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      wmsRequestProperty() {
    return addPropertyName('wmsRequest');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      wmsServiceProperty() {
    return addPropertyName('wmsService');
  }

  QueryBuilder<ProjectTileLayer, List<String>?, QQueryOperations>
      wmsStylesProperty() {
    return addPropertyName('wmsStyles');
  }

  QueryBuilder<ProjectTileLayer, bool?, QQueryOperations>
      wmsTransparentProperty() {
    return addPropertyName('wmsTransparent');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      wmsVersionProperty() {
    return addPropertyName('wmsVersion');
  }
}
