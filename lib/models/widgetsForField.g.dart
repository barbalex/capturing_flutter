// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetsForField.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetWidgetsForFieldCollection on Isar {
  IsarCollection<WidgetsForField> get widgetsForFields {
    return getCollection('WidgetsForField');
  }
}

final WidgetsForFieldSchema = CollectionSchema(
  name: 'WidgetsForField',
  schema:
      '{"name":"WidgetsForField","properties":[{"name":"fieldValue","type":"String"},{"name":"widgetValue","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"fieldValue","unique":false,"properties":[{"name":"fieldValue","type":"Hash","caseSensitive":true}]},{"name":"widgetValue","unique":false,"properties":[{"name":"widgetValue","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _WidgetsForFieldAdapter(),
  idName: 'isarId',
  propertyIds: {
    'fieldValue': 0,
    'widgetValue': 1,
    'serverRevAt': 2,
    'deleted': 3
  },
  indexIds: {'fieldValue': 0, 'widgetValue': 1, 'serverRevAt': 2, 'deleted': 3},
  indexTypes: {
    'fieldValue': [
      NativeIndexType.stringHash,
    ],
    'widgetValue': [
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

class _WidgetsForFieldAdapter extends IsarTypeAdapter<WidgetsForField> {
  const _WidgetsForFieldAdapter();

  @override
  int serialize(IsarCollection<WidgetsForField> collection, RawObject rawObj,
      WidgetsForField object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.fieldValue;
    Uint8List? _fieldValue;
    if (value0 != null) {
      _fieldValue = BinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += _fieldValue?.length ?? 0;
    final value1 = object.widgetValue;
    Uint8List? _widgetValue;
    if (value1 != null) {
      _widgetValue = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _widgetValue?.length ?? 0;
    final value2 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value2 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value3 = object.deleted;
    final _deleted = value3;
    final size = dynamicSize + 35;

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
    final writer = BinaryWriter(buffer, 35);
    writer.writeBytes(offsets[0], _fieldValue);
    writer.writeBytes(offsets[1], _widgetValue);
    writer.writeBytes(offsets[2], _serverRevAt);
    writer.writeBool(offsets[3], _deleted);
    return bufferSize;
  }

  @override
  WidgetsForField deserialize(IsarCollection<WidgetsForField> collection,
      int id, BinaryReader reader, List<int> offsets) {
    final object = WidgetsForField(
      fieldValue: reader.readStringOrNull(offsets[0]),
      widgetValue: reader.readStringOrNull(offsets[1]),
      serverRevAt: reader.readStringOrNull(offsets[2]),
    );
    object.isarId = id;
    object.deleted = reader.readBool(offsets[3]);
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
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension WidgetsForFieldQueryWhereSort
    on QueryBuilder<WidgetsForField, WidgetsForField, QWhere> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyFieldValue() {
    return addWhereClause(WhereClause(indexName: 'fieldValue'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyWidgetValue() {
    return addWhereClause(WhereClause(indexName: 'widgetValue'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension WidgetsForFieldQueryWhere
    on QueryBuilder<WidgetsForField, WidgetsForField, QWhereClause> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      fieldValueEqualTo(String? fieldValue) {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      lower: [fieldValue],
      includeLower: true,
      upper: [fieldValue],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      fieldValueNotEqualTo(String? fieldValue) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'fieldValue',
        upper: [fieldValue],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'fieldValue',
        lower: [fieldValue],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'fieldValue',
        lower: [fieldValue],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'fieldValue',
        upper: [fieldValue],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      fieldValueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      fieldValueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      widgetValueEqualTo(String? widgetValue) {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      lower: [widgetValue],
      includeLower: true,
      upper: [widgetValue],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      widgetValueNotEqualTo(String? widgetValue) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'widgetValue',
        upper: [widgetValue],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'widgetValue',
        lower: [widgetValue],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'widgetValue',
        lower: [widgetValue],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'widgetValue',
        upper: [widgetValue],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      widgetValueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      widgetValueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtEqualTo(String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtNotEqualTo(String? serverRevAt) {
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
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

extension WidgetsForFieldQueryFilter
    on QueryBuilder<WidgetsForField, WidgetsForField, QFilterCondition> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'fieldValue',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fieldValue',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'fieldValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'widgetValue',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'widgetValue',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'widgetValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

extension WidgetsForFieldQueryWhereSortBy
    on QueryBuilder<WidgetsForField, WidgetsForField, QSortBy> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByFieldValue() {
    return addSortByInternal('fieldValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByFieldValueDesc() {
    return addSortByInternal('fieldValue', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByWidgetValue() {
    return addSortByInternal('widgetValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByWidgetValueDesc() {
    return addSortByInternal('widgetValue', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension WidgetsForFieldQueryWhereSortThenBy
    on QueryBuilder<WidgetsForField, WidgetsForField, QSortThenBy> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByFieldValue() {
    return addSortByInternal('fieldValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByFieldValueDesc() {
    return addSortByInternal('fieldValue', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByWidgetValue() {
    return addSortByInternal('widgetValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByWidgetValueDesc() {
    return addSortByInternal('widgetValue', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension WidgetsForFieldQueryWhereDistinct
    on QueryBuilder<WidgetsForField, WidgetsForField, QDistinct> {
  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByFieldValue({bool caseSensitive = true}) {
    return addDistinctByInternal('fieldValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByWidgetValue({bool caseSensitive = true}) {
    return addDistinctByInternal('widgetValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByServerRevAt({bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension WidgetsForFieldQueryProperty
    on QueryBuilder<WidgetsForField, WidgetsForField, QQueryProperty> {
  QueryBuilder<WidgetsForField, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<WidgetsForField, String?, QQueryOperations>
      fieldValueProperty() {
    return addPropertyName('fieldValue');
  }

  QueryBuilder<WidgetsForField, String?, QQueryOperations>
      widgetValueProperty() {
    return addPropertyName('widgetValue');
  }

  QueryBuilder<WidgetsForField, String?, QQueryOperations>
      serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<WidgetsForField, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
