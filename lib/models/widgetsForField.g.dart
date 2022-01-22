// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgetsForField.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetWidgetsForFieldCollection on Isar {
  IsarCollection<WidgetsForField> get widgetsForFields {
    return getCollection('WidgetsForField');
  }
}

final WidgetsForFieldSchema = CollectionSchema(
  name: 'WidgetsForField',
  schema:
      '{"name":"WidgetsForField","properties":[{"name":"deleted","type":"Byte"},{"name":"fieldValue","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"widgetValue","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"fieldValue","unique":false,"properties":[{"name":"fieldValue","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"widgetValue","unique":false,"properties":[{"name":"widgetValue","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _WidgetsForFieldAdapter(),
  idName: 'isarId',
  propertyIds: {
    'deleted': 0,
    'fieldValue': 1,
    'serverRevAt': 2,
    'widgetValue': 3
  },
  indexIds: {'deleted': 0, 'fieldValue': 1, 'serverRevAt': 2, 'widgetValue': 3},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'fieldValue': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ],
    'widgetValue': [
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

class _WidgetsForFieldAdapter extends IsarTypeAdapter<WidgetsForField> {
  const _WidgetsForFieldAdapter();

  @override
  int serialize(IsarCollection<WidgetsForField> collection,
      IsarRawObject rawObj, WidgetsForField object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.autoIncrement;
    var dynamicSize = 0;
    final value0 = object.deleted;
    final _deleted = value0;
    final value1 = object.fieldValue;
    IsarUint8List? _fieldValue;
    if (value1 != null) {
      _fieldValue = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _fieldValue?.length ?? 0;
    final value2 = object.serverRevAt;
    final _serverRevAt = value2;
    final value3 = object.widgetValue;
    IsarUint8List? _widgetValue;
    if (value3 != null) {
      _widgetValue = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _widgetValue?.length ?? 0;
    final size = dynamicSize + 27;

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
    final writer = BinaryWriter(buffer, 27);
    writer.writeBool(offsets[0], _deleted);
    writer.writeBytes(offsets[1], _fieldValue);
    writer.writeDateTime(offsets[2], _serverRevAt);
    writer.writeBytes(offsets[3], _widgetValue);
    return bufferSize;
  }

  @override
  WidgetsForField deserialize(IsarCollection<WidgetsForField> collection,
      int id, BinaryReader reader, List<int> offsets) {
    final object = WidgetsForField(
      fieldValue: reader.readStringOrNull(offsets[1]),
      serverRevAt: reader.readDateTimeOrNull(offsets[2]),
      widgetValue: reader.readStringOrNull(offsets[3]),
    );
    object.deleted = reader.readBool(offsets[0]);
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
        return (reader.readBool(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension WidgetsForFieldQueryWhereSort
    on QueryBuilder<WidgetsForField, WidgetsForField, QWhere> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyFieldValue() {
    return addWhereClause(const WhereClause(indexName: 'fieldValue'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhere> anyWidgetValue() {
    return addWhereClause(const WhereClause(indexName: 'widgetValue'));
  }
}

extension WidgetsForFieldQueryWhere
    on QueryBuilder<WidgetsForField, WidgetsForField, QWhereClause> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      isarIdBetween(
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
    return addWhereClause(const WhereClause(
      indexName: 'fieldValue',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      fieldValueIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'fieldValue',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtEqualTo(DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtNotEqualTo(DateTime? serverRevAt) {
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
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtGreaterThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      serverRevAtBetween(
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
    return addWhereClause(const WhereClause(
      indexName: 'widgetValue',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterWhereClause>
      widgetValueIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'widgetValue',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension WidgetsForFieldQueryFilter
    on QueryBuilder<WidgetsForField, WidgetsForField, QFilterCondition> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fieldValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      fieldValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
      isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdLessThan(
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtEqualTo(DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtLessThan(
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

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      serverRevAtBetween(
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'widgetValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterFilterCondition>
      widgetValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
}

extension WidgetsForFieldQueryWhereSortBy
    on QueryBuilder<WidgetsForField, WidgetsForField, QSortBy> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByFieldValue() {
    return addSortByInternal('fieldValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByFieldValueDesc() {
    return addSortByInternal('fieldValue', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByWidgetValue() {
    return addSortByInternal('widgetValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      sortByWidgetValueDesc() {
    return addSortByInternal('widgetValue', Sort.desc);
  }
}

extension WidgetsForFieldQueryWhereSortThenBy
    on QueryBuilder<WidgetsForField, WidgetsForField, QSortThenBy> {
  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByFieldValue() {
    return addSortByInternal('fieldValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByFieldValueDesc() {
    return addSortByInternal('fieldValue', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByWidgetValue() {
    return addSortByInternal('widgetValue', Sort.asc);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QAfterSortBy>
      thenByWidgetValueDesc() {
    return addSortByInternal('widgetValue', Sort.desc);
  }
}

extension WidgetsForFieldQueryWhereDistinct
    on QueryBuilder<WidgetsForField, WidgetsForField, QDistinct> {
  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByFieldValue({bool caseSensitive = true}) {
    return addDistinctByInternal('fieldValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<WidgetsForField, WidgetsForField, QDistinct>
      distinctByWidgetValue({bool caseSensitive = true}) {
    return addDistinctByInternal('widgetValue', caseSensitive: caseSensitive);
  }
}

extension WidgetsForFieldQueryProperty
    on QueryBuilder<WidgetsForField, WidgetsForField, QQueryProperty> {
  QueryBuilder<WidgetsForField, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<WidgetsForField, String?, QQueryOperations>
      fieldValueProperty() {
    return addPropertyName('fieldValue');
  }

  QueryBuilder<WidgetsForField, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<WidgetsForField, DateTime?, QQueryOperations>
      serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<WidgetsForField, String?, QQueryOperations>
      widgetValueProperty() {
    return addPropertyName('widgetValue');
  }
}
