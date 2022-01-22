// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetFieldCollection on Isar {
  IsarCollection<Field> get fields {
    return getCollection('Field');
  }
}

final FieldSchema = CollectionSchema(
  name: 'Field',
  schema:
      '{"name":"Field","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Byte"},{"name":"fieldType","type":"String"},{"name":"id","type":"String"},{"name":"isInternalId","type":"Byte"},{"name":"label","type":"String"},{"name":"lastValue","type":"String"},{"name":"name","type":"String"},{"name":"optionsTable","type":"String"},{"name":"ord","type":"Long"},{"name":"serverRevAt","type":"Long"},{"name":"standardValue","type":"String"},{"name":"tableId","type":"String"},{"name":"widgetType","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"name_tableId","unique":false,"properties":[{"name":"name","type":"Hash","caseSensitive":true},{"name":"tableId","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"tableId","unique":false,"properties":[{"name":"tableId","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _FieldAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'deleted': 2,
    'fieldType': 3,
    'id': 4,
    'isInternalId': 5,
    'label': 6,
    'lastValue': 7,
    'name': 8,
    'optionsTable': 9,
    'ord': 10,
    'serverRevAt': 11,
    'standardValue': 12,
    'tableId': 13,
    'widgetType': 14
  },
  indexIds: {
    'deleted': 0,
    'id': 1,
    'name_tableId': 2,
    'ord': 3,
    'serverRevAt': 4,
    'tableId': 5
  },
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'name_tableId': [
      NativeIndexType.stringHash,
      NativeIndexType.stringHash,
    ],
    'ord': [
      NativeIndexType.long,
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

class _FieldAdapter extends IsarTypeAdapter<Field> {
  const _FieldAdapter();

  @override
  int serialize(IsarCollection<Field> collection, IsarRawObject rawObj,
      Field object, List<int> offsets,
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
    final value2 = object.deleted;
    final _deleted = value2;
    final value3 = object.fieldType;
    IsarUint8List? _fieldType;
    if (value3 != null) {
      _fieldType = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _fieldType?.length ?? 0;
    final value4 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += _id.length;
    final value5 = object.isInternalId;
    final _isInternalId = value5;
    final value6 = object.label;
    IsarUint8List? _label;
    if (value6 != null) {
      _label = BinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += _label?.length ?? 0;
    final value7 = object.lastValue;
    IsarUint8List? _lastValue;
    if (value7 != null) {
      _lastValue = BinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += _lastValue?.length ?? 0;
    final value8 = object.name;
    IsarUint8List? _name;
    if (value8 != null) {
      _name = BinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += _name?.length ?? 0;
    final value9 = object.optionsTable;
    IsarUint8List? _optionsTable;
    if (value9 != null) {
      _optionsTable = BinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += _optionsTable?.length ?? 0;
    final value10 = object.ord;
    final _ord = value10;
    final value11 = object.serverRevAt;
    final _serverRevAt = value11;
    final value12 = object.standardValue;
    IsarUint8List? _standardValue;
    if (value12 != null) {
      _standardValue = BinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += _standardValue?.length ?? 0;
    final value13 = object.tableId;
    IsarUint8List? _tableId;
    if (value13 != null) {
      _tableId = BinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += _tableId?.length ?? 0;
    final value14 = object.widgetType;
    IsarUint8List? _widgetType;
    if (value14 != null) {
      _widgetType = BinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += _widgetType?.length ?? 0;
    final size = dynamicSize + 108;

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
    final writer = BinaryWriter(buffer, 108);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeBool(offsets[2], _deleted);
    writer.writeBytes(offsets[3], _fieldType);
    writer.writeBytes(offsets[4], _id);
    writer.writeBool(offsets[5], _isInternalId);
    writer.writeBytes(offsets[6], _label);
    writer.writeBytes(offsets[7], _lastValue);
    writer.writeBytes(offsets[8], _name);
    writer.writeBytes(offsets[9], _optionsTable);
    writer.writeLong(offsets[10], _ord);
    writer.writeDateTime(offsets[11], _serverRevAt);
    writer.writeBytes(offsets[12], _standardValue);
    writer.writeBytes(offsets[13], _tableId);
    writer.writeBytes(offsets[14], _widgetType);
    return bufferSize;
  }

  @override
  Field deserialize(IsarCollection<Field> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Field(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      fieldType: reader.readStringOrNull(offsets[3]),
      isInternalId: reader.readBoolOrNull(offsets[5]),
      label: reader.readStringOrNull(offsets[6]),
      lastValue: reader.readStringOrNull(offsets[7]),
      name: reader.readStringOrNull(offsets[8]),
      optionsTable: reader.readStringOrNull(offsets[9]),
      ord: reader.readLongOrNull(offsets[10]),
      serverRevAt: reader.readDateTimeOrNull(offsets[11]),
      standardValue: reader.readStringOrNull(offsets[12]),
      tableId: reader.readStringOrNull(offsets[13]),
      widgetType: reader.readStringOrNull(offsets[14]),
    );
    object.deleted = reader.readBool(offsets[2]);
    object.id = reader.readString(offsets[4]);
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
        return (reader.readBool(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
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
        return (reader.readLongOrNull(offset)) as P;
      case 11:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension FieldQueryWhereSort on QueryBuilder<Field, Field, QWhere> {
  QueryBuilder<Field, Field, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyNameTableId() {
    return addWhereClause(const WhereClause(indexName: 'name_tableId'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyOrd() {
    return addWhereClause(const WhereClause(indexName: 'ord'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyTableId() {
    return addWhereClause(const WhereClause(indexName: 'tableId'));
  }
}

extension FieldQueryWhere on QueryBuilder<Field, Field, QWhereClause> {
  QueryBuilder<Field, Field, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
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

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdBetween(
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
    return addWhereClause(const WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordGreaterThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordLessThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordBetween(
    int? lowerOrd,
    int? upperOrd, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [lowerOrd],
      includeLower: includeLower,
      upper: [upperOrd],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtBetween(
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
    return addWhereClause(const WhereClause(
      indexName: 'tableId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'tableId',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension FieldQueryFilter on QueryBuilder<Field, Field, QFilterCondition> {
  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fieldType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> isInternalIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isInternalId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isInternalIdEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isInternalId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdBetween(
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'label',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'lastValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'optionsTable',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Field, Field, QAfterFilterCondition> ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
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
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtBetween(
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'standardValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdLessThan(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdBetween(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdStartsWith(
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

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdEndsWith(
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'widgetType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
}

extension FieldQueryWhereSortBy on QueryBuilder<Field, Field, QSortBy> {
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

  QueryBuilder<Field, Field, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByFieldType() {
    return addSortByInternal('fieldType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLastValue() {
    return addSortByInternal('lastValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByStandardValue() {
    return addSortByInternal('standardValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByWidgetType() {
    return addSortByInternal('widgetType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.desc);
  }
}

extension FieldQueryWhereSortThenBy on QueryBuilder<Field, Field, QSortThenBy> {
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

  QueryBuilder<Field, Field, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByFieldType() {
    return addSortByInternal('fieldType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLastValue() {
    return addSortByInternal('lastValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByStandardValue() {
    return addSortByInternal('standardValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByWidgetType() {
    return addSortByInternal('widgetType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.desc);
  }
}

extension FieldQueryWhereDistinct on QueryBuilder<Field, Field, QDistinct> {
  QueryBuilder<Field, Field, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByFieldType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByIsInternalId() {
    return addDistinctByInternal('isInternalId');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByLastValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('lastValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByOptionsTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionsTable', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByStandardValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('standardValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByTableId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tableId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByWidgetType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('widgetType', caseSensitive: caseSensitive);
  }
}

extension FieldQueryProperty on QueryBuilder<Field, Field, QQueryProperty> {
  QueryBuilder<Field, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Field, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Field, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<Field, String?, QQueryOperations> fieldTypeProperty() {
    return addPropertyName('fieldType');
  }

  QueryBuilder<Field, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Field, bool?, QQueryOperations> isInternalIdProperty() {
    return addPropertyName('isInternalId');
  }

  QueryBuilder<Field, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Field, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<Field, String?, QQueryOperations> lastValueProperty() {
    return addPropertyName('lastValue');
  }

  QueryBuilder<Field, String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<Field, String?, QQueryOperations> optionsTableProperty() {
    return addPropertyName('optionsTable');
  }

  QueryBuilder<Field, int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
  }

  QueryBuilder<Field, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Field, String?, QQueryOperations> standardValueProperty() {
    return addPropertyName('standardValue');
  }

  QueryBuilder<Field, String?, QQueryOperations> tableIdProperty() {
    return addPropertyName('tableId');
  }

  QueryBuilder<Field, String?, QQueryOperations> widgetTypeProperty() {
    return addPropertyName('widgetType');
  }
}
