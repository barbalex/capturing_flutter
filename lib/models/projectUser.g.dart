// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectUser.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetProjectUserCollection on Isar {
  IsarCollection<ProjectUser> get projectUsers {
    return getCollection('ProjectUser');
  }
}

final ProjectUserSchema = CollectionSchema(
  name: 'ProjectUser',
  schema:
      '{"name":"ProjectUser","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Byte"},{"name":"id","type":"String"},{"name":"projectId","type":"String"},{"name":"role","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"userEmail","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _ProjectUserAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'deleted': 2,
    'id': 3,
    'projectId': 4,
    'role': 5,
    'serverRevAt': 6,
    'userEmail': 7
  },
  indexIds: {'deleted': 0, 'id': 1, 'projectId': 2, 'serverRevAt': 3},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'projectId': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
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

class _ProjectUserAdapter extends IsarTypeAdapter<ProjectUser> {
  const _ProjectUserAdapter();

  @override
  int serialize(IsarCollection<ProjectUser> collection, IsarRawObject rawObj,
      ProjectUser object, List<int> offsets,
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
    final value3 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += _id.length;
    final value4 = object.projectId;
    IsarUint8List? _projectId;
    if (value4 != null) {
      _projectId = BinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value5 = object.role;
    IsarUint8List? _role;
    if (value5 != null) {
      _role = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _role?.length ?? 0;
    final value6 = object.serverRevAt;
    final _serverRevAt = value6;
    final value7 = object.userEmail;
    IsarUint8List? _userEmail;
    if (value7 != null) {
      _userEmail = BinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += _userEmail?.length ?? 0;
    final size = dynamicSize + 59;

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
    final writer = BinaryWriter(buffer, 59);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeBool(offsets[2], _deleted);
    writer.writeBytes(offsets[3], _id);
    writer.writeBytes(offsets[4], _projectId);
    writer.writeBytes(offsets[5], _role);
    writer.writeDateTime(offsets[6], _serverRevAt);
    writer.writeBytes(offsets[7], _userEmail);
    return bufferSize;
  }

  @override
  ProjectUser deserialize(IsarCollection<ProjectUser> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = ProjectUser(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      projectId: reader.readStringOrNull(offsets[4]),
      role: reader.readStringOrNull(offsets[5]),
      serverRevAt: reader.readDateTimeOrNull(offsets[6]),
      userEmail: reader.readStringOrNull(offsets[7]),
    );
    object.deleted = reader.readBool(offsets[2]);
    object.id = reader.readString(offsets[3]);
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
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension ProjectUserQueryWhereSort
    on QueryBuilder<ProjectUser, ProjectUser, QWhere> {
  QueryBuilder<ProjectUser, ProjectUser, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhere> anyProjectId() {
    return addWhereClause(const WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhere> anyServerRevAt() {
    return addWhereClause(const WhereClause(indexName: 'serverRevAt'));
  }
}

extension ProjectUserQueryWhere
    on QueryBuilder<ProjectUser, ProjectUser, QWhereClause> {
  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> isarIdEqualTo(
      int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> idEqualTo(
      String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [projectId],
      includeLower: true,
      upper: [projectId],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> projectIdNotEqualTo(
      String? projectId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause>
      projectIdIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause>
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause>
      serverRevAtIsNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause>
      serverRevAtIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause>
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> serverRevAtLessThan(
    DateTime? serverRevAt, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterWhereClause> serverRevAtBetween(
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
}

extension ProjectUserQueryFilter
    on QueryBuilder<ProjectUser, ProjectUser, QFilterCondition> {
  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevAtEqualTo(DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevAtGreaterThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevAtLessThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevAtBetween(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByEqualTo(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByGreaterThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByLessThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByBetween(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByStartsWith(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByEndsWith(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      clientRevByMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'projectId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      projectIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'role',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'role',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition> roleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'role',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      serverRevAtEqualTo(DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
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

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'userEmail',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'userEmail',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterFilterCondition>
      userEmailMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'userEmail',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ProjectUserQueryWhereSortBy
    on QueryBuilder<ProjectUser, ProjectUser, QSortBy> {
  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByRole() {
    return addSortByInternal('role', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByRoleDesc() {
    return addSortByInternal('role', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByUserEmail() {
    return addSortByInternal('userEmail', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> sortByUserEmailDesc() {
    return addSortByInternal('userEmail', Sort.desc);
  }
}

extension ProjectUserQueryWhereSortThenBy
    on QueryBuilder<ProjectUser, ProjectUser, QSortThenBy> {
  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByRole() {
    return addSortByInternal('role', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByRoleDesc() {
    return addSortByInternal('role', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByUserEmail() {
    return addSortByInternal('userEmail', Sort.asc);
  }

  QueryBuilder<ProjectUser, ProjectUser, QAfterSortBy> thenByUserEmailDesc() {
    return addSortByInternal('userEmail', Sort.desc);
  }
}

extension ProjectUserQueryWhereDistinct
    on QueryBuilder<ProjectUser, ProjectUser, QDistinct> {
  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByRole(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('role', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<ProjectUser, ProjectUser, QDistinct> distinctByUserEmail(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('userEmail', caseSensitive: caseSensitive);
  }
}

extension ProjectUserQueryProperty
    on QueryBuilder<ProjectUser, ProjectUser, QQueryProperty> {
  QueryBuilder<ProjectUser, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<ProjectUser, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<ProjectUser, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<ProjectUser, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<ProjectUser, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<ProjectUser, String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<ProjectUser, String?, QQueryOperations> roleProperty() {
    return addPropertyName('role');
  }

  QueryBuilder<ProjectUser, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<ProjectUser, String?, QQueryOperations> userEmailProperty() {
    return addPropertyName('userEmail');
  }
}
