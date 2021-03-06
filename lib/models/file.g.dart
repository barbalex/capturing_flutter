// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetCfileCollection on Isar {
  IsarCollection<Cfile> get cfiles {
    return getCollection('Cfile');
  }
}

final CfileSchema = CollectionSchema(
  name: 'Cfile',
  schema:
      '{"name":"Cfile","idName":"isarId","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"conflicts","type":"StringList"},{"name":"deleted","type":"Bool"},{"name":"depth","type":"Long"},{"name":"fieldId","type":"String"},{"name":"filename","type":"String"},{"name":"id","type":"String"},{"name":"localPath","type":"String"},{"name":"parentRev","type":"String"},{"name":"rev","type":"String"},{"name":"revisions","type":"StringList"},{"name":"rowId","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"url","type":"String"},{"name":"version","type":"Long"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"fieldId","unique":false,"properties":[{"name":"fieldId","type":"Hash","caseSensitive":true}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"rowId","unique":false,"properties":[{"name":"rowId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  nativeAdapter: const _CfileNativeAdapter(),
  webAdapter: const _CfileWebAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'conflicts': 2,
    'deleted': 3,
    'depth': 4,
    'fieldId': 5,
    'filename': 6,
    'id': 7,
    'localPath': 8,
    'parentRev': 9,
    'rev': 10,
    'revisions': 11,
    'rowId': 12,
    'serverRevAt': 13,
    'url': 14,
    'version': 15
  },
  listProperties: {'conflicts', 'revisions'},
  indexIds: {'deleted': 0, 'fieldId': 1, 'id': 2, 'rowId': 3, 'serverRevAt': 4},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'fieldId': [
      NativeIndexType.stringHash,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'rowId': [
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

class _CfileWebAdapter extends IsarWebTypeAdapter<Cfile> {
  const _CfileWebAdapter();

  @override
  Object serialize(IsarCollection<Cfile> collection, Cfile object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'clientRevAt',
        object.clientRevAt?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'clientRevBy', object.clientRevBy);
    IsarNative.jsObjectSet(jsObj, 'conflicts', object.conflicts);
    IsarNative.jsObjectSet(jsObj, 'deleted', object.deleted);
    IsarNative.jsObjectSet(jsObj, 'depth', object.depth);
    IsarNative.jsObjectSet(jsObj, 'fieldId', object.fieldId);
    IsarNative.jsObjectSet(jsObj, 'filename', object.filename);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
    IsarNative.jsObjectSet(jsObj, 'localPath', object.localPath);
    IsarNative.jsObjectSet(jsObj, 'parentRev', object.parentRev);
    IsarNative.jsObjectSet(jsObj, 'rev', object.rev);
    IsarNative.jsObjectSet(jsObj, 'revisions', object.revisions);
    IsarNative.jsObjectSet(jsObj, 'rowId', object.rowId);
    IsarNative.jsObjectSet(jsObj, 'serverRevAt',
        object.serverRevAt.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'url', object.url);
    IsarNative.jsObjectSet(jsObj, 'version', object.version);
    return jsObj;
  }

  @override
  Cfile deserialize(IsarCollection<Cfile> collection, dynamic jsObj) {
    final object = Cfile(
      clientRevAt: IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                  isUtc: true)
              .toLocal()
          : null,
      clientRevBy: IsarNative.jsObjectGet(jsObj, 'clientRevBy'),
      conflicts: (IsarNative.jsObjectGet(jsObj, 'conflicts') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>(),
      depth: IsarNative.jsObjectGet(jsObj, 'depth'),
      fieldId: IsarNative.jsObjectGet(jsObj, 'fieldId'),
      filename: IsarNative.jsObjectGet(jsObj, 'filename'),
      localPath: IsarNative.jsObjectGet(jsObj, 'localPath'),
      parentRev: IsarNative.jsObjectGet(jsObj, 'parentRev'),
      rev: IsarNative.jsObjectGet(jsObj, 'rev'),
      revisions: (IsarNative.jsObjectGet(jsObj, 'revisions') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>(),
      rowId: IsarNative.jsObjectGet(jsObj, 'rowId'),
      url: IsarNative.jsObjectGet(jsObj, 'url'),
      version: IsarNative.jsObjectGet(jsObj, 'version'),
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
      case 'conflicts':
        return ((IsarNative.jsObjectGet(jsObj, 'conflicts') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>()) as P;
      case 'deleted':
        return (IsarNative.jsObjectGet(jsObj, 'deleted') ?? false) as P;
      case 'depth':
        return (IsarNative.jsObjectGet(jsObj, 'depth')) as P;
      case 'fieldId':
        return (IsarNative.jsObjectGet(jsObj, 'fieldId')) as P;
      case 'filename':
        return (IsarNative.jsObjectGet(jsObj, 'filename')) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
      case 'isarId':
        return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
      case 'localPath':
        return (IsarNative.jsObjectGet(jsObj, 'localPath')) as P;
      case 'parentRev':
        return (IsarNative.jsObjectGet(jsObj, 'parentRev')) as P;
      case 'rev':
        return (IsarNative.jsObjectGet(jsObj, 'rev')) as P;
      case 'revisions':
        return ((IsarNative.jsObjectGet(jsObj, 'revisions') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>()) as P;
      case 'rowId':
        return (IsarNative.jsObjectGet(jsObj, 'rowId')) as P;
      case 'serverRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'url':
        return (IsarNative.jsObjectGet(jsObj, 'url')) as P;
      case 'version':
        return (IsarNative.jsObjectGet(jsObj, 'version')) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Cfile object) {}
}

class _CfileNativeAdapter extends IsarNativeTypeAdapter<Cfile> {
  const _CfileNativeAdapter();

  @override
  void serialize(IsarCollection<Cfile> collection, IsarRawObject rawObj,
      Cfile object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.clientRevAt;
    final _clientRevAt = value0;
    final value1 = object.clientRevBy;
    IsarUint8List? _clientRevBy;
    if (value1 != null) {
      _clientRevBy = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_clientRevBy?.length ?? 0) as int;
    final value2 = object.conflicts;
    dynamicSize += (value2?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList2;
    if (value2 != null) {
      bytesList2 = [];
      for (var str in value2) {
        final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
        bytesList2.add(bytes);
        dynamicSize += bytes.length as int;
      }
    }
    final _conflicts = bytesList2;
    final value3 = object.deleted;
    final _deleted = value3;
    final value4 = object.depth;
    final _depth = value4;
    final value5 = object.fieldId;
    IsarUint8List? _fieldId;
    if (value5 != null) {
      _fieldId = IsarBinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += (_fieldId?.length ?? 0) as int;
    final value6 = object.filename;
    IsarUint8List? _filename;
    if (value6 != null) {
      _filename = IsarBinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += (_filename?.length ?? 0) as int;
    final value7 = object.id;
    final _id = IsarBinaryWriter.utf8Encoder.convert(value7);
    dynamicSize += (_id.length) as int;
    final value8 = object.localPath;
    IsarUint8List? _localPath;
    if (value8 != null) {
      _localPath = IsarBinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += (_localPath?.length ?? 0) as int;
    final value9 = object.parentRev;
    IsarUint8List? _parentRev;
    if (value9 != null) {
      _parentRev = IsarBinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += (_parentRev?.length ?? 0) as int;
    final value10 = object.rev;
    IsarUint8List? _rev;
    if (value10 != null) {
      _rev = IsarBinaryWriter.utf8Encoder.convert(value10);
    }
    dynamicSize += (_rev?.length ?? 0) as int;
    final value11 = object.revisions;
    dynamicSize += (value11?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList11;
    if (value11 != null) {
      bytesList11 = [];
      for (var str in value11) {
        final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
        bytesList11.add(bytes);
        dynamicSize += bytes.length as int;
      }
    }
    final _revisions = bytesList11;
    final value12 = object.rowId;
    IsarUint8List? _rowId;
    if (value12 != null) {
      _rowId = IsarBinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += (_rowId?.length ?? 0) as int;
    final value13 = object.serverRevAt;
    final _serverRevAt = value13;
    final value14 = object.url;
    IsarUint8List? _url;
    if (value14 != null) {
      _url = IsarBinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += (_url?.length ?? 0) as int;
    final value15 = object.version;
    final _version = value15;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeStringList(offsets[2], _conflicts);
    writer.writeBool(offsets[3], _deleted);
    writer.writeLong(offsets[4], _depth);
    writer.writeBytes(offsets[5], _fieldId);
    writer.writeBytes(offsets[6], _filename);
    writer.writeBytes(offsets[7], _id);
    writer.writeBytes(offsets[8], _localPath);
    writer.writeBytes(offsets[9], _parentRev);
    writer.writeBytes(offsets[10], _rev);
    writer.writeStringList(offsets[11], _revisions);
    writer.writeBytes(offsets[12], _rowId);
    writer.writeDateTime(offsets[13], _serverRevAt);
    writer.writeBytes(offsets[14], _url);
    writer.writeLong(offsets[15], _version);
  }

  @override
  Cfile deserialize(IsarCollection<Cfile> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Cfile(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      conflicts: reader.readStringList(offsets[2]),
      depth: reader.readLongOrNull(offsets[4]),
      fieldId: reader.readStringOrNull(offsets[5]),
      filename: reader.readStringOrNull(offsets[6]),
      localPath: reader.readStringOrNull(offsets[8]),
      parentRev: reader.readStringOrNull(offsets[9]),
      rev: reader.readStringOrNull(offsets[10]),
      revisions: reader.readStringList(offsets[11]),
      rowId: reader.readStringOrNull(offsets[12]),
      url: reader.readStringOrNull(offsets[14]),
      version: reader.readLongOrNull(offsets[15]),
    );
    object.deleted = reader.readBool(offsets[3]);
    object.id = reader.readString(offsets[7]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[13]);
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
        return (reader.readStringList(offset)) as P;
      case 3:
        return (reader.readBool(offset)) as P;
      case 4:
        return (reader.readLongOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readString(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringList(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readDateTime(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readLongOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Cfile object) {}
}

extension CfileQueryWhereSort on QueryBuilder<Cfile, Cfile, QWhere> {
  QueryBuilder<Cfile, Cfile, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyDeleted() {
    return addWhereClauseInternal(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyFieldId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'fieldId'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyRowId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'rowId'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyServerRevAt() {
    return addWhereClauseInternal(const WhereClause(indexName: 'serverRevAt'));
  }
}

extension CfileQueryWhere on QueryBuilder<Cfile, Cfile, QWhereClause> {
  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdEqualTo(
      String? fieldId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'fieldId',
      lower: [fieldId],
      includeLower: true,
      upper: [fieldId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdNotEqualTo(
      String? fieldId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'fieldId',
        upper: [fieldId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'fieldId',
        lower: [fieldId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'fieldId',
        lower: [fieldId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'fieldId',
        upper: [fieldId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'fieldId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'fieldId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdEqualTo(String? rowId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'rowId',
      lower: [rowId],
      includeLower: true,
      upper: [rowId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdNotEqualTo(String? rowId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'rowId',
        upper: [rowId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'rowId',
        lower: [rowId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'rowId',
        lower: [rowId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'rowId',
        upper: [rowId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'rowId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'rowId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtEqualTo(
      DateTime serverRevAt) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtBetween(
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

extension CfileQueryFilter on QueryBuilder<Cfile, Cfile, QFilterCondition> {
  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'conflicts',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'conflicts',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'conflicts',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'conflicts',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'depth',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'depth',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'fieldId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fieldId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fieldId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'filename',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'filename',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'filename',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'localPath',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'localPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'localPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentRev',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'parentRev',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'parentRev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'rev',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rev',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'rev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'revisions',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'revisions',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'revisions',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'revisions',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'rowId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rowId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'rowId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'url',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'url',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'version',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'version',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension CfileQueryLinks on QueryBuilder<Cfile, Cfile, QFilterCondition> {}

extension CfileQueryWhereSortBy on QueryBuilder<Cfile, Cfile, QSortBy> {
  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByFieldId() {
    return addSortByInternal('fieldId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByFieldIdDesc() {
    return addSortByInternal('fieldId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByFilename() {
    return addSortByInternal('filename', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByFilenameDesc() {
    return addSortByInternal('filename', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByParentRev() {
    return addSortByInternal('parentRev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRev() {
    return addSortByInternal('rev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRevDesc() {
    return addSortByInternal('rev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRowId() {
    return addSortByInternal('rowId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRowIdDesc() {
    return addSortByInternal('rowId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByUrl() {
    return addSortByInternal('url', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByUrlDesc() {
    return addSortByInternal('url', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByVersion() {
    return addSortByInternal('version', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByVersionDesc() {
    return addSortByInternal('version', Sort.desc);
  }
}

extension CfileQueryWhereSortThenBy on QueryBuilder<Cfile, Cfile, QSortThenBy> {
  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByFieldId() {
    return addSortByInternal('fieldId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByFieldIdDesc() {
    return addSortByInternal('fieldId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByFilename() {
    return addSortByInternal('filename', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByFilenameDesc() {
    return addSortByInternal('filename', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByParentRev() {
    return addSortByInternal('parentRev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRev() {
    return addSortByInternal('rev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRevDesc() {
    return addSortByInternal('rev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRowId() {
    return addSortByInternal('rowId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRowIdDesc() {
    return addSortByInternal('rowId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByUrl() {
    return addSortByInternal('url', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByUrlDesc() {
    return addSortByInternal('url', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByVersion() {
    return addSortByInternal('version', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByVersionDesc() {
    return addSortByInternal('version', Sort.desc);
  }
}

extension CfileQueryWhereDistinct on QueryBuilder<Cfile, Cfile, QDistinct> {
  QueryBuilder<Cfile, Cfile, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByDepth() {
    return addDistinctByInternal('depth');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByFieldId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByFilename(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('filename', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('localPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByParentRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentRev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('rev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByRowId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('rowId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('url', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByVersion() {
    return addDistinctByInternal('version');
  }
}

extension CfileQueryProperty on QueryBuilder<Cfile, Cfile, QQueryProperty> {
  QueryBuilder<Cfile, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyNameInternal('clientRevAt');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyNameInternal('clientRevBy');
  }

  QueryBuilder<Cfile, List<String>?, QQueryOperations> conflictsProperty() {
    return addPropertyNameInternal('conflicts');
  }

  QueryBuilder<Cfile, bool, QQueryOperations> deletedProperty() {
    return addPropertyNameInternal('deleted');
  }

  QueryBuilder<Cfile, int?, QQueryOperations> depthProperty() {
    return addPropertyNameInternal('depth');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> fieldIdProperty() {
    return addPropertyNameInternal('fieldId');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> filenameProperty() {
    return addPropertyNameInternal('filename');
  }

  QueryBuilder<Cfile, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Cfile, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> localPathProperty() {
    return addPropertyNameInternal('localPath');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> parentRevProperty() {
    return addPropertyNameInternal('parentRev');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> revProperty() {
    return addPropertyNameInternal('rev');
  }

  QueryBuilder<Cfile, List<String>?, QQueryOperations> revisionsProperty() {
    return addPropertyNameInternal('revisions');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> rowIdProperty() {
    return addPropertyNameInternal('rowId');
  }

  QueryBuilder<Cfile, DateTime, QQueryOperations> serverRevAtProperty() {
    return addPropertyNameInternal('serverRevAt');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> urlProperty() {
    return addPropertyNameInternal('url');
  }

  QueryBuilder<Cfile, int?, QQueryOperations> versionProperty() {
    return addPropertyNameInternal('version');
  }
}
