// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optionType.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetOptionTypeCollection on Isar {
  IsarCollection<OptionType> get optionTypes {
    return getCollection('OptionType');
  }
}

final OptionTypeSchema = CollectionSchema(
  name: 'OptionType',
  schema:
      '{"name":"OptionType","properties":[{"name":"comment","type":"String"},{"name":"deleted","type":"Byte"},{"name":"id","type":"String"},{"name":"saveId","type":"Byte"},{"name":"serverRevAt","type":"Long"},{"name":"sort","type":"Long"},{"name":"value","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"sort","unique":false,"properties":[{"name":"sort","type":"Value","caseSensitive":false}]},{"name":"value","unique":false,"properties":[{"name":"value","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _OptionTypeAdapter(),
  idName: 'isarId',
  propertyIds: {
    'comment': 0,
    'deleted': 1,
    'id': 2,
    'saveId': 3,
    'serverRevAt': 4,
    'sort': 5,
    'value': 6
  },
  indexIds: {'deleted': 0, 'id': 1, 'serverRevAt': 2, 'sort': 3, 'value': 4},
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

class _OptionTypeAdapter extends IsarTypeAdapter<OptionType> {
  const _OptionTypeAdapter();

  @override
  int serialize(IsarCollection<OptionType> collection, IsarRawObject rawObj,
      OptionType object, List<int> offsets,
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
    final value2 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += _id.length;
    final value3 = object.saveId;
    final _saveId = value3;
    final value4 = object.serverRevAt;
    final _serverRevAt = value4;
    final value5 = object.sort;
    final _sort = value5;
    final value6 = object.value;
    IsarUint8List? _value;
    if (value6 != null) {
      _value = BinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += _value?.length ?? 0;
    final size = dynamicSize + 44;

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
    final writer = BinaryWriter(buffer, 44);
    writer.writeBytes(offsets[0], _comment);
    writer.writeBool(offsets[1], _deleted);
    writer.writeBytes(offsets[2], _id);
    writer.writeBool(offsets[3], _saveId);
    writer.writeDateTime(offsets[4], _serverRevAt);
    writer.writeLong(offsets[5], _sort);
    writer.writeBytes(offsets[6], _value);
    return bufferSize;
  }

  @override
  OptionType deserialize(IsarCollection<OptionType> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = OptionType(
      comment: reader.readStringOrNull(offsets[0]),
      saveId: reader.readBoolOrNull(offsets[3]),
      serverRevAt: reader.readDateTimeOrNull(offsets[4]),
      sort: reader.readLongOrNull(offsets[5]),
      value: reader.readStringOrNull(offsets[6]),
    );
    object.deleted = reader.readBool(offsets[1]);
    object.id = reader.readString(offsets[2]);
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
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readBoolOrNull(offset)) as P;
      case 4:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 5:
        return (reader.readLongOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension OptionTypeQueryWhereSort
    on QueryBuilder<OptionType, OptionType, QWhere> {
  QueryBuilder<OptionType, OptionType, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anySort() {
    return addWhereClause(const WhereClause(indexName: 'sort'));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhere> anyValue() {
    return addWhereClause(const WhereClause(indexName: 'value'));
  }
}

extension OptionTypeQueryWhere
    on QueryBuilder<OptionType, OptionType, QWhereClause> {
  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause>
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

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> serverRevAtBetween(
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
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortGreaterThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: include,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortLessThan(
    int? sort, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: include,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> sortBetween(
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
    return addWhereClause(const WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension OptionTypeQueryFilter
    on QueryBuilder<OptionType, OptionType, QFilterCondition> {
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentStartsWith(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> commentEndsWith(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> saveIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'saveId',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> saveIdEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'saveId',
      value: value,
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
      serverRevAtEqualTo(DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition>
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortGreaterThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> sortBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueBetween(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueStartsWith(
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

  QueryBuilder<OptionType, OptionType, QAfterFilterCondition> valueEndsWith(
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
}

extension OptionTypeQueryWhereSortBy
    on QueryBuilder<OptionType, OptionType, QSortBy> {
  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySaveId() {
    return addSortByInternal('saveId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySaveIdDesc() {
    return addSortByInternal('saveId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension OptionTypeQueryWhereSortThenBy
    on QueryBuilder<OptionType, OptionType, QSortThenBy> {
  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySaveId() {
    return addSortByInternal('saveId', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySaveIdDesc() {
    return addSortByInternal('saveId', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.desc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.asc);
  }

  QueryBuilder<OptionType, OptionType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.desc);
  }
}

extension OptionTypeQueryWhereDistinct
    on QueryBuilder<OptionType, OptionType, QDistinct> {
  QueryBuilder<OptionType, OptionType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctBySaveId() {
    return addDistinctByInternal('saveId');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<OptionType, OptionType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }
}

extension OptionTypeQueryProperty
    on QueryBuilder<OptionType, OptionType, QQueryProperty> {
  QueryBuilder<OptionType, String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<OptionType, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<OptionType, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<OptionType, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<OptionType, bool?, QQueryOperations> saveIdProperty() {
    return addPropertyName('saveId');
  }

  QueryBuilder<OptionType, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<OptionType, int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<OptionType, String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }
}
