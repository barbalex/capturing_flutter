// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tileLayer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetCtileLayerCollection on Isar {
  IsarCollection<CtileLayer> get ctileLayers {
    return getCollection('CtileLayer');
  }
}

final CtileLayerSchema = CollectionSchema(
  name: 'CtileLayer',
  schema:
      '{"name":"CtileLayer","idName":"isarId","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Bool"},{"name":"id","type":"String"},{"name":"label","type":"String"},{"name":"maxZoom","type":"Double"},{"name":"minZoom","type":"Double"},{"name":"opacity","type":"Double"},{"name":"projectId","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"subdomains","type":"StringList"},{"name":"urlTemplate","type":"String"},{"name":"wmsBaseUrl","type":"String"},{"name":"wmsFormat","type":"String"},{"name":"wmsLayers","type":"StringList"},{"name":"wmsParameters","type":"String"},{"name":"wmsRequest","type":"String"},{"name":"wmsService","type":"String"},{"name":"wmsStyles","type":"StringList"},{"name":"wmsTransparent","type":"Bool"},{"name":"wmsVersion","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"label","unique":false,"properties":[{"name":"label","type":"Hash","caseSensitive":true}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  nativeAdapter: const _CtileLayerNativeAdapter(),
  webAdapter: const _CtileLayerWebAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'deleted': 2,
    'id': 3,
    'label': 4,
    'maxZoom': 5,
    'minZoom': 6,
    'opacity': 7,
    'projectId': 8,
    'serverRevAt': 9,
    'subdomains': 10,
    'urlTemplate': 11,
    'wmsBaseUrl': 12,
    'wmsFormat': 13,
    'wmsLayers': 14,
    'wmsParameters': 15,
    'wmsRequest': 16,
    'wmsService': 17,
    'wmsStyles': 18,
    'wmsTransparent': 19,
    'wmsVersion': 20
  },
  listProperties: {'subdomains', 'wmsLayers', 'wmsStyles'},
  indexIds: {
    'deleted': 0,
    'id': 1,
    'label': 2,
    'projectId': 3,
    'serverRevAt': 4
  },
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
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
      NativeIndexType.long,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.isarId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.isarId;
    }
  },
  setId: (obj, id) => obj.isarId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _CtileLayerWebAdapter extends IsarWebTypeAdapter<CtileLayer> {
  const _CtileLayerWebAdapter();

  @override
  Object serialize(IsarCollection<CtileLayer> collection, CtileLayer object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'clientRevAt',
        object.clientRevAt?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'clientRevBy', object.clientRevBy);
    IsarNative.jsObjectSet(jsObj, 'deleted', object.deleted);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
    IsarNative.jsObjectSet(jsObj, 'label', object.label);
    IsarNative.jsObjectSet(jsObj, 'maxZoom', object.maxZoom);
    IsarNative.jsObjectSet(jsObj, 'minZoom', object.minZoom);
    IsarNative.jsObjectSet(jsObj, 'opacity', object.opacity);
    IsarNative.jsObjectSet(jsObj, 'projectId', object.projectId);
    IsarNative.jsObjectSet(jsObj, 'serverRevAt',
        object.serverRevAt.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'subdomains', object.subdomains);
    IsarNative.jsObjectSet(jsObj, 'urlTemplate', object.urlTemplate);
    IsarNative.jsObjectSet(jsObj, 'wmsBaseUrl', object.wmsBaseUrl);
    IsarNative.jsObjectSet(jsObj, 'wmsFormat', object.wmsFormat);
    IsarNative.jsObjectSet(jsObj, 'wmsLayers', object.wmsLayers);
    IsarNative.jsObjectSet(jsObj, 'wmsParameters', object.wmsParameters);
    IsarNative.jsObjectSet(jsObj, 'wmsRequest', object.wmsRequest);
    IsarNative.jsObjectSet(jsObj, 'wmsService', object.wmsService);
    IsarNative.jsObjectSet(jsObj, 'wmsStyles', object.wmsStyles);
    IsarNative.jsObjectSet(jsObj, 'wmsTransparent', object.wmsTransparent);
    IsarNative.jsObjectSet(jsObj, 'wmsVersion', object.wmsVersion);
    return jsObj;
  }

  @override
  CtileLayer deserialize(IsarCollection<CtileLayer> collection, dynamic jsObj) {
    final object = CtileLayer(
      clientRevAt: IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                  isUtc: true)
              .toLocal()
          : null,
      clientRevBy: IsarNative.jsObjectGet(jsObj, 'clientRevBy'),
      label: IsarNative.jsObjectGet(jsObj, 'label'),
      maxZoom: IsarNative.jsObjectGet(jsObj, 'maxZoom'),
      minZoom: IsarNative.jsObjectGet(jsObj, 'minZoom'),
      opacity: IsarNative.jsObjectGet(jsObj, 'opacity'),
      projectId: IsarNative.jsObjectGet(jsObj, 'projectId'),
      subdomains: (IsarNative.jsObjectGet(jsObj, 'subdomains') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>(),
      urlTemplate: IsarNative.jsObjectGet(jsObj, 'urlTemplate'),
      wmsBaseUrl: IsarNative.jsObjectGet(jsObj, 'wmsBaseUrl'),
      wmsFormat: IsarNative.jsObjectGet(jsObj, 'wmsFormat'),
      wmsLayers: (IsarNative.jsObjectGet(jsObj, 'wmsLayers') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>(),
      wmsParameters: IsarNative.jsObjectGet(jsObj, 'wmsParameters'),
      wmsRequest: IsarNative.jsObjectGet(jsObj, 'wmsRequest'),
      wmsService: IsarNative.jsObjectGet(jsObj, 'wmsService'),
      wmsStyles: (IsarNative.jsObjectGet(jsObj, 'wmsStyles') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>(),
      wmsTransparent: IsarNative.jsObjectGet(jsObj, 'wmsTransparent'),
      wmsVersion: IsarNative.jsObjectGet(jsObj, 'wmsVersion'),
    );
    object.deleted = IsarNative.jsObjectGet(jsObj, 'deleted') ?? false;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? '';
    object.isarId = IsarNative.jsObjectGet(jsObj, 'isarId');
    object.serverRevAt = IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'clientRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                    isUtc: true)
                .toLocal()
            : null) as P;
      case 'clientRevBy':
        return (IsarNative.jsObjectGet(jsObj, 'clientRevBy')) as P;
      case 'deleted':
        return (IsarNative.jsObjectGet(jsObj, 'deleted') ?? false) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
      case 'isarId':
        return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
      case 'label':
        return (IsarNative.jsObjectGet(jsObj, 'label')) as P;
      case 'maxZoom':
        return (IsarNative.jsObjectGet(jsObj, 'maxZoom')) as P;
      case 'minZoom':
        return (IsarNative.jsObjectGet(jsObj, 'minZoom')) as P;
      case 'opacity':
        return (IsarNative.jsObjectGet(jsObj, 'opacity')) as P;
      case 'projectId':
        return (IsarNative.jsObjectGet(jsObj, 'projectId')) as P;
      case 'serverRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'subdomains':
        return ((IsarNative.jsObjectGet(jsObj, 'subdomains') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>()) as P;
      case 'urlTemplate':
        return (IsarNative.jsObjectGet(jsObj, 'urlTemplate')) as P;
      case 'wmsBaseUrl':
        return (IsarNative.jsObjectGet(jsObj, 'wmsBaseUrl')) as P;
      case 'wmsFormat':
        return (IsarNative.jsObjectGet(jsObj, 'wmsFormat')) as P;
      case 'wmsLayers':
        return ((IsarNative.jsObjectGet(jsObj, 'wmsLayers') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>()) as P;
      case 'wmsParameters':
        return (IsarNative.jsObjectGet(jsObj, 'wmsParameters')) as P;
      case 'wmsRequest':
        return (IsarNative.jsObjectGet(jsObj, 'wmsRequest')) as P;
      case 'wmsService':
        return (IsarNative.jsObjectGet(jsObj, 'wmsService')) as P;
      case 'wmsStyles':
        return ((IsarNative.jsObjectGet(jsObj, 'wmsStyles') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>()) as P;
      case 'wmsTransparent':
        return (IsarNative.jsObjectGet(jsObj, 'wmsTransparent')) as P;
      case 'wmsVersion':
        return (IsarNative.jsObjectGet(jsObj, 'wmsVersion')) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, CtileLayer object) {}
}

class _CtileLayerNativeAdapter extends IsarNativeTypeAdapter<CtileLayer> {
  const _CtileLayerNativeAdapter();

  @override
  void serialize(
      IsarCollection<CtileLayer> collection,
      IsarRawObject rawObj,
      CtileLayer object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.clientRevAt;
    final _clientRevAt = value0;
    final value1 = object.clientRevBy;
    IsarUint8List? _clientRevBy;
    if (value1 != null) {
      _clientRevBy = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_clientRevBy?.length ?? 0) as int;
    final value2 = object.deleted;
    final _deleted = value2;
    final value3 = object.id;
    final _id = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_id.length) as int;
    final value4 = object.label;
    IsarUint8List? _label;
    if (value4 != null) {
      _label = IsarBinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += (_label?.length ?? 0) as int;
    final value5 = object.maxZoom;
    final _maxZoom = value5;
    final value6 = object.minZoom;
    final _minZoom = value6;
    final value7 = object.opacity;
    final _opacity = value7;
    final value8 = object.projectId;
    IsarUint8List? _projectId;
    if (value8 != null) {
      _projectId = IsarBinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += (_projectId?.length ?? 0) as int;
    final value9 = object.serverRevAt;
    final _serverRevAt = value9;
    final value10 = object.subdomains;
    dynamicSize += (value10?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList10;
    if (value10 != null) {
      bytesList10 = [];
      for (var str in value10) {
        final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
        bytesList10.add(bytes);
        dynamicSize += bytes.length as int;
      }
    }
    final _subdomains = bytesList10;
    final value11 = object.urlTemplate;
    IsarUint8List? _urlTemplate;
    if (value11 != null) {
      _urlTemplate = IsarBinaryWriter.utf8Encoder.convert(value11);
    }
    dynamicSize += (_urlTemplate?.length ?? 0) as int;
    final value12 = object.wmsBaseUrl;
    IsarUint8List? _wmsBaseUrl;
    if (value12 != null) {
      _wmsBaseUrl = IsarBinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += (_wmsBaseUrl?.length ?? 0) as int;
    final value13 = object.wmsFormat;
    IsarUint8List? _wmsFormat;
    if (value13 != null) {
      _wmsFormat = IsarBinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += (_wmsFormat?.length ?? 0) as int;
    final value14 = object.wmsLayers;
    dynamicSize += (value14?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList14;
    if (value14 != null) {
      bytesList14 = [];
      for (var str in value14) {
        final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
        bytesList14.add(bytes);
        dynamicSize += bytes.length as int;
      }
    }
    final _wmsLayers = bytesList14;
    final value15 = object.wmsParameters;
    IsarUint8List? _wmsParameters;
    if (value15 != null) {
      _wmsParameters = IsarBinaryWriter.utf8Encoder.convert(value15);
    }
    dynamicSize += (_wmsParameters?.length ?? 0) as int;
    final value16 = object.wmsRequest;
    IsarUint8List? _wmsRequest;
    if (value16 != null) {
      _wmsRequest = IsarBinaryWriter.utf8Encoder.convert(value16);
    }
    dynamicSize += (_wmsRequest?.length ?? 0) as int;
    final value17 = object.wmsService;
    IsarUint8List? _wmsService;
    if (value17 != null) {
      _wmsService = IsarBinaryWriter.utf8Encoder.convert(value17);
    }
    dynamicSize += (_wmsService?.length ?? 0) as int;
    final value18 = object.wmsStyles;
    dynamicSize += (value18?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList18;
    if (value18 != null) {
      bytesList18 = [];
      for (var str in value18) {
        final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
        bytesList18.add(bytes);
        dynamicSize += bytes.length as int;
      }
    }
    final _wmsStyles = bytesList18;
    final value19 = object.wmsTransparent;
    final _wmsTransparent = value19;
    final value20 = object.wmsVersion;
    IsarUint8List? _wmsVersion;
    if (value20 != null) {
      _wmsVersion = IsarBinaryWriter.utf8Encoder.convert(value20);
    }
    dynamicSize += (_wmsVersion?.length ?? 0) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeBool(offsets[2], _deleted);
    writer.writeBytes(offsets[3], _id);
    writer.writeBytes(offsets[4], _label);
    writer.writeDouble(offsets[5], _maxZoom);
    writer.writeDouble(offsets[6], _minZoom);
    writer.writeDouble(offsets[7], _opacity);
    writer.writeBytes(offsets[8], _projectId);
    writer.writeDateTime(offsets[9], _serverRevAt);
    writer.writeStringList(offsets[10], _subdomains);
    writer.writeBytes(offsets[11], _urlTemplate);
    writer.writeBytes(offsets[12], _wmsBaseUrl);
    writer.writeBytes(offsets[13], _wmsFormat);
    writer.writeStringList(offsets[14], _wmsLayers);
    writer.writeBytes(offsets[15], _wmsParameters);
    writer.writeBytes(offsets[16], _wmsRequest);
    writer.writeBytes(offsets[17], _wmsService);
    writer.writeStringList(offsets[18], _wmsStyles);
    writer.writeBool(offsets[19], _wmsTransparent);
    writer.writeBytes(offsets[20], _wmsVersion);
  }

  @override
  CtileLayer deserialize(IsarCollection<CtileLayer> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = CtileLayer(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      label: reader.readStringOrNull(offsets[4]),
      maxZoom: reader.readDoubleOrNull(offsets[5]),
      minZoom: reader.readDoubleOrNull(offsets[6]),
      opacity: reader.readDoubleOrNull(offsets[7]),
      projectId: reader.readStringOrNull(offsets[8]),
      subdomains: reader.readStringList(offsets[10]),
      urlTemplate: reader.readStringOrNull(offsets[11]),
      wmsBaseUrl: reader.readStringOrNull(offsets[12]),
      wmsFormat: reader.readStringOrNull(offsets[13]),
      wmsLayers: reader.readStringList(offsets[14]),
      wmsParameters: reader.readStringOrNull(offsets[15]),
      wmsRequest: reader.readStringOrNull(offsets[16]),
      wmsService: reader.readStringOrNull(offsets[17]),
      wmsStyles: reader.readStringList(offsets[18]),
      wmsTransparent: reader.readBoolOrNull(offsets[19]),
      wmsVersion: reader.readStringOrNull(offsets[20]),
    );
    object.deleted = reader.readBool(offsets[2]);
    object.id = reader.readString(offsets[3]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[9]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readBool(offset)) as P;
      case 3:
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readDoubleOrNull(offset)) as P;
      case 6:
        return (reader.readDoubleOrNull(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readDateTime(offset)) as P;
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
        return (reader.readStringOrNull(offset)) as P;
      case 16:
        return (reader.readStringOrNull(offset)) as P;
      case 17:
        return (reader.readStringOrNull(offset)) as P;
      case 18:
        return (reader.readStringList(offset)) as P;
      case 19:
        return (reader.readBoolOrNull(offset)) as P;
      case 20:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, CtileLayer object) {}
}

extension CtileLayerQueryWhereSort
    on QueryBuilder<CtileLayer, CtileLayer, QWhere> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyDeleted() {
    return addWhereClauseInternal(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyLabel() {
    return addWhereClauseInternal(const WhereClause(indexName: 'label'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyProjectId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhere> anyServerRevAt() {
    return addWhereClauseInternal(const WhereClause(indexName: 'serverRevAt'));
  }
}

extension CtileLayerQueryWhere
    on QueryBuilder<CtileLayer, CtileLayer, QWhereClause> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdNotEqualTo(
      int? isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> isarIdBetween(
    int? lowerIsarId,
    int? upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerIsarId],
      includeLower: includeLower,
      upper: [upperIsarId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClauseInternal(WhereClause(
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
      return addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClauseInternal(WhereClause(
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
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelEqualTo(
      String? label) {
    return addWhereClauseInternal(WhereClause(
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
      return addWhereClauseInternal(WhereClause(
        indexName: 'label',
        upper: [label],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'label',
        lower: [label],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'label',
        lower: [label],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'label',
        upper: [label],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> labelIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'label',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClauseInternal(WhereClause(
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
      return addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtEqualTo(
      DateTime serverRevAt) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtNotEqualTo(
      DateTime serverRevAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause>
      serverRevAtGreaterThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterWhereClause> serverRevAtBetween(
    DateTime lowerServerRevAt,
    DateTime upperServerRevAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [lowerServerRevAt],
      includeLower: includeLower,
      upper: [upperServerRevAt],
      includeUpper: includeUpper,
    ));
  }
}

extension CtileLayerQueryFilter
    on QueryBuilder<CtileLayer, CtileLayer, QFilterCondition> {
  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtEqualTo(DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByIsNull() {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clientRevBy',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      clientRevByMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'label',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> maxZoomIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'maxZoom',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      maxZoomGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> maxZoomLessThan(
      double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> maxZoomBetween(
      double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'maxZoom',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> minZoomIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'minZoom',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      minZoomGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> minZoomLessThan(
      double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> minZoomBetween(
      double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'minZoom',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> opacityIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'opacity',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      opacityGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> opacityLessThan(
      double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> opacityBetween(
      double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'opacity',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      projectIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'projectId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      projectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      serverRevAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'subdomains',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'subdomains',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      subdomainsAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'subdomains',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateIsNull() {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'urlTemplate',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      urlTemplateMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'urlTemplate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsBaseUrl',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsBaseUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsBaseUrlBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsBaseUrl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsBaseUrlContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsBaseUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsBaseUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsFormatIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsFormat',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsFormat',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsFormatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsFormatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsFormat',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsLayers',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsLayers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsLayersAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsLayers',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersIsNull() {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsParameters',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsParametersMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsParameters',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsRequest',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsRequestEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsRequestBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsRequest',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsRequestContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsRequestMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsRequest',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsService',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsServiceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsServiceBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsService',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsServiceContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsServiceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsService',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsStyles',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsStyles',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsStylesAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsStyles',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsTransparentIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsTransparent',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsTransparentEqualTo(bool? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'wmsTransparent',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'wmsVersion',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsVersionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsVersionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'wmsVersion',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition>
      wmsVersionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterFilterCondition> wmsVersionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'wmsVersion',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CtileLayerQueryLinks
    on QueryBuilder<CtileLayer, CtileLayer, QFilterCondition> {}

extension CtileLayerQueryWhereSortBy
    on QueryBuilder<CtileLayer, CtileLayer, QSortBy> {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> sortByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
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
}

extension CtileLayerQueryWhereSortThenBy
    on QueryBuilder<CtileLayer, CtileLayer, QSortThenBy> {
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
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

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.asc);
  }

  QueryBuilder<CtileLayer, CtileLayer, QAfterSortBy> thenByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.desc);
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
}

extension CtileLayerQueryWhereDistinct
    on QueryBuilder<CtileLayer, CtileLayer, QDistinct> {
  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
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

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<CtileLayer, CtileLayer, QDistinct> distinctByUrlTemplate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('urlTemplate', caseSensitive: caseSensitive);
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
}

extension CtileLayerQueryProperty
    on QueryBuilder<CtileLayer, CtileLayer, QQueryProperty> {
  QueryBuilder<CtileLayer, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyNameInternal('clientRevAt');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyNameInternal('clientRevBy');
  }

  QueryBuilder<CtileLayer, bool, QQueryOperations> deletedProperty() {
    return addPropertyNameInternal('deleted');
  }

  QueryBuilder<CtileLayer, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CtileLayer, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> labelProperty() {
    return addPropertyNameInternal('label');
  }

  QueryBuilder<CtileLayer, double?, QQueryOperations> maxZoomProperty() {
    return addPropertyNameInternal('maxZoom');
  }

  QueryBuilder<CtileLayer, double?, QQueryOperations> minZoomProperty() {
    return addPropertyNameInternal('minZoom');
  }

  QueryBuilder<CtileLayer, double?, QQueryOperations> opacityProperty() {
    return addPropertyNameInternal('opacity');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> projectIdProperty() {
    return addPropertyNameInternal('projectId');
  }

  QueryBuilder<CtileLayer, DateTime, QQueryOperations> serverRevAtProperty() {
    return addPropertyNameInternal('serverRevAt');
  }

  QueryBuilder<CtileLayer, List<String>?, QQueryOperations>
      subdomainsProperty() {
    return addPropertyNameInternal('subdomains');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> urlTemplateProperty() {
    return addPropertyNameInternal('urlTemplate');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsBaseUrlProperty() {
    return addPropertyNameInternal('wmsBaseUrl');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsFormatProperty() {
    return addPropertyNameInternal('wmsFormat');
  }

  QueryBuilder<CtileLayer, List<String>?, QQueryOperations>
      wmsLayersProperty() {
    return addPropertyNameInternal('wmsLayers');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsParametersProperty() {
    return addPropertyNameInternal('wmsParameters');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsRequestProperty() {
    return addPropertyNameInternal('wmsRequest');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsServiceProperty() {
    return addPropertyNameInternal('wmsService');
  }

  QueryBuilder<CtileLayer, List<String>?, QQueryOperations>
      wmsStylesProperty() {
    return addPropertyNameInternal('wmsStyles');
  }

  QueryBuilder<CtileLayer, bool?, QQueryOperations> wmsTransparentProperty() {
    return addPropertyNameInternal('wmsTransparent');
  }

  QueryBuilder<CtileLayer, String?, QQueryOperations> wmsVersionProperty() {
    return addPropertyNameInternal('wmsVersion');
  }
}
