// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optionType.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetOptionTypeCollection on Isar {
  IsarCollection<OptionType> get optionTypes {
    return getCollection('OptionType');
  }
}

final OptionTypeSchema = CollectionSchema(
  name: 'OptionType',
  schema:
      '{"name":"OptionType","properties":[{"name":"id","type":"String"},{"name":"value","type":"String"},{"name":"saveId","type":"Byte"},{"name":"sort","type":"Long"},{"name":"comment","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"value","unique":false,"properties":[{"name":"value","type":"Hash","caseSensitive":true}]},{"name":"sort","unique":false,"properties":[{"name":"sort","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _OptionTypeAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'value': 1,
    'saveId': 2,
    'sort': 3,
    'comment': 4,
    'serverRevAt': 5,
    'deleted': 6
  },
  indexIds: {'id': 0, 'value': 1, 'sort': 2, 'serverRevAt': 3, 'deleted': 4},
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
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

class _OptionTypeAdapter extends IsarTypeAdapter<OptionType> {
  const _OptionTypeAdapter();

  @override
  int serialize(IsarCollection<OptionType> collection, RawObject rawObj,
      OptionType object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += _id.length;
    final value1 = object.value;
    Uint8List? _value;
    if (value1 != null) {
      _value = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _value?.length ?? 0;
    final value2 = object.saveId;
    final _saveId = value2;
    final value3 = object.sort;
    final _sort = value3;
    final value4 = object.comment;
    Uint8List? _comment;
    if (value4 != null) {
      _comment = BinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += _comment?.length ?? 0;
    final value5 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value5 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value6 = object.deleted;
    final _deleted = value6;
    final size = dynamicSize + 52;

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
    final writer = BinaryWriter(buffer, 52);
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _value);
    writer.writeBool(offsets[2], _saveId);
    writer.writeLong(offsets[3], _sort);
    writer.writeBytes(offsets[4], _comment);
    writer.writeBytes(offsets[5], _serverRevAt);
    writer.writeBool(offsets[6], _deleted);
    return bufferSize;
  }

  @override
  OptionType deserialize(IsarCollection<OptionType> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = OptionType(
      value: reader.readStringOrNull(offsets[1]),
      saveId: reader.readBoolOrNull(offsets[2]),
      sort: reader.readLongOrNull(offsets[3]),
      comment: reader.readStringOrNull(offsets[4]),
      serverRevAt: reader.readStringOrNull(offsets[5]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[6]);
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
        return (reader.readBoolOrNull(offset)) as P;
      case 3:
        return (reader.readLongOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension OptionTypeQueryWhereSort
    on QueryBuilder<OptionType, OptionType, QWhere> {
  QueryBuilder<OptionType, OptionType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyValue() {
    return addWhereClause(WhereClause(indexName: 'value'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension OptionTypeQueryWhere
    on QueryBuilder<OptionType, OptionType, QWhereClause> {
  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> idNotEqualTo(
      String id) {
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> valueEqualTo(
      String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: true,
      upper: [value],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> valueNotEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortEqualTo(
      int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: true,
      upper: [sort],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortNotEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortGreaterThan(
      int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortLessThan(
      int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortBetween(
      int? lowerSort, int? upperSort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [lowerSort],
      includeLower: true,
      upper: [upperSort],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> deletedNotEqualTo(
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

extension OptionTypeQueryFilter
    on QueryBuilder<OptionType, OptionType, QFilterCondition> {
  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueGreaterThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> saveIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'saveId',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> saveIdEqualTo(
    bool? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'saveId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
      commentGreaterThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
      serverRevAtStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
      serverRevAtEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
      serverRevAtContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
      serverRevAtMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension OptionTypeQueryWhereSortBy
    on QueryBuilder<OptionType, OptionType, QSortBy> {
  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySaveId() {
    return addSortByInternal('saveId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySaveIdDesc() {
    return addSortByInternal('saveId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension OptionTypeQueryWhereSortThenBy
    on QueryBuilder<OptionType, OptionType, QSortThenBy> {
  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySaveId() {
    return addSortByInternal('saveId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySaveIdDesc() {
    return addSortByInternal('saveId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension OptionTypeQueryWhereDistinct
    on QueryBuilder<OptionType, OptionType, QDistinct> {
  QueryBuilder<OptionType, OptionType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctBySaveId() {
    return addDistinctByInternal('saveId');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension OptionTypeQueryProperty
    on QueryBuilder<OptionType, OptionType, QQueryProperty> {
  QueryBuilder<OptionType, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<OptionType, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<OptionType, String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }

  QueryBuilder<OptionType, bool?, QQueryOperations> saveIdProperty() {
    return addPropertyName('saveId');
  }

  QueryBuilder<OptionType, int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<OptionType, String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<OptionType, String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<OptionType, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
