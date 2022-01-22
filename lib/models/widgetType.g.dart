// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetType.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetWidgetTypeCollection on Isar {
  IsarCollection<WidgetType> get widgetTypes {
    return getCollection('WidgetType');
  }
}

final WidgetTypeSchema = CollectionSchema(
  name: 'WidgetType',
  schema:
      '{"name":"WidgetType","properties":[{"name":"comment","type":"String"},{"name":"deleted","type":"Byte"},{"name":"needsList","type":"Byte"},{"name":"serverRevAt","type":"Long"},{"name":"sort","type":"Long"},{"name":"value","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"sort","unique":false,"properties":[{"name":"sort","type":"Value","caseSensitive":false}]},{"name":"value","unique":false,"properties":[{"name":"value","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _WidgetTypeAdapter(),
  idName: 'isarId',
  propertyIds: {
    'comment': 0,
    'deleted': 1,
    'needsList': 2,
    'serverRevAt': 3,
    'sort': 4,
    'value': 5
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

class _WidgetTypeAdapter extends IsarTypeAdapter<WidgetType> {
  const _WidgetTypeAdapter();

  @override
  int serialize(IsarCollection<WidgetType> collection, IsarRawObject rawObj,
      WidgetType object, List<int> offsets,
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
    final value2 = object.needsList;
    final _needsList = value2;
    final value3 = object.serverRevAt;
    final _serverRevAt = value3;
    final value4 = object.sort;
    final _sort = value4;
    final value5 = object.value;
    IsarUint8List? _value;
    if (value5 != null) {
      _value = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _value?.length ?? 0;
    final size = dynamicSize + 36;

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
    final writer = BinaryWriter(buffer, 36);
    writer.writeBytes(offsets[0], _comment);
    writer.writeBool(offsets[1], _deleted);
    writer.writeBool(offsets[2], _needsList);
    writer.writeDateTime(offsets[3], _serverRevAt);
    writer.writeLong(offsets[4], _sort);
    writer.writeBytes(offsets[5], _value);
    return bufferSize;
  }

  @override
  WidgetType deserialize(IsarCollection<WidgetType> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = WidgetType(
      comment: reader.readStringOrNull(offsets[0]),
      needsList: reader.readBoolOrNull(offsets[2]),
      sort: reader.readLongOrNull(offsets[4]),
      value: reader.readStringOrNull(offsets[5]),
    );
    object.deleted = reader.readBool(offsets[1]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[3]);
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
        return (reader.readBoolOrNull(offset)) as P;
      case 3:
        return (reader.readDateTime(offset)) as P;
      case 4:
        return (reader.readLongOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension WidgetTypeQueryWhereSort
    on QueryBuilder<WidgetType, WidgetType, QWhere> {
  QueryBuilder<WidgetType, WidgetType, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhere> anySort() {
    return addWhereClause(const WhereClause(indexName: 'sort'));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhere> anyValue() {
    return addWhereClause(const WhereClause(indexName: 'value'));
  }
}

extension WidgetTypeQueryWhere
    on QueryBuilder<WidgetType, WidgetType, QWhereClause> {
  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> serverRevAtEqualTo(
      DateTime serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> serverRevAtNotEqualTo(
      DateTime serverRevAt) {
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause>
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> serverRevAtBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortEqualTo(
      int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: true,
      upper: [sort],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortNotEqualTo(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortGreaterThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: include,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortLessThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: include,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> sortBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> valueEqualTo(
      String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: true,
      upper: [value],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> valueNotEqualTo(
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

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension WidgetTypeQueryFilter
    on QueryBuilder<WidgetType, WidgetType, QFilterCondition> {
  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentEqualTo(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition>
      commentGreaterThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentLessThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentStartsWith(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentEndsWith(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition>
      needsListIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'needsList',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> needsListEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'needsList',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition>
      serverRevAtEqualTo(DateTime value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition>
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition>
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition>
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> sortEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> sortGreaterThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> sortLessThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> sortBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueGreaterThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueBetween(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueStartsWith(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueEndsWith(
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

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, WidgetType, QAfterFilterCondition> valueMatches(
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

extension WidgetTypeQueryWhereSortBy
    on QueryBuilder<WidgetType, WidgetType, QSortBy> {
  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByNeedsList() {
    return addSortByInternal('needsList', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByNeedsListDesc() {
    return addSortByInternal('needsList', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension WidgetTypeQueryWhereSortThenBy
    on QueryBuilder<WidgetType, WidgetType, QSortThenBy> {
  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByNeedsList() {
    return addSortByInternal('needsList', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByNeedsListDesc() {
    return addSortByInternal('needsList', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<WidgetType, WidgetType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension WidgetTypeQueryWhereDistinct
    on QueryBuilder<WidgetType, WidgetType, QDistinct> {
  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctByNeedsList() {
    return addDistinctByInternal('needsList');
  }

  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<WidgetType, WidgetType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }
}

extension WidgetTypeQueryProperty
    on QueryBuilder<WidgetType, WidgetType, QQueryProperty> {
  QueryBuilder<WidgetType, String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<WidgetType, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<WidgetType, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<WidgetType, bool?, QQueryOperations> needsListProperty() {
    return addPropertyName('needsList');
  }

  QueryBuilder<WidgetType, DateTime, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<WidgetType, int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<WidgetType, String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }
}
