// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectTileLayer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetProjectTileLayerCollection on Isar {
  IsarCollection<ProjectTileLayer> get projectTileLayers {
    return getCollection('ProjectTileLayer');
  }
}

final ProjectTileLayerSchema = CollectionSchema(
  name: 'ProjectTileLayer',
  schema:
      '{"name":"ProjectTileLayer","properties":[{"name":"id","type":"String"},{"name":"label","type":"String"},{"name":"ord","type":"Long"},{"name":"active","type":"Byte"},{"name":"projectId","type":"String"},{"name":"urlTemplate","type":"String"},{"name":"subdomains","type":"StringList"},{"name":"maxZoom","type":"Double"},{"name":"minZoom","type":"Double"},{"name":"opacity","type":"Double"},{"name":"wmsBaseUrl","type":"String"},{"name":"wmsFormat","type":"String"},{"name":"wmsLayers","type":"StringList"},{"name":"wmsParameters","type":"String"},{"name":"wmsRequest","type":"String"},{"name":"wmsService","type":"String"},{"name":"wmsStyles","type":"StringList"},{"name":"wmsTransparent","type":"Byte"},{"name":"wmsVersion","type":"String"},{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"label","unique":false,"properties":[{"name":"label","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"active","unique":false,"properties":[{"name":"active","type":"Value","caseSensitive":false}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _ProjectTileLayerAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'label': 1,
    'ord': 2,
    'active': 3,
    'projectId': 4,
    'urlTemplate': 5,
    'subdomains': 6,
    'maxZoom': 7,
    'minZoom': 8,
    'opacity': 9,
    'wmsBaseUrl': 10,
    'wmsFormat': 11,
    'wmsLayers': 12,
    'wmsParameters': 13,
    'wmsRequest': 14,
    'wmsService': 15,
    'wmsStyles': 16,
    'wmsTransparent': 17,
    'wmsVersion': 18,
    'clientRevAt': 19,
    'clientRevBy': 20,
    'serverRevAt': 21,
    'deleted': 22
  },
  indexIds: {
    'id': 0,
    'label': 1,
    'ord': 2,
    'active': 3,
    'projectId': 4,
    'serverRevAt': 5,
    'deleted': 6
  },
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
    'label': [
      NativeIndexType.stringHash,
    ],
    'ord': [
      NativeIndexType.long,
    ],
    'active': [
      NativeIndexType.bool,
    ],
    'projectId': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ],
    'deleted': [
      NativeIndexType.bool,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) => obj.isarId,
  version: 0,
);

class _ProjectTileLayerAdapter extends IsarTypeAdapter<ProjectTileLayer> {
  const _ProjectTileLayerAdapter();

