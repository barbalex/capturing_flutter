// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tileLayer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetCtileLayerCollection on Isar {
  IsarCollection<CtileLayer> get ctileLayers {
    return getCollection('CtileLayer');
  }
}

final CtileLayerSchema = CollectionSchema(
  name: 'CtileLayer',
  schema:
      '{"name":"CtileLayer","properties":[{"name":"id","type":"String"},{"name":"label","type":"String"},{"name":"projectId","type":"String"},{"name":"urlTemplate","type":"String"},{"name":"subdomains","type":"StringList"},{"name":"maxZoom","type":"Double"},{"name":"minZoom","type":"Double"},{"name":"opacity","type":"Double"},{"name":"wmsBaseUrl","type":"String"},{"name":"wmsFormat","type":"String"},{"name":"wmsLayers","type":"StringList"},{"name":"wmsParameters","type":"String"},{"name":"wmsRequest","type":"String"},{"name":"wmsService","type":"String"},{"name":"wmsStyles","type":"StringList"},{"name":"wmsTransparent","type":"Byte"},{"name":"wmsVersion","type":"String"},{"name":"clientRevAt","type":"String"},{"name":"clientRevBy","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"label","unique":false,"properties":[{"name":"label","type":"Hash","caseSensitive":true}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _CtileLayerAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'label': 1,
    'projectId': 2,
    'urlTemplate': 3,
    'subdomains': 4,
    'maxZoom': 5,
    'minZoom': 6,
    'opacity': 7,
    'wmsBaseUrl': 8,
    'wmsFormat': 9,
    'wmsLayers': 10,
    'wmsParameters': 11,
    'wmsRequest': 12,
    'wmsService': 13,
    'wmsStyles': 14,
    'wmsTransparent': 15,
    'wmsVersion': 16,
    'clientRevAt': 17,
    'clientRevBy': 18,
    'serverRevAt': 19,
    'deleted': 20
  },
  indexIds: {
    'id': 0,
    'label': 1,
    'projectId': 2,
    'serverRevAt': 3,
    'deleted': 4
  },
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
    'label': [
      NativeIndexType.stringHash,
    ],
    'projectId': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.stringHash,
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

class _CtileLayerAdapter extends IsarTypeAdapter<CtileLayer> {
  const _CtileLayerAdapter();

