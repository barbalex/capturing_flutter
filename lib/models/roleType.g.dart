// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roleType.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetRoleTypeCollection on Isar {
  IsarCollection<RoleType> get roleTypes {
    return getCollection('RoleType');
  }
}

final RoleTypeSchema = CollectionSchema(
  name: 'RoleType',
  schema:
      '{"name":"RoleType","properties":[{"name":"value","type":"String"},{"name":"sort","type":"Long"},{"name":"comment","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"value","unique":false,"properties":[{"name":"value","type":"Hash","caseSensitive":true}]},{"name":"sort","unique":false,"properties":[{"name":"sort","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _RoleTypeAdapter(),
  idName: 'isarId',
  propertyIds: {
    'value': 0,
    'sort': 1,
    'comment': 2,
    'serverRevAt': 3,
    'deleted': 4
  },
  indexIds: {'value': 0, 'sort': 1, 'serverRevAt': 2, 'deleted': 3},
  indexTypes: {
    'value': [
      NativeIndexType.stringHash,
    ],
    'sort': [
      NativeIndexType.long,
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

class _RoleTypeAdapter extends IsarTypeAdapter<RoleType> {
  const _RoleTypeAdapter();

  @override
  int serialize(IsarCollection<RoleType> collection, RawObject rawObj,
      RoleType object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.value;
    Uint8List? _value;
    if (value0 != null) {
      _value = BinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += _value?.length ?? 0;
    final value1 = object.sort;
    final _sort = value1;
    final value2 = object.comment;
    Uint8List? _comment;
    if (value2 != null) {
      _comment = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _comment?.length ?? 0;
    final value3 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value3 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value4 = object.deleted;
    final _deleted = value4;
    final size = dynamicSize + 43;

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
    final writer = BinaryWriter(buffer, 43);
    writer.writeBytes(offsets[0], _value);
    writer.writeLong(offsets[1], _sort);
    writer.writeBytes(offsets[2], _comment);
    writer.writeBytes(offsets[3], _serverRevAt);
    writer.writeBool(offsets[4], _deleted);
    return bufferSize;
  }

  @override
  RoleType deserialize(IsarCollection<RoleType> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = RoleType(
      value: reader.readStringOrNull(offsets[0]),
      sort: reader.readLongOrNull(offsets[1]),
      comment: reader.readStringOrNull(offsets[2]),
      serverRevAt: reader.readStringOrNull(offsets[3]),
    );
    object.isarId = id;
    object.deleted = reader.readBool(offsets[4]);
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
        return (reader.readLongOrNull(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension RoleTypeQueryWhereSort on QueryBuilder<RoleType, RoleType, QWhere> {
  QueryBuilder<RoleType, RoleType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhere> anyValue() {
    return addWhereClause(WhereClause(indexName: 'value'));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension RoleTypeQueryWhere on QueryBuilder<RoleType, RoleType, QWhereClause> {
  QueryBuilder<RoleType, RoleType, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> valueEqualTo(
      String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: true,
      upper: [value],
      includeUpper: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> valueNotEqualTo(
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

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: true,
      upper: [sort],
      includeUpper: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortNotEqualTo(
      int? sort) {
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

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortGreaterThan(
      int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortLessThan(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: false,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> sortBetween(
      int? lowerSort, int? upperSort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [lowerSort],
      includeLower: true,
      upper: [upperSort],
      includeUpper: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterWhereClause> deletedNotEqualTo(
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

extension RoleTypeQueryFilter
    on QueryBuilder<RoleType, RoleType, QFilterCondition> {
  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'value',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> sortEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> sortGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> sortLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> sortBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentEqualTo(
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

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'comment',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtEqualTo(
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

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition>
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

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, RoleType, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension RoleTypeQueryWhereSortBy
    on QueryBuilder<RoleType, RoleType, QSortBy> {
  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension RoleTypeQueryWhereSortThenBy
    on QueryBuilder<RoleType, RoleType, QSortThenBy> {
  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<RoleType, RoleType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension RoleTypeQueryWhereDistinct
    on QueryBuilder<RoleType, RoleType, QDistinct> {
  QueryBuilder<RoleType, RoleType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<RoleType, RoleType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<RoleType, RoleType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<RoleType, RoleType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<RoleType, RoleType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<RoleType, RoleType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension RoleTypeQueryProperty
    on QueryBuilder<RoleType, RoleType, QQueryProperty> {
  QueryBuilder<RoleType, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<RoleType, String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }

  QueryBuilder<RoleType, int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<RoleType, String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<RoleType, String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<RoleType, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
