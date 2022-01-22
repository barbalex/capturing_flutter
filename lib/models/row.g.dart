// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetCrowCollection on Isar {
  IsarCollection<Crow> get crows {
    return getCollection('Crow');
  }
}

final CrowSchema = CollectionSchema(
  name: 'Crow',
  schema:
      '{"name":"Crow","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"conflicts","type":"StringList"},{"name":"data","type":"String"},{"name":"deleted","type":"Byte"},{"name":"depth","type":"Long"},{"name":"geometry","type":"String"},{"name":"geometryE","type":"Double"},{"name":"geometryN","type":"Double"},{"name":"geometryS","type":"Double"},{"name":"geometryW","type":"Double"},{"name":"id","type":"String"},{"name":"parentId","type":"String"},{"name":"parentRev","type":"String"},{"name":"rev","type":"String"},{"name":"revisions","type":"StringList"},{"name":"serverRevAt","type":"Long"},{"name":"tableId","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"tableId","unique":false,"properties":[{"name":"tableId","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _CrowAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'conflicts': 2,
    'data': 3,
    'deleted': 4,
    'depth': 5,
    'geometry': 6,
    'geometryE': 7,
    'geometryN': 8,
    'geometryS': 9,
    'geometryW': 10,
    'id': 11,
    'parentId': 12,
    'parentRev': 13,
    'rev': 14,
    'revisions': 15,
    'serverRevAt': 16,
    'tableId': 17
  },
  indexIds: {'deleted': 0, 'id': 1, 'serverRevAt': 2, 'tableId': 3},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ],
    'tableId': [
      NativeIndexType.stringHash,
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

class _CrowAdapter extends IsarTypeAdapter<Crow> {
  const _CrowAdapter();

  @override
  int serialize(IsarCollection<Crow> collection, IsarRawObject rawObj,
      Crow object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.autoIncrement;
    var dynamicSize = 0;
    final value0 = object.clientRevAt;
    final _clientRevAt = value0;
    final value1 = object.clientRevBy;
    IsarUint8List? _clientRevBy;
    if (value1 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value2 = object.conflicts;
    dynamicSize += (value2?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList2;
    if (value2 != null) {
      bytesList2 = [];
      for (var str in value2) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList2.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _conflicts = bytesList2;
    final value3 = object.data;
    IsarUint8List? _data;
    if (value3 != null) {
      _data = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _data?.length ?? 0;
    final value4 = object.deleted;
    final _deleted = value4;
    final value5 = object.depth;
    final _depth = value5;
    final value6 = object.geometry;
    IsarUint8List? _geometry;
    if (value6 != null) {
      _geometry = BinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += _geometry?.length ?? 0;
    final value7 = object.geometryE;
    final _geometryE = value7;
    final value8 = object.geometryN;
    final _geometryN = value8;
    final value9 = object.geometryS;
    final _geometryS = value9;
    final value10 = object.geometryW;
    final _geometryW = value10;
    final value11 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value11);
    dynamicSize += _id.length;
    final value12 = object.parentId;
    IsarUint8List? _parentId;
    if (value12 != null) {
      _parentId = BinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += _parentId?.length ?? 0;
    final value13 = object.parentRev;
    IsarUint8List? _parentRev;
    if (value13 != null) {
      _parentRev = BinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += _parentRev?.length ?? 0;
    final value14 = object.rev;
    IsarUint8List? _rev;
    if (value14 != null) {
      _rev = BinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += _rev?.length ?? 0;
    final value15 = object.revisions;
    dynamicSize += (value15?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList15;
    if (value15 != null) {
      bytesList15 = [];
      for (var str in value15) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList15.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _revisions = bytesList15;
    final value16 = object.serverRevAt;
    final _serverRevAt = value16;
    final value17 = object.tableId;
    IsarUint8List? _tableId;
    if (value17 != null) {
      _tableId = BinaryWriter.utf8Encoder.convert(value17);
    }
    dynamicSize += _tableId?.length ?? 0;
    final size = dynamicSize + 139;

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
    final writer = BinaryWriter(buffer, 139);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeStringList(offsets[2], _conflicts);
    writer.writeBytes(offsets[3], _data);
    writer.writeBool(offsets[4], _deleted);
    writer.writeLong(offsets[5], _depth);
    writer.writeBytes(offsets[6], _geometry);
    writer.writeDouble(offsets[7], _geometryE);
    writer.writeDouble(offsets[8], _geometryN);
    writer.writeDouble(offsets[9], _geometryS);
    writer.writeDouble(offsets[10], _geometryW);
    writer.writeBytes(offsets[11], _id);
    writer.writeBytes(offsets[12], _parentId);
    writer.writeBytes(offsets[13], _parentRev);
    writer.writeBytes(offsets[14], _rev);
    writer.writeStringList(offsets[15], _revisions);
    writer.writeDateTime(offsets[16], _serverRevAt);
    writer.writeBytes(offsets[17], _tableId);
    return bufferSize;
  }

  @override
  Crow deserialize(IsarCollection<Crow> collection, int id, BinaryReader reader,
      List<int> offsets) {
    final object = Crow(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      conflicts: reader.readStringList(offsets[2]),
      data: reader.readStringOrNull(offsets[3]),
      depth: reader.readLongOrNull(offsets[5]),
      geometry: reader.readStringOrNull(offsets[6]),
      geometryE: reader.readDoubleOrNull(offsets[7]),
      geometryN: reader.readDoubleOrNull(offsets[8]),
      geometryS: reader.readDoubleOrNull(offsets[9]),
      geometryW: reader.readDoubleOrNull(offsets[10]),
      parentId: reader.readStringOrNull(offsets[12]),
      parentRev: reader.readStringOrNull(offsets[13]),
      rev: reader.readStringOrNull(offsets[14]),
      revisions: reader.readStringList(offsets[15]),
      serverRevAt: reader.readDateTimeOrNull(offsets[16]),
      tableId: reader.readStringOrNull(offsets[17]),
    );
    object.deleted = reader.readBool(offsets[4]);
    object.id = reader.readString(offsets[11]);
    object.isarId = id;
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, BinaryReader reader, int propertyIndex, int offset) {
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
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readBool(offset)) as P;
      case 5:
        return (reader.readLongOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readDoubleOrNull(offset)) as P;
      case 9:
        return (reader.readDoubleOrNull(offset)) as P;
      case 10:
        return (reader.readDoubleOrNull(offset)) as P;
      case 11:
        return (reader.readString(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readStringList(offset)) as P;
      case 16:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 17:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension CrowQueryWhereSort on QueryBuilder<Crow, Crow, QWhere> {
  QueryBuilder<Crow, Crow, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<Crow, Crow, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<Crow, Crow, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<Crow, Crow, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Crow, Crow, QAfterWhere> anyTableId() {
    return addWhereClause(const WhereClause(indexName: 'tableId'));
  }
}

extension CrowQueryWhere on QueryBuilder<Crow, Crow, QWhereClause> {
  QueryBuilder<Crow, Crow, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
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

  QueryBuilder<Crow, Crow, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<Crow, Crow, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

  QueryBuilder<Crow, Crow, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtNotEqualTo(
      DateTime? serverRevAt) {
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

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> serverRevAtBetween(
    DateTime? lowerServerRevAt,
    DateTime? upperServerRevAt, {
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

  QueryBuilder<Crow, Crow, QAfterWhereClause> tableIdEqualTo(String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [tableId],
      includeLower: true,
      upper: [tableId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> tableIdNotEqualTo(
      String? tableId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'tableId',
        upper: [tableId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'tableId',
        lower: [tableId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'tableId',
        lower: [tableId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'tableId',
        upper: [tableId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> tableIdIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'tableId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterWhereClause> tableIdIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'tableId',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension CrowQueryFilter on QueryBuilder<Crow, Crow, QFilterCondition> {
  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'conflicts',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'conflicts',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'conflicts',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'conflicts',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> conflictsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'conflicts',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'data',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'data',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> dataMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'data',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> depthIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'depth',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> depthEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> depthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> depthLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> depthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'depth',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'geometry',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometry',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'geometry',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryEIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'geometryE',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryEGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'geometryE',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryELessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'geometryE',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryEBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryE',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryNIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'geometryN',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryNGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'geometryN',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryNLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'geometryN',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryNBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryN',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometrySIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'geometryS',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometrySGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'geometryS',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometrySLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'geometryS',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometrySBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryS',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryWIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'geometryW',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryWGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'geometryW',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryWLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'geometryW',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> geometryWBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryW',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentId',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'parentId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'parentId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentRev',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevEqualTo(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'parentRev',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> parentRevMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'parentRev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'rev',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revEqualTo(
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'rev',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'rev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'revisions',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'revisions',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'revisions',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'revisions',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> revisionsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'revisions',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> serverRevAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> serverRevAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> serverRevAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'tableId',
      value: null,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'tableId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, Crow, QAfterFilterCondition> tableIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'tableId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CrowQueryWhereSortBy on QueryBuilder<Crow, Crow, QSortBy> {
  QueryBuilder<Crow, Crow, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByData() {
    return addSortByInternal('data', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByDataDesc() {
    return addSortByInternal('data', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometry() {
    return addSortByInternal('geometry', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryDesc() {
    return addSortByInternal('geometry', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryE() {
    return addSortByInternal('geometryE', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryEDesc() {
    return addSortByInternal('geometryE', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryN() {
    return addSortByInternal('geometryN', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryNDesc() {
    return addSortByInternal('geometryN', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryS() {
    return addSortByInternal('geometryS', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometrySDesc() {
    return addSortByInternal('geometryS', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryW() {
    return addSortByInternal('geometryW', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByGeometryWDesc() {
    return addSortByInternal('geometryW', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByParentId() {
    return addSortByInternal('parentId', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByParentIdDesc() {
    return addSortByInternal('parentId', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByParentRev() {
    return addSortByInternal('parentRev', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByRev() {
    return addSortByInternal('rev', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByRevDesc() {
    return addSortByInternal('rev', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> sortByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }
}

extension CrowQueryWhereSortThenBy on QueryBuilder<Crow, Crow, QSortThenBy> {
  QueryBuilder<Crow, Crow, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByData() {
    return addSortByInternal('data', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByDataDesc() {
    return addSortByInternal('data', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometry() {
    return addSortByInternal('geometry', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryDesc() {
    return addSortByInternal('geometry', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryE() {
    return addSortByInternal('geometryE', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryEDesc() {
    return addSortByInternal('geometryE', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryN() {
    return addSortByInternal('geometryN', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryNDesc() {
    return addSortByInternal('geometryN', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryS() {
    return addSortByInternal('geometryS', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometrySDesc() {
    return addSortByInternal('geometryS', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryW() {
    return addSortByInternal('geometryW', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByGeometryWDesc() {
    return addSortByInternal('geometryW', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByParentId() {
    return addSortByInternal('parentId', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByParentIdDesc() {
    return addSortByInternal('parentId', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByParentRev() {
    return addSortByInternal('parentRev', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByRev() {
    return addSortByInternal('rev', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByRevDesc() {
    return addSortByInternal('rev', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Crow, Crow, QAfterSortBy> thenByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }
}

extension CrowQueryWhereDistinct on QueryBuilder<Crow, Crow, QDistinct> {
  QueryBuilder<Crow, Crow, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('data', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByDepth() {
    return addDistinctByInternal('depth');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByGeometry(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('geometry', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByGeometryE() {
    return addDistinctByInternal('geometryE');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByGeometryN() {
    return addDistinctByInternal('geometryN');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByGeometryS() {
    return addDistinctByInternal('geometryS');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByGeometryW() {
    return addDistinctByInternal('geometryW');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByParentRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentRev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('rev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Crow, Crow, QDistinct> distinctByTableId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tableId', caseSensitive: caseSensitive);
  }
}

extension CrowQueryProperty on QueryBuilder<Crow, Crow, QQueryProperty> {
  QueryBuilder<Crow, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Crow, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Crow, List<String>?, QQueryOperations> conflictsProperty() {
    return addPropertyName('conflicts');
  }

  QueryBuilder<Crow, String?, QQueryOperations> dataProperty() {
    return addPropertyName('data');
  }

  QueryBuilder<Crow, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<Crow, int?, QQueryOperations> depthProperty() {
    return addPropertyName('depth');
  }

  QueryBuilder<Crow, String?, QQueryOperations> geometryProperty() {
    return addPropertyName('geometry');
  }

  QueryBuilder<Crow, double?, QQueryOperations> geometryEProperty() {
    return addPropertyName('geometryE');
  }

  QueryBuilder<Crow, double?, QQueryOperations> geometryNProperty() {
    return addPropertyName('geometryN');
  }

  QueryBuilder<Crow, double?, QQueryOperations> geometrySProperty() {
    return addPropertyName('geometryS');
  }

  QueryBuilder<Crow, double?, QQueryOperations> geometryWProperty() {
    return addPropertyName('geometryW');
  }

  QueryBuilder<Crow, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Crow, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Crow, String?, QQueryOperations> parentIdProperty() {
    return addPropertyName('parentId');
  }

  QueryBuilder<Crow, String?, QQueryOperations> parentRevProperty() {
    return addPropertyName('parentRev');
  }

  QueryBuilder<Crow, String?, QQueryOperations> revProperty() {
    return addPropertyName('rev');
  }

  QueryBuilder<Crow, List<String>?, QQueryOperations> revisionsProperty() {
    return addPropertyName('revisions');
  }

  QueryBuilder<Crow, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Crow, String?, QQueryOperations> tableIdProperty() {
    return addPropertyName('tableId');
  }
}
