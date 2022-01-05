// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetProjectCollection on Isar {
  IsarCollection<Project> get projects {
    return getCollection('Project');
  }
}

final ProjectSchema = CollectionSchema(
  name: 'Project',
  schema:
      '{"name":"Project","properties":[{"name":"id","type":"String"},{"name":"name","type":"String"},{"name":"accountId","type":"String"},{"name":"label","type":"String"},{"name":"crs","type":"Long"},{"name":"clientRevAt","type":"String"},{"name":"clientRevBy","type":"String"},{"name":"serverRevAt","type":"String"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"accountId","unique":false,"properties":[{"name":"accountId","type":"Hash","caseSensitive":true}]},{"name":"label","unique":false,"properties":[{"name":"label","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Hash","caseSensitive":true}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _ProjectAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'name': 1,
    'accountId': 2,
    'label': 3,
    'crs': 4,
    'clientRevAt': 5,
    'clientRevBy': 6,
    'serverRevAt': 7,
    'deleted': 8
  },
  indexIds: {
    'id': 0,
    'accountId': 1,
    'label': 2,
    'serverRevAt': 3,
    'deleted': 4
  },
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
    'accountId': [
      NativeIndexType.stringHash,
    ],
    'label': [
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

class _ProjectAdapter extends IsarTypeAdapter<Project> {
  const _ProjectAdapter();

  @override
  int serialize(IsarCollection<Project> collection, RawObject rawObj,
      Project object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += _id.length;
    final value1 = object.name;
    Uint8List? _name;
    if (value1 != null) {
      _name = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _name?.length ?? 0;
    final value2 = object.accountId;
    Uint8List? _accountId;
    if (value2 != null) {
      _accountId = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _accountId?.length ?? 0;
    final value3 = object.label;
    Uint8List? _label;
    if (value3 != null) {
      _label = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _label?.length ?? 0;
    final value4 = object.crs;
    final _crs = value4;
    final value5 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value5 != null) {
      _clientRevAt = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value6 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value6 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value7 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value7 != null) {
      _serverRevAt = BinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value8 = object.deleted;
    final _deleted = value8;
    final size = dynamicSize + 75;

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
    final writer = BinaryWriter(buffer, 75);
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _name);
    writer.writeBytes(offsets[2], _accountId);
    writer.writeBytes(offsets[3], _label);
    writer.writeLong(offsets[4], _crs);
    writer.writeBytes(offsets[5], _clientRevAt);
    writer.writeBytes(offsets[6], _clientRevBy);
    writer.writeBytes(offsets[7], _serverRevAt);
    writer.writeBool(offsets[8], _deleted);
    return bufferSize;
  }

  @override
  Project deserialize(IsarCollection<Project> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Project(
      name: reader.readStringOrNull(offsets[1]),
      accountId: reader.readStringOrNull(offsets[2]),
      label: reader.readStringOrNull(offsets[3]),
      crs: reader.readLongOrNull(offsets[4]),
      clientRevAt: reader.readStringOrNull(offsets[5]),
      clientRevBy: reader.readStringOrNull(offsets[6]),
      serverRevAt: reader.readStringOrNull(offsets[7]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[8]);
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
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension ProjectQueryWhereSort on QueryBuilder<Project, Project, QWhere> {
  QueryBuilder<Project, Project, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<Project, Project, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<Project, Project, QAfterWhere> anyAccountId() {
    return addWhereClause(WhereClause(indexName: 'accountId'));
  }

  QueryBuilder<Project, Project, QAfterWhere> anyLabel() {
    return addWhereClause(WhereClause(indexName: 'label'));
  }

  QueryBuilder<Project, Project, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Project, Project, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension ProjectQueryWhere on QueryBuilder<Project, Project, QWhereClause> {
  QueryBuilder<Project, Project, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<Project, Project, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Project, Project, QAfterWhereClause> accountIdEqualTo(
      String? accountId) {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      lower: [accountId],
      includeLower: true,
      upper: [accountId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> accountIdNotEqualTo(
      String? accountId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'accountId',
        upper: [accountId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'accountId',
        lower: [accountId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'accountId',
        lower: [accountId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'accountId',
        upper: [accountId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Project, Project, QAfterWhereClause> accountIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> accountIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> labelEqualTo(
      String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [label],
      includeLower: true,
      upper: [label],
      includeUpper: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> labelNotEqualTo(
      String? label) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'label',
        upper: [label],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'label',
        lower: [label],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'label',
        lower: [label],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'label',
        upper: [label],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Project, Project, QAfterWhereClause> labelIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> labelIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Project, Project, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Project, Project, QAfterWhereClause> deletedNotEqualTo(
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

extension ProjectQueryFilter
    on QueryBuilder<Project, Project, QFilterCondition> {
  QueryBuilder<Project, Project, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> idStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> nameStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> nameEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'accountId',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'accountId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> accountIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'accountId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelEqualTo(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> labelGreaterThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> labelLessThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> labelBetween(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> labelStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> crsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'crs',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> crsEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'crs',
      value: value,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> crsGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'crs',
      value: value,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> crsLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'crs',
      value: value,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> crsBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'crs',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtEqualTo(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtEqualTo(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension ProjectQueryWhereSortBy on QueryBuilder<Project, Project, QSortBy> {
  QueryBuilder<Project, Project, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByAccountId() {
    return addSortByInternal('accountId', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByCrs() {
    return addSortByInternal('crs', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByCrsDesc() {
    return addSortByInternal('crs', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension ProjectQueryWhereSortThenBy
    on QueryBuilder<Project, Project, QSortThenBy> {
  QueryBuilder<Project, Project, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByAccountId() {
    return addSortByInternal('accountId', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByCrs() {
    return addSortByInternal('crs', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByCrsDesc() {
    return addSortByInternal('crs', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension ProjectQueryWhereDistinct
    on QueryBuilder<Project, Project, QDistinct> {
  QueryBuilder<Project, Project, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Project, Project, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByAccountId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('accountId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByCrs() {
    return addDistinctByInternal('crs');
  }

  QueryBuilder<Project, Project, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, Project, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension ProjectQueryProperty
    on QueryBuilder<Project, Project, QQueryProperty> {
  QueryBuilder<Project, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Project, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Project, String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<Project, String?, QQueryOperations> accountIdProperty() {
    return addPropertyName('accountId');
  }

  QueryBuilder<Project, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<Project, int?, QQueryOperations> crsProperty() {
    return addPropertyName('crs');
  }

  QueryBuilder<Project, String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Project, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Project, String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Project, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