  @override
  int serialize(IsarCollection<CtileLayer> collection, RawObject rawObj,
      CtileLayer object, List<int> offsets,
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
    final value2 = object.projectId;
    Uint8List? _projectId;
    if (value2 != null) {
      _projectId = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value3 = object.urlTemplate;
    Uint8List? _urlTemplate;
    if (value3 != null) {
      _urlTemplate = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _urlTemplate?.length ?? 0;
    final value4 = object.subdomains;
    dynamicSize += (value4?.length ?? 0) * 8;
    List<Uint8List?>? bytesList4;
    if (value4 != null) {
      bytesList4 = [];
      for (var str in value4) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList4.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _subdomains = bytesList4;
    final value5 = object.maxZoom;
    final _maxZoom = value5;
    final value6 = object.minZoom;
    final _minZoom = value6;
    final value7 = object.opacity;
    final _opacity = value7;
    final value8 = object.wmsBaseUrl;
    Uint8List? _wmsBaseUrl;
    if (value8 != null) {
      _wmsBaseUrl = BinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += _wmsBaseUrl?.length ?? 0;
    final value9 = object.wmsFormat;
    Uint8List? _wmsFormat;
    if (value9 != null) {
      _wmsFormat = BinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += _wmsFormat?.length ?? 0;
    final value10 = object.wmsLayers;
    dynamicSize += (value10?.length ?? 0) * 8;
    List<Uint8List?>? bytesList10;
    if (value10 != null) {
      bytesList10 = [];
      for (var str in value10) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList10.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsLayers = bytesList10;
    final value11 = object.wmsParameters;
    Uint8List? _wmsParameters;
    if (value11 != null) {
      _wmsParameters = BinaryWriter.utf8Encoder.convert(value11);
    }
    dynamicSize += _wmsParameters?.length ?? 0;
    final value12 = object.wmsRequest;
    Uint8List? _wmsRequest;
    if (value12 != null) {
      _wmsRequest = BinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += _wmsRequest?.length ?? 0;
    final value13 = object.wmsService;
    Uint8List? _wmsService;
    if (value13 != null) {
      _wmsService = BinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += _wmsService?.length ?? 0;
    final value14 = object.wmsStyles;
    dynamicSize += (value14?.length ?? 0) * 8;
    List<Uint8List?>? bytesList14;
    if (value14 != null) {
      bytesList14 = [];
      for (var str in value14) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList14.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsStyles = bytesList14;
    final value15 = object.wmsTransparent;
    final _wmsTransparent = value15;
    final value16 = object.wmsVersion;
    Uint8List? _wmsVersion;
    if (value16 != null) {
      _wmsVersion = BinaryWriter.utf8Encoder.convert(value16);
    }
    dynamicSize += _wmsVersion?.length ?? 0;
    final value17 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value17 != null) {
      _clientRevAt = BinaryWriter.utf8Encoder.convert(value17);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value18 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value18 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value18);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value19 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value19 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value19);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value20 = object.deleted;
    final _deleted = value20;
    final size = dynamicSize + 164;

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
    final writer = BinaryWriter(buffer, 164);
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _label);
    writer.writeBytes(offsets[2], _projectId);
    writer.writeBytes(offsets[3], _urlTemplate);
    writer.writeStringList(offsets[4], _subdomains);
    writer.writeDouble(offsets[5], _maxZoom);
    writer.writeDouble(offsets[6], _minZoom);
    writer.writeDouble(offsets[7], _opacity);
    writer.writeBytes(offsets[8], _wmsBaseUrl);
    writer.writeBytes(offsets[9], _wmsFormat);
    writer.writeStringList(offsets[10], _wmsLayers);
    writer.writeBytes(offsets[11], _wmsParameters);
    writer.writeBytes(offsets[12], _wmsRequest);
    writer.writeBytes(offsets[13], _wmsService);
    writer.writeStringList(offsets[14], _wmsStyles);
    writer.writeBool(offsets[15], _wmsTransparent);
    writer.writeBytes(offsets[16], _wmsVersion);
    writer.writeBytes(offsets[17], _clientRevAt);
    writer.writeBytes(offsets[18], _clientRevBy);
    writer.writeBytes(offsets[19], _serverRevAt);
    writer.writeBool(offsets[20], _deleted);
    return bufferSize;
  }

  @override
  CtileLayer deserialize(IsarCollection<CtileLayer> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = CtileLayer(
      label: reader.readStringOrNull(offsets[1]),
      projectId: reader.readStringOrNull(offsets[2]),
      urlTemplate: reader.readStringOrNull(offsets[3]),
      subdomains: reader.readStringList(offsets[4]),
      maxZoom: reader.readDoubleOrNull(offsets[5]),
      minZoom: reader.readDoubleOrNull(offsets[6]),
      opacity: reader.readDoubleOrNull(offsets[7]),
      wmsBaseUrl: reader.readStringOrNull(offsets[8]),
      wmsFormat: reader.readStringOrNull(offsets[9]),
      wmsLayers: reader.readStringList(offsets[10]),
      wmsParameters: reader.readStringOrNull(offsets[11]),
      wmsRequest: reader.readStringOrNull(offsets[12]),
      wmsService: reader.readStringOrNull(offsets[13]),
      wmsStyles: reader.readStringList(offsets[14]),
      wmsTransparent: reader.readBoolOrNull(offsets[15]),
      wmsVersion: reader.readStringOrNull(offsets[16]),
      clientRevAt: reader.readStringOrNull(offsets[17]),
      clientRevBy: reader.readStringOrNull(offsets[18]),
      serverRevAt: reader.readStringOrNull(offsets[19]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[20]);
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
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readStringList(offset)) as P;
      case 5:
        return (reader.readDoubleOrNull(offset)) as P;
      case 6:
        return (reader.readDoubleOrNull(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringList(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringList(offset)) as P;
      case 15:
        return (reader.readBoolOrNull(offset)) as P;
      case 16:
        return (reader.readStringOrNull(offset)) as P;
      case 17:
        return (reader.readStringOrNull(offset)) as P;
      case 18:
        return (reader.readStringOrNull(offset)) as P;
      case 19:
        return (reader.readStringOrNull(offset)) as P;
      case 20:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension CtileLayerQueryWhereSort
    on QueryBuilder<CtileLayer, CtileLayer, QWhere> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyLabel() {
    return addWhereClause(WhereClause(indexName: 'label'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyProjectId() {
    return addWhereClause(WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CtileLayerQueryWhere
    on QueryBuilder<CtileLayer, CtileLayer, QWhereClause> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdNotEqualTo(
      int? isarId) {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> idNotEqualTo(
      String id) {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelEqualTo(
      String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [label],
      includeLower: true,
      upper: [label],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelNotEqualTo(
      String? label) {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [projectId],
      includeLower: true,
      upper: [projectId],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdNotEqualTo(
      String? projectId) {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtNotEqualTo(
      String? serverRevAt) {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> deletedNotEqualTo(
      bool deleted) {
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

extension CtileLayerQueryFilter
    on QueryBuilder<CtileLayer, CtileLayer, QFilterCondition> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelGreaterThan(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelLessThan(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdLessThan(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      projectIdStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'urlTemplate',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'urlTemplate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'subdomains',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'subdomains',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'subdomains',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> maxZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'maxZoom',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      maxZoomGreaterThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> maxZoomLessThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> maxZoomBetween(
    double? lower,
    double? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'maxZoom',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> minZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'minZoom',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      minZoomGreaterThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> minZoomLessThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> minZoomBetween(
    double? lower,
    double? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'minZoom',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> opacityIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'opacity',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      opacityGreaterThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> opacityLessThan(
    double? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> opacityBetween(
    double? lower,
    double? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'opacity',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsBaseUrl',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsBaseUrlEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsBaseUrlBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsBaseUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsBaseUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsFormatIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsFormat',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatLessThan(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsFormatStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsFormat',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsLayers',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'wmsLayers',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsLayers',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsParameters',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsParameters',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsRequest',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsRequestEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsRequestBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsRequestMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsRequest',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsService',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsServiceEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsServiceBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsServiceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsService',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'wmsStyles',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'wmsStyles',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsStyles',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsTransparentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsTransparent',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsTransparentEqualTo(
    bool? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsTransparent',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsVersion',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsVersionEqualTo(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsVersionBetween(
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsVersionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsVersion',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension CtileLayerQueryWhereSortBy
    on QueryBuilder<CtileLayer, CtileLayer, QSortBy> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByMinZoom() {
    return addSortByInternal('minZoom', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByOpacity() {
    return addSortByInternal('opacity', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByOpacityDesc() {
    return addSortByInternal('opacity', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsService() {
    return addSortByInternal('wmsService', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy>
      sortByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension CtileLayerQueryWhereSortThenBy
    on QueryBuilder<CtileLayer, CtileLayer, QSortThenBy> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByMinZoom() {
    return addSortByInternal('minZoom', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByOpacity() {
    return addSortByInternal('opacity', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByOpacityDesc() {
    return addSortByInternal('opacity', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsService() {
    return addSortByInternal('wmsService', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy>
      thenByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension CtileLayerQueryWhereDistinct
    on QueryBuilder<CtileLayer, CtileLayer, QDistinct> {
  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByUrlTemplate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('urlTemplate', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByMaxZoom() {
    return addDistinctByInternal('maxZoom');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByMinZoom() {
    return addDistinctByInternal('minZoom');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByOpacity() {
    return addDistinctByInternal('opacity');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsBaseUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsBaseUrl', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsFormat(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsFormat', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsParameters(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsParameters', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsRequest(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsRequest', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsService(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsService', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsTransparent() {
    return addDistinctByInternal('wmsTransparent');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByWmsVersion(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsVersion', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension CtileLayerQueryProperty
    on QueryBuilder<CtileLayer, CtileLayer, QQueryProperty> {
  QueryBuilder<CtileLayer, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<CtileLayer, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> urlTemplateProperty() {
    return addPropertyName('urlTemplate');
  }

  QueryBuilder<CtileLayer, List<String>?, QQueryOperations>
      subdomainsProperty() {
    return addPropertyName('subdomains');
  }

  QueryBuilder<CtileLayer, double?, QQueryOperations> maxZoomProperty() {
    return addPropertyName('maxZoom');
  }

  QueryBuilder<CtileLayer, double?, QQueryOperations> minZoomProperty() {
    return addPropertyName('minZoom');
  }

  QueryBuilder<CtileLayer, double?, QQueryOperations> opacityProperty() {
    return addPropertyName('opacity');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsBaseUrlProperty() {
    return addPropertyName('wmsBaseUrl');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsFormatProperty() {
    return addPropertyName('wmsFormat');
  }

  QueryBuilder<CtileLayer, List<String>?, QQueryOperations>
      wmsLayersProperty() {
    return addPropertyName('wmsLayers');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsParametersProperty() {
    return addPropertyName('wmsParameters');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsRequestProperty() {
    return addPropertyName('wmsRequest');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsServiceProperty() {
    return addPropertyName('wmsService');
  }

  QueryBuilder<CtileLayer, List<String>?, QQueryOperations>
      wmsStylesProperty() {
    return addPropertyName('wmsStyles');
  }

  QueryBuilder<CtileLayer, bool?, QQueryOperations> wmsTransparentProperty() {
    return addPropertyName('wmsTransparent');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsVersionProperty() {
    return addPropertyName('wmsVersion');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<CtileLayer, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
