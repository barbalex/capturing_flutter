// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fieldType.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetFieldTypeCollection on Isar {
  IsarCollection<FieldType> get fieldTypes {
    return getCollection('FieldType');
  }
}

final FieldTypeSchema = CollectionSchema(
  name: 'FieldType',
  schema:
      '{"name":"FieldType","properties":[{"name":"comment","type":"String"},{"name":"deleted","type":"Byte"},{"name":"serverRevAt","type":"Long"},{"name":"sort","type":"Long"},{"name":"value","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"sort","unique":false,"properties":[{"name":"sort","type":"Value","caseSensitive":false}]},{"name":"value","unique":false,"properties":[{"name":"value","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _FieldTypeAdapter(),
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

class _FieldTypeAdapter extends IsarTypeAdapter<FieldType> {
  const _FieldTypeAdapter();

  @override
  int serialize(IsarCollection<FieldType> collection, IsarRawObject rawObj,
      FieldType object, List<int> offsets,
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
  FieldType deserialize(IsarCollection<FieldType> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = FieldType(
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

extension FieldTypeQueryWhereSort
    on QueryBuilder<FieldType, FieldType, QWhere> {
  QueryBuilder<FieldType, FieldType, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhere> anySort() {
    return addWhereClause(const WhereClause(indexName: 'sort'));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhere> anyValue() {
    return addWhereClause(const WhereClause(indexName: 'value'));
  }
}

extension FieldTypeQueryWhere
    on QueryBuilder<FieldType, FieldType, QWhereClause> {
  QueryBuilder<FieldType, FieldType, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> serverRevAtBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: true,
      upper: [sort],
      includeUpper: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortNotEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortGreaterThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: include,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortLessThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: include,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> sortBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> valueEqualTo(
      String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: true,
      upper: [value],
      includeUpper: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> valueNotEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension FieldTypeQueryFilter
    on QueryBuilder<FieldType, FieldType, QFilterCondition> {
  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentGreaterThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentLessThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentStartsWith(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentEndsWith(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition>
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition>
      serverRevAtGreaterThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> sortEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> sortGreaterThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> sortLessThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> sortBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueGreaterThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueBetween(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueStartsWith(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueEndsWith(
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

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, FieldType, QAfterFilterCondition> valueMatches(
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

extension FieldTypeQueryWhereSortBy
    on QueryBuilder<FieldType, FieldType, QSortBy> {
  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension FieldTypeQueryWhereSortThenBy
    on QueryBuilder<FieldType, FieldType, QSortThenBy> {
  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<FieldType, FieldType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension FieldTypeQueryWhereDistinct
    on QueryBuilder<FieldType, FieldType, QDistinct> {
  QueryBuilder<FieldType, FieldType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<FieldType, FieldType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<FieldType, FieldType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<FieldType, FieldType, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<FieldType, FieldType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<FieldType, FieldType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }
}

extension FieldTypeQueryProperty
    on QueryBuilder<FieldType, FieldType, QQueryProperty> {
  QueryBuilder<FieldType, String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<FieldType, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<FieldType, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<FieldType, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<FieldType, int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<FieldType, String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }
}
