// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relType.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetRelTypeCollection on Isar {
  IsarCollection<RelType> get relTypes {
    return getCollection('RelType');
  }
}

final RelTypeSchema = CollectionSchema(
  name: 'RelType',
  schema:
      '{"name":"RelType","properties":[{"name":"comment","type":"String"},{"name":"deleted","type":"Byte"},{"name":"serverRevAt","type":"Long"},{"name":"sort","type":"Long"},{"name":"value","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"sort","unique":false,"properties":[{"name":"sort","type":"Value","caseSensitive":false}]},{"name":"value","unique":false,"properties":[{"name":"value","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _RelTypeAdapter(),
  idName: 'isarId',
  propertyIds: {
    'comment': 0,
    'deleted': 1,
    'serverRevAt': 2,
    'sort': 3,
    'value': 4
  },
  indexIds: {'deleted': 0, 'serverRevAt': 1, 'sort': 2, 'value': 3},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ],
    'sort': [
      NativeIndexType.long,
    ],
    'value': [
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

class _RelTypeAdapter extends IsarTypeAdapter<RelType> {
  const _RelTypeAdapter();

  @override
  int serialize(IsarCollection<RelType> collection, IsarRawObject rawObj,
      RelType object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.autoIncrement;
    var dynamicSize = 0;
    final value0 = object.comment;
    IsarUint8List? _comment;
    if (value0 != null) {
      _comment = BinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += _comment?.length ?? 0;
    final value1 = object.deleted;
    final _deleted = value1;
    final value2 = object.serverRevAt;
    final _serverRevAt = value2;
    final value3 = object.sort;
    final _sort = value3;
    final value4 = object.value;
    IsarUint8List? _value;
    if (value4 != null) {
      _value = BinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += _value?.length ?? 0;
    final size = dynamicSize + 35;

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
    final writer = BinaryWriter(buffer, 35);
    writer.writeBytes(offsets[0], _comment);
    writer.writeBool(offsets[1], _deleted);
    writer.writeDateTime(offsets[2], _serverRevAt);
    writer.writeLong(offsets[3], _sort);
    writer.writeBytes(offsets[4], _value);
    return bufferSize;
  }

  @override
  RelType deserialize(IsarCollection<RelType> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = RelType(
      comment: reader.readStringOrNull(offsets[0]),
      serverRevAt: reader.readDateTimeOrNull(offsets[2]),
      sort: reader.readLongOrNull(offsets[3]),
      value: reader.readStringOrNull(offsets[4]),
    );
    object.deleted = reader.readBool(offsets[1]);
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
        return (reader.readStringOrNull(offset)) as P;
      case 1:
        return (reader.readBool(offset)) as P;
      case 2:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 3:
        return (reader.readLongOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension RelTypeQueryWhereSort on QueryBuilder<RelType, RelType, QWhere> {
  QueryBuilder<RelType, RelType, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<RelType, RelType, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<RelType, RelType, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<RelType, RelType, QAfterWhere> anySort() {
    return addWhereClause(const WhereClause(indexName: 'sort'));
  }

  QueryBuilder<RelType, RelType, QAfterWhere> anyValue() {
    return addWhereClause(const WhereClause(indexName: 'value'));
  }
}

extension RelTypeQueryWhere on QueryBuilder<RelType, RelType, QWhereClause> {
  QueryBuilder<RelType, RelType, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> isarIdNotEqualTo(
      int? isarId) {
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

  QueryBuilder<RelType, RelType, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<RelType, RelType, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> serverRevAtBetween(
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

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: true,
      upper: [sort],
      includeUpper: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortNotEqualTo(int? sort) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'sort',
        upper: [sort],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'sort',
        lower: [sort],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'sort',
        lower: [sort],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'sort',
        upper: [sort],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortGreaterThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: include,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortLessThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: include,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> sortBetween(
    int? lowerSort,
    int? upperSort, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [lowerSort],
      includeLower: includeLower,
      upper: [upperSort],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> valueEqualTo(
      String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: true,
      upper: [value],
      includeUpper: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> valueNotEqualTo(
      String? value) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'value',
        upper: [value],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'value',
        lower: [value],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'value',
        lower: [value],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'value',
        upper: [value],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension RelTypeQueryFilter
    on QueryBuilder<RelType, RelType, QFilterCondition> {
  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'comment',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<RelType, RelType, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<RelType, RelType, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<RelType, RelType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<RelType, RelType, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<RelType, RelType, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<RelType, RelType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> sortEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> sortGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> sortLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> sortBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'value',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, RelType, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension RelTypeQueryWhereSortBy on QueryBuilder<RelType, RelType, QSortBy> {
  QueryBuilder<RelType, RelType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension RelTypeQueryWhereSortThenBy
    on QueryBuilder<RelType, RelType, QSortThenBy> {
  QueryBuilder<RelType, RelType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<RelType, RelType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension RelTypeQueryWhereDistinct
    on QueryBuilder<RelType, RelType, QDistinct> {
  QueryBuilder<RelType, RelType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<RelType, RelType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<RelType, RelType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<RelType, RelType, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<RelType, RelType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<RelType, RelType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }
}

extension RelTypeQueryProperty
    on QueryBuilder<RelType, RelType, QQueryProperty> {
  QueryBuilder<RelType, String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<RelType, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<RelType, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<RelType, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<RelType, int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<RelType, String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }
}