  @override
  int serialize(IsarCollection<ProjectTileLayer> collection, RawObject rawObj,
      ProjectTileLayer object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += _id.length;
    final value1 = object.label;
    Uint8List? _label;
    if (value1 != null) {
      _label = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _label?.length ?? 0;
    final value2 = object.ord;
    final _ord = value2;
    final value3 = object.active;
    final _active = value3;
    final value4 = object.projectId;
    Uint8List? _projectId;
    if (value4 != null) {
      _projectId = BinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value5 = object.urlTemplate;
    Uint8List? _urlTemplate;
    if (value5 != null) {
      _urlTemplate = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _urlTemplate?.length ?? 0;
    final value6 = object.subdomains;
    dynamicSize += (value6?.length ?? 0) * 8;
    List<Uint8List?>? bytesList6;
    if (value6 != null) {
      bytesList6 = [];
      for (var str in value6) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList6.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _subdomains = bytesList6;
    final value7 = object.maxZoom;
    final _maxZoom = value7;
    final value8 = object.minZoom;
    final _minZoom = value8;
    final value9 = object.opacity;
    final _opacity = value9;
    final value10 = object.wmsBaseUrl;
    Uint8List? _wmsBaseUrl;
    if (value10 != null) {
      _wmsBaseUrl = BinaryWriter.utf8Encoder.convert(value10);
    }
    dynamicSize += _wmsBaseUrl?.length ?? 0;
    final value11 = object.wmsFormat;
    Uint8List? _wmsFormat;
    if (value11 != null) {
      _wmsFormat = BinaryWriter.utf8Encoder.convert(value11);
    }
    dynamicSize += _wmsFormat?.length ?? 0;
    final value12 = object.wmsLayers;
    dynamicSize += (value12?.length ?? 0) * 8;
    List<Uint8List?>? bytesList12;
    if (value12 != null) {
      bytesList12 = [];
      for (var str in value12) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList12.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsLayers = bytesList12;
    final value13 = object.wmsParameters;
    Uint8List? _wmsParameters;
    if (value13 != null) {
      _wmsParameters = BinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += _wmsParameters?.length ?? 0;
    final value14 = object.wmsRequest;
    Uint8List? _wmsRequest;
    if (value14 != null) {
      _wmsRequest = BinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += _wmsRequest?.length ?? 0;
    final value15 = object.wmsService;
    Uint8List? _wmsService;
    if (value15 != null) {
      _wmsService = BinaryWriter.utf8Encoder.convert(value15);
    }
    dynamicSize += _wmsService?.length ?? 0;
    final value16 = object.wmsStyles;
    dynamicSize += (value16?.length ?? 0) * 8;
    List<Uint8List?>? bytesList16;
    if (value16 != null) {
      bytesList16 = [];
      for (var str in value16) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList16.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsStyles = bytesList16;
    final value17 = object.wmsTransparent;
    final _wmsTransparent = value17;
    final value18 = object.wmsVersion;
    Uint8List? _wmsVersion;
    if (value18 != null) {
      _wmsVersion = BinaryWriter.utf8Encoder.convert(value18);
    }
    dynamicSize += _wmsVersion?.length ?? 0;
    final value19 = object.clientRevAt;
    final _clientRevAt = value19;
    final value20 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value20 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value20);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value21 = object.serverRevAt;
    final _serverRevAt = value21;
    final value22 = object.deleted;
    final _deleted = value22;
    final size = dynamicSize + 173;

    late int bufferSize;
    if (existingBufferSize != null) {
      if (existingBufferSize < size) {
        malloc.free(rawObj.buffer);
        rawObj.buffer = malloc(size);
        bufferSize = size;
      } else {
        bufferSize = existingBufferSize;
      }
    } else {
      rawObj.buffer = malloc(size);
      bufferSize = size;
    }
    rawObj.buffer_length = size;
    final buffer = rawObj.buffer.asTypedList(size);
    final writer = BinaryWriter(buffer, 173);
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _label);
    writer.writeLong(offsets[2], _ord);
    writer.writeBool(offsets[3], _active);
    writer.writeBytes(offsets[4], _projectId);
    writer.writeBytes(offsets[5], _urlTemplate);
    writer.writeStringList(offsets[6], _subdomains);
    writer.writeDouble(offsets[7], _maxZoom);
    writer.writeDouble(offsets[8], _minZoom);
    writer.writeDouble(offsets[9], _opacity);
    writer.writeBytes(offsets[10], _wmsBaseUrl);
    writer.writeBytes(offsets[11], _wmsFormat);
    writer.writeStringList(offsets[12], _wmsLayers);
    writer.writeBytes(offsets[13], _wmsParameters);
    writer.writeBytes(offsets[14], _wmsRequest);
    writer.writeBytes(offsets[15], _wmsService);
    writer.writeStringList(offsets[16], _wmsStyles);
    writer.writeBool(offsets[17], _wmsTransparent);
    writer.writeBytes(offsets[18], _wmsVersion);
    writer.writeDateTime(offsets[19], _clientRevAt);
    writer.writeBytes(offsets[20], _clientRevBy);
    writer.writeDateTime(offsets[21], _serverRevAt);
    writer.writeBool(offsets[22], _deleted);
    return bufferSize;
  }

  @override
  ProjectTileLayer deserialize(IsarCollection<ProjectTileLayer> collection,
      int id, BinaryReader reader, List<int> offsets) {
    final object = ProjectTileLayer(
      label: reader.readStringOrNull(offsets[1]),
      ord: reader.readLongOrNull(offsets[2]),
      active: reader.readBoolOrNull(offsets[3]),
      projectId: reader.readStringOrNull(offsets[4]),
      urlTemplate: reader.readStringOrNull(offsets[5]),
      subdomains: reader.readStringList(offsets[6]),
      maxZoom: reader.readDoubleOrNull(offsets[7]),
      minZoom: reader.readDoubleOrNull(offsets[8]),
      opacity: reader.readDoubleOrNull(offsets[9]),
      wmsBaseUrl: reader.readStringOrNull(offsets[10]),
      wmsFormat: reader.readStringOrNull(offsets[11]),
      wmsLayers: reader.readStringList(offsets[12]),
      wmsParameters: reader.readStringOrNull(offsets[13]),
      wmsRequest: reader.readStringOrNull(offsets[14]),
      wmsService: reader.readStringOrNull(offsets[15]),
      wmsStyles: reader.readStringList(offsets[16]),
      wmsTransparent: reader.readBoolOrNull(offsets[17]),
      wmsVersion: reader.readStringOrNull(offsets[18]),
      clientRevAt: reader.readDateTimeOrNull(offsets[19]),
      clientRevBy: reader.readStringOrNull(offsets[20]),
      serverRevAt: reader.readDateTimeOrNull(offsets[21]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[22]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readLongOrNull(offset)) as P;
      case 3:
        return (reader.readBoolOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringList(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readDoubleOrNull(offset)) as P;
      case 9:
        return (reader.readDoubleOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
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
        return (reader.readBoolOrNull(offset)) as P;
      case 18:
        return (reader.readStringOrNull(offset)) as P;
      case 19:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 20:
        return (reader.readStringOrNull(offset)) as P;
      case 21:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 22:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension ProjectTileLayerQueryWhereSort
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QWhere> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyLabel() {
    return addWhereClause(WhereClause(indexName: 'label'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyOrd() {
    return addWhereClause(WhereClause(indexName: 'ord'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyActive() {
    return addWhereClause(WhereClause(indexName: 'active'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyProjectId() {
    return addWhereClause(WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere>
      anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension ProjectTileLayerQueryWhere
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QWhereClause> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
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
        indexName: '_id',
        upper: [isarId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        lower: [isarId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: '_id',
        lower: [isarId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        upper: [isarId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
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
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      labelIsNotNull() {
    return addWhereClause(WhereClause(
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
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordGreaterThan(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordLessThan(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      ordBetween(int? lowerOrd, int? upperOrd) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [lowerOrd],
      includeLower: true,
      upper: [upperOrd],
      includeUpper: true,
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
    return addWhereClause(WhereClause(
      indexName: 'active',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      activeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'active',
      lower: [null],
      includeLower: false,
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
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtEqualTo(DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtNotEqualTo(DateTime? serverRevAt) {
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
      serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtGreaterThan(DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtLessThan(DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterWhereClause>
      serverRevAtBetween(
          DateTime? lowerServerRevAt, DateTime? upperServerRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [lowerServerRevAt],
      includeLower: true,
      upper: [upperServerRevAt],
      includeUpper: true,
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
}

extension ProjectTileLayerQueryFilter
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QFilterCondition> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      idEndsWith(String value, {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'label',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      labelEndsWith(String value, {bool caseSensitive = true}) {
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
      ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      ordBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      activeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'active',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      activeEqualTo(
    bool? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'active',
      value: value,
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'projectId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      projectIdEndsWith(String value, {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'urlTemplate',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      urlTemplateEndsWith(String value, {bool caseSensitive = true}) {
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
      subdomainsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'subdomains',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'subdomains',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'subdomains',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      subdomainsAnyEndsWith(String value, {bool caseSensitive = true}) {
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
      maxZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'maxZoom',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomGreaterThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomLessThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      maxZoomBetween(
    double? lower,
    double? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'maxZoom',
      lower: lower,
      upper: upper,
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
      minZoomGreaterThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      minZoomLessThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      minZoomBetween(
    double? lower,
    double? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'minZoom',
      lower: lower,
      upper: upper,
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
      opacityGreaterThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      opacityLessThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      opacityBetween(
    double? lower,
    double? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'opacity',
      lower: lower,
      upper: upper,
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsBaseUrl',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsBaseUrlEndsWith(String value, {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsFormat',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsFormatEndsWith(String value, {bool caseSensitive = true}) {
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
      wmsLayersAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsLayers',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'wmsLayers',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsLayers',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsLayersAnyEndsWith(String value, {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsParameters',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsParametersEndsWith(String value, {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsRequest',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsRequestEndsWith(String value, {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsService',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsServiceEndsWith(String value, {bool caseSensitive = true}) {
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
      wmsStylesAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsStyles',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'wmsStyles',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsStyles',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsStylesAnyEndsWith(String value, {bool caseSensitive = true}) {
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
      wmsTransparentEqualTo(
    bool? value,
  ) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'wmsVersion',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      wmsVersionEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtEqualTo(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtGreaterThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtLessThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      upper: upper,
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevBy',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      clientRevByEndsWith(String value, {bool caseSensitive = true}) {
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
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtEqualTo(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtGreaterThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtLessThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      serverRevAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterFilterCondition>
      deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension ProjectTileLayerQueryWhereSortBy
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QSortBy> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByActive() {
    return addSortByInternal('active', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByActiveDesc() {
    return addSortByInternal('active', Sort.desc);
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
      sortByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
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
      sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension ProjectTileLayerQueryWhereSortThenBy
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QSortThenBy> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByActive() {
    return addSortByInternal('active', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByActiveDesc() {
    return addSortByInternal('active', Sort.desc);
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
      thenByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
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
      thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QAfterSortBy>
      thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension ProjectTileLayerQueryWhereDistinct
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> {
  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByActive() {
    return addDistinctByInternal('active');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByProjectId({bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByUrlTemplate({bool caseSensitive = true}) {
    return addDistinctByInternal('urlTemplate', caseSensitive: caseSensitive);
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

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByClientRevBy({bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<ProjectTileLayer, ProjectTileLayer, QDistinct>
      distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension ProjectTileLayerQueryProperty
    on QueryBuilder<ProjectTileLayer, ProjectTileLayer, QQueryProperty> {
  QueryBuilder<ProjectTileLayer, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<ProjectTileLayer, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<ProjectTileLayer, int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
  }

  QueryBuilder<ProjectTileLayer, bool?, QQueryOperations> activeProperty() {
    return addPropertyName('active');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      urlTemplateProperty() {
    return addPropertyName('urlTemplate');
  }

  QueryBuilder<ProjectTileLayer, List<String>?, QQueryOperations>
      subdomainsProperty() {
    return addPropertyName('subdomains');
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

  QueryBuilder<ProjectTileLayer, DateTime?, QQueryOperations>
      clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<ProjectTileLayer, String?, QQueryOperations>
      clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<ProjectTileLayer, DateTime?, QQueryOperations>
      serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<ProjectTileLayer, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
