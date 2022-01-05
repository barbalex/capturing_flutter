// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetCfileCollection on Isar {
  IsarCollection<Cfile> get cfiles {
    return getCollection('Cfile');
  }
}

final CfileSchema = CollectionSchema(
  name: 'Cfile',
  schema:
      '{"name":"Cfile","properties":[{"name":"id","type":"String"},{"name":"rowId","type":"String"},{"name":"fieldId","type":"String"},{"name":"filename","type":"String"},{"name":"localPath","type":"String"},{"name":"url","type":"String"},{"name":"version","type":"Long"},{"name":"clientRevAt","type":"String"},{"name":"clientRevBy","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"},{"name":"rev","type":"String"},{"name":"parentRev","type":"String"},{"name":"revisions","type":"StringList"},{"name":"depth","type":"Long"},{"name":"conflicts","type":"StringList"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"rowId","unique":false,"properties":[{"name":"rowId","type":"Hash","caseSensitive":true}]},{"name":"fieldId","unique":false,"properties":[{"name":"fieldId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _CfileAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'rowId': 1,
    'fieldId': 2,
    'filename': 3,
    'localPath': 4,
    'url': 5,
    'version': 6,
    'clientRevAt': 7,
    'clientRevBy': 8,
    'serverRevAt': 9,
    'deleted': 10,
    'rev': 11,
    'parentRev': 12,
    'revisions': 13,
    'depth': 14,
    'conflicts': 15
  },
  indexIds: {'id': 0, 'rowId': 1, 'fieldId': 2, 'serverRevAt': 3, 'deleted': 4},
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
    'rowId': [
      NativeIndexType.stringHash,
    ],
    'fieldId': [
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

class _CfileAdapter extends IsarTypeAdapter<Cfile> {
  const _CfileAdapter();

  @override
  int serialize(IsarCollection<Cfile> collection, RawObject rawObj,
      Cfile object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += _id.length;
    final value1 = object.rowId;
    Uint8List? _rowId;
    if (value1 != null) {
      _rowId = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _rowId?.length ?? 0;
    final value2 = object.fieldId;
    Uint8List? _fieldId;
    if (value2 != null) {
      _fieldId = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _fieldId?.length ?? 0;
    final value3 = object.filename;
    Uint8List? _filename;
    if (value3 != null) {
      _filename = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _filename?.length ?? 0;
    final value4 = object.localPath;
    Uint8List? _localPath;
    if (value4 != null) {
      _localPath = BinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += _localPath?.length ?? 0;
    final value5 = object.url;
    Uint8List? _url;
    if (value5 != null) {
      _url = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _url?.length ?? 0;
    final value6 = object.version;
    final _version = value6;
    final value7 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value7 != null) {
      _clientRevAt = BinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value8 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value8 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value9 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value9 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value10 = object.deleted;
    final _deleted = value10;
    final value11 = object.rev;
    Uint8List? _rev;
    if (value11 != null) {
      _rev = BinaryWriter.utf8Encoder.convert(value11);
    }
    dynamicSize += _rev?.length ?? 0;
    final value12 = object.parentRev;
    Uint8List? _parentRev;
    if (value12 != null) {
      _parentRev = BinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += _parentRev?.length ?? 0;
    final value13 = object.revisions;
    dynamicSize += (value13?.length ?? 0) * 8;
    List<Uint8List?>? bytesList13;
    if (value13 != null) {
      bytesList13 = [];
      for (var str in value13) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList13.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _revisions = bytesList13;
    final value14 = object.depth;
    final _depth = value14;
    final value15 = object.conflicts;
    dynamicSize += (value15?.length ?? 0) * 8;
    List<Uint8List?>? bytesList15;
    if (value15 != null) {
      bytesList15 = [];
      for (var str in value15) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList15.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _conflicts = bytesList15;
    final size = dynamicSize + 131;

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
    final writer = BinaryWriter(buffer, 131);
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _rowId);
    writer.writeBytes(offsets[2], _fieldId);
    writer.writeBytes(offsets[3], _filename);
    writer.writeBytes(offsets[4], _localPath);
    writer.writeBytes(offsets[5], _url);
    writer.writeLong(offsets[6], _version);
    writer.writeBytes(offsets[7], _clientRevAt);
    writer.writeBytes(offsets[8], _clientRevBy);
    writer.writeBytes(offsets[9], _serverRevAt);
    writer.writeBool(offsets[10], _deleted);
    writer.writeBytes(offsets[11], _rev);
    writer.writeBytes(offsets[12], _parentRev);
    writer.writeStringList(offsets[13], _revisions);
    writer.writeLong(offsets[14], _depth);
    writer.writeStringList(offsets[15], _conflicts);
    return bufferSize;
  }

  @override
  Cfile deserialize(IsarCollection<Cfile> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Cfile(
      rowId: reader.readStringOrNull(offsets[1]),
      fieldId: reader.readStringOrNull(offsets[2]),
      filename: reader.readStringOrNull(offsets[3]),
      localPath: reader.readStringOrNull(offsets[4]),
      url: reader.readStringOrNull(offsets[5]),
      version: reader.readLongOrNull(offsets[6]),
      clientRevAt: reader.readStringOrNull(offsets[7]),
      clientRevBy: reader.readStringOrNull(offsets[8]),
      serverRevAt: reader.readStringOrNull(offsets[9]),
      rev: reader.readStringOrNull(offsets[11]),
      parentRev: reader.readStringOrNull(offsets[12]),
      revisions: reader.readStringList(offsets[13]),
      depth: reader.readLongOrNull(offsets[14]),
      conflicts: reader.readStringList(offsets[15]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[10]);
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
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readLongOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readBool(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringList(offset)) as P;
      case 14:
        return (reader.readLongOrNull(offset)) as P;
      case 15:
        return (reader.readStringList(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension CfileQueryWhereSort on QueryBuilder<Cfile, Cfile, QWhere> {
  QueryBuilder<Cfile, Cfile, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyRowId() {
    return addWhereClause(WhereClause(indexName: 'rowId'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyFieldId() {
    return addWhereClause(WhereClause(indexName: 'fieldId'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CfileQueryWhere on QueryBuilder<Cfile, Cfile, QWhereClause> {
  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdEqualTo(String? rowId) {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      lower: [rowId],
      includeLower: true,
      upper: [rowId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdNotEqualTo(String? rowId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'rowId',
        upper: [rowId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'rowId',
        lower: [rowId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'rowId',
        lower: [rowId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'rowId',
        upper: [rowId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> rowIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdEqualTo(
      String? fieldId) {
    return addWhereClause(WhereClause(
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
      return addWhereClause(WhereClause(
        indexName: 'fieldId',
        upper: [fieldId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'fieldId',
        lower: [fieldId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'fieldId',
        lower: [fieldId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'fieldId',
        upper: [fieldId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> fieldIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
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

extension CfileQueryFilter on QueryBuilder<Cfile, Cfile, QFilterCondition> {
  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'rowId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'rowId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> rowIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'rowId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'fieldId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fieldId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> fieldIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'fieldId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'filename',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'filename',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> filenameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'filename',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'localPath',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'localPath',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> localPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'localPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'url',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlStartsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> urlMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'url',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'version',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> versionBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'version',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtEqualTo(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'rev',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'rev',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revStartsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'rev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentRev',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'parentRev',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> parentRevMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'parentRev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'revisions',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'revisions',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'revisions',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'revisions',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'revisions',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'revisions',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> revisionsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'revisions',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'depth',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> depthBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'depth',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'conflicts',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'conflicts',
      value: null,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'conflicts',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'conflicts',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'conflicts',
      value: value,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'conflicts',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, Cfile, QAfterFilterCondition> conflictsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'conflicts',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CfileQueryWhereSortBy on QueryBuilder<Cfile, Cfile, QSortBy> {
  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRowId() {
    return addSortByInternal('rowId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRowIdDesc() {
    return addSortByInternal('rowId', Sort.desc);
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

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
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

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRev() {
    return addSortByInternal('rev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByRevDesc() {
    return addSortByInternal('rev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByParentRev() {
    return addSortByInternal('parentRev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> sortByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }
}

extension CfileQueryWhereSortThenBy on QueryBuilder<Cfile, Cfile, QSortThenBy> {
  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRowId() {
    return addSortByInternal('rowId', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRowIdDesc() {
    return addSortByInternal('rowId', Sort.desc);
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

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
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

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRev() {
    return addSortByInternal('rev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByRevDesc() {
    return addSortByInternal('rev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByParentRev() {
    return addSortByInternal('parentRev', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.desc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Cfile, Cfile, QAfterSortBy> thenByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }
}

extension CfileQueryWhereDistinct on QueryBuilder<Cfile, Cfile, QDistinct> {
  QueryBuilder<Cfile, Cfile, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByRowId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('rowId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByFieldId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByFilename(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('filename', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('localPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('url', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByVersion() {
    return addDistinctByInternal('version');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('rev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByParentRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentRev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, Cfile, QDistinct> distinctByDepth() {
    return addDistinctByInternal('depth');
  }
}

extension CfileQueryProperty on QueryBuilder<Cfile, Cfile, QQueryProperty> {
  QueryBuilder<Cfile, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Cfile, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> rowIdProperty() {
    return addPropertyName('rowId');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> fieldIdProperty() {
    return addPropertyName('fieldId');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> filenameProperty() {
    return addPropertyName('filename');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> localPathProperty() {
    return addPropertyName('localPath');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> urlProperty() {
    return addPropertyName('url');
  }

  QueryBuilder<Cfile, int?, QQueryOperations> versionProperty() {
    return addPropertyName('version');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Cfile, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> revProperty() {
    return addPropertyName('rev');
  }

  QueryBuilder<Cfile, String?, QQueryOperations> parentRevProperty() {
    return addPropertyName('parentRev');
  }

  QueryBuilder<Cfile, List<String>?, QQueryOperations> revisionsProperty() {
    return addPropertyName('revisions');
  }

  QueryBuilder<Cfile, int?, QQueryOperations> depthProperty() {
    return addPropertyName('depth');
  }

  QueryBuilder<Cfile, List<String>?, QQueryOperations> conflictsProperty() {
    return addPropertyName('conflicts');
  }
}
