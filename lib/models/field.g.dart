// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetFieldCollection on Isar {
  IsarCollection<Field> get fields {
    return getCollection('Field');
  }
}

final FieldSchema = CollectionSchema(
  name: 'Field',
  schema:
      '{"name":"Field","properties":[{"name":"id","type":"String"},{"name":"tableId","type":"String"},{"name":"name","type":"String"},{"name":"label","type":"String"},{"name":"ord","type":"Long"},{"name":"isInternalId","type":"Byte"},{"name":"fieldType","type":"String"},{"name":"widgetType","type":"String"},{"name":"optionsTable","type":"String"},{"name":"standardValue","type":"String"},{"name":"lastValue","type":"String"},{"name":"clientRevAt","type":"String"},{"name":"clientRevBy","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"tableId","unique":false,"properties":[{"name":"tableId","type":"Hash","caseSensitive":true}]},{"name":"name_tableId","unique":false,"properties":[{"name":"name","type":"Hash","caseSensitive":true},{"name":"tableId","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _FieldAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'tableId': 1,
    'name': 2,
    'label': 3,
    'ord': 4,
    'isInternalId': 5,
    'fieldType': 6,
    'widgetType': 7,
    'optionsTable': 8,
    'standardValue': 9,
    'lastValue': 10,
    'clientRevAt': 11,
    'clientRevBy': 12,
    'serverRevAt': 13,
    'deleted': 14
  },
  indexIds: {
    'id': 0,
    'tableId': 1,
    'name': 2,
    'ord': 3,
    'serverRevAt': 4,
    'deleted': 5
  },
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
    'tableId': [
      NativeIndexType.stringHash,
    ],
    'name': [
      NativeIndexType.stringHash,
      NativeIndexType.stringHash,
    ],
    'ord': [
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

class _FieldAdapter extends IsarTypeAdapter<Field> {
  const _FieldAdapter();

  @override
  int serialize(IsarCollection<Field> collection, RawObject rawObj,
      Field object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += _id.length;
    final value1 = object.tableId;
    Uint8List? _tableId;
    if (value1 != null) {
      _tableId = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _tableId?.length ?? 0;
    final value2 = object.name;
    Uint8List? _name;
    if (value2 != null) {
      _name = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _name?.length ?? 0;
    final value3 = object.label;
    Uint8List? _label;
    if (value3 != null) {
      _label = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _label?.length ?? 0;
    final value4 = object.ord;
    final _ord = value4;
    final value5 = object.isInternalId;
    final _isInternalId = value5;
    final value6 = object.fieldType;
    Uint8List? _fieldType;
    if (value6 != null) {
      _fieldType = BinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += _fieldType?.length ?? 0;
    final value7 = object.widgetType;
    Uint8List? _widgetType;
    if (value7 != null) {
      _widgetType = BinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += _widgetType?.length ?? 0;
    final value8 = object.optionsTable;
    Uint8List? _optionsTable;
    if (value8 != null) {
      _optionsTable = BinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += _optionsTable?.length ?? 0;
    final value9 = object.standardValue;
    Uint8List? _standardValue;
    if (value9 != null) {
      _standardValue = BinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += _standardValue?.length ?? 0;
    final value10 = object.lastValue;
    Uint8List? _lastValue;
    if (value10 != null) {
      _lastValue = BinaryWriter.utf8Encoder.convert(value10);
    }
    dynamicSize += _lastValue?.length ?? 0;
    final value11 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value11 != null) {
      _clientRevAt = BinaryWriter.utf8Encoder.convert(value11);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value12 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value12 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value13 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value13 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value14 = object.deleted;
    final _deleted = value14;
    final size = dynamicSize + 116;

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
    final writer = BinaryWriter(buffer, 116);
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _tableId);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _label);
    writer.writeLong(offsets[4], _ord);
    writer.writeBool(offsets[5], _isInternalId);
    writer.writeBytes(offsets[6], _fieldType);
    writer.writeBytes(offsets[7], _widgetType);
    writer.writeBytes(offsets[8], _optionsTable);
    writer.writeBytes(offsets[9], _standardValue);
    writer.writeBytes(offsets[10], _lastValue);
    writer.writeBytes(offsets[11], _clientRevAt);
    writer.writeBytes(offsets[12], _clientRevBy);
    writer.writeBytes(offsets[13], _serverRevAt);
    writer.writeBool(offsets[14], _deleted);
    return bufferSize;
  }

  @override
  Field deserialize(IsarCollection<Field> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Field(
      tableId: reader.readStringOrNull(offsets[1]),
      name: reader.readStringOrNull(offsets[2]),
      label: reader.readStringOrNull(offsets[3]),
      ord: reader.readLongOrNull(offsets[4]),
      isInternalId: reader.readBoolOrNull(offsets[5]),
      fieldType: reader.readStringOrNull(offsets[6]),
      widgetType: reader.readStringOrNull(offsets[7]),
      optionsTable: reader.readStringOrNull(offsets[8]),
      standardValue: reader.readStringOrNull(offsets[9]),
      lastValue: reader.readStringOrNull(offsets[10]),
      clientRevAt: reader.readStringOrNull(offsets[11]),
      clientRevBy: reader.readStringOrNull(offsets[12]),
      serverRevAt: reader.readStringOrNull(offsets[13]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[14]);
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
        return (reader.readLongOrNull(offset)) as P;
      case 5:
        return (reader.readBoolOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension FieldQueryWhereSort on QueryBuilder<Field, Field, QWhere> {
  QueryBuilder<Field, Field, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyTableId() {
    return addWhereClause(WhereClause(indexName: 'tableId'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyNameTableId() {
    return addWhereClause(WhereClause(indexName: 'name_tableId'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyOrd() {
    return addWhereClause(WhereClause(indexName: 'ord'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension FieldQueryWhere on QueryBuilder<Field, Field, QWhereClause> {
  QueryBuilder<Field, Field, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
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

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdEqualTo(
      String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [tableId],
      includeLower: true,
      upper: [tableId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdNotEqualTo(
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

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name_tableId',
      lower: [name],
      includeLower: true,
      upper: [name],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameNotEqualTo(String? name) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'name_tableId',
        upper: [name],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_tableId',
        lower: [name],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'name_tableId',
        lower: [name],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_tableId',
        upper: [name],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameTableIdEqualTo(
      String? name, String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'name_tableId',
      lower: [name, tableId],
      includeLower: true,
      upper: [name, tableId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameTableIdNotEqualTo(
      String? name, String? tableId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'name_tableId',
        upper: [name, tableId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_tableId',
        lower: [name, tableId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'name_tableId',
        lower: [name, tableId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_tableId',
        upper: [name, tableId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: true,
      upper: [ord],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordNotEqualTo(int? ord) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordGreaterThan(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordLessThan(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordBetween(
      int? lowerOrd, int? upperOrd) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [lowerOrd],
      includeLower: true,
      upper: [upperOrd],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> deletedNotEqualTo(
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

extension FieldQueryFilter on QueryBuilder<Field, Field, QFilterCondition> {
  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'tableId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdEqualTo(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'tableId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'tableId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'name',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameStartsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'label',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isInternalIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isInternalId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isInternalIdEqualTo(
    bool? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isInternalId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'fieldType',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fieldType',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'fieldType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'widgetType',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'widgetType',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'widgetType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'optionsTable',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'optionsTable',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'optionsTable',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'standardValue',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'standardValue',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'standardValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'lastValue',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'lastValue',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'lastValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtEqualTo(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtEqualTo(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension FieldQueryWhereSortBy on QueryBuilder<Field, Field, QSortBy> {
  QueryBuilder<Field, Field, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByFieldType() {
    return addSortByInternal('fieldType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByWidgetType() {
    return addSortByInternal('widgetType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByStandardValue() {
    return addSortByInternal('standardValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLastValue() {
    return addSortByInternal('lastValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension FieldQueryWhereSortThenBy on QueryBuilder<Field, Field, QSortThenBy> {
  QueryBuilder<Field, Field, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByFieldType() {
    return addSortByInternal('fieldType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByWidgetType() {
    return addSortByInternal('widgetType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByStandardValue() {
    return addSortByInternal('standardValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLastValue() {
    return addSortByInternal('lastValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension FieldQueryWhereDistinct on QueryBuilder<Field, Field, QDistinct> {
  QueryBuilder<Field, Field, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Field, Field, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByTableId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tableId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByIsInternalId() {
    return addDistinctByInternal('isInternalId');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByFieldType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByWidgetType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('widgetType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByOptionsTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionsTable', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByStandardValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('standardValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByLastValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('lastValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension FieldQueryProperty on QueryBuilder<Field, Field, QQueryProperty> {
  QueryBuilder<Field, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Field, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Field, String?, QQueryOperations> tableIdProperty() {
    return addPropertyName('tableId');
  }

  QueryBuilder<Field, String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<Field, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<Field, int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
  }

  QueryBuilder<Field, bool?, QQueryOperations> isInternalIdProperty() {
    return addPropertyName('isInternalId');
  }

  QueryBuilder<Field, String?, QQueryOperations> fieldTypeProperty() {
    return addPropertyName('fieldType');
  }

  QueryBuilder<Field, String?, QQueryOperations> widgetTypeProperty() {
    return addPropertyName('widgetType');
  }

  QueryBuilder<Field, String?, QQueryOperations> optionsTableProperty() {
    return addPropertyName('optionsTable');
  }

  QueryBuilder<Field, String?, QQueryOperations> standardValueProperty() {
    return addPropertyName('standardValue');
  }

  QueryBuilder<Field, String?, QQueryOperations> lastValueProperty() {
    return addPropertyName('lastValue');
  }

  QueryBuilder<Field, String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Field, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Field, String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Field, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
