// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetAccountCollection on Isar {
  IsarCollection<Account> get accounts {
    return getCollection('Account');
  }
}

final AccountSchema = CollectionSchema(
  name: 'Account',
  schema:
      '{"name":"Account","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Byte"},{"name":"id","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"serviceId","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]}],"links":[]}',
  adapter: const _AccountAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'deleted': 2,
    'id': 3,
    'serverRevAt': 4,
    'serviceId': 5
  },
  indexIds: {'deleted': 0, 'id': 1},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
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

class _AccountAdapter extends IsarTypeAdapter<Account> {
  const _AccountAdapter();

  @override
  int serialize(IsarCollection<Account> collection, IsarRawObject rawObj,
      Account object, List<int> offsets,
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
    final value4 = object.serverRevAt;
    final _serverRevAt = value4;
    final value5 = object.serviceId;
    IsarUint8List? _serviceId;
    if (value5 != null) {
      _serviceId = BinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += _serviceId?.length ?? 0;
    final size = dynamicSize + 43;

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
    final writer = BinaryWriter(buffer, 43);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeBool(offsets[2], _deleted);
    writer.writeBytes(offsets[3], _id);
    writer.writeDateTime(offsets[4], _serverRevAt);
    writer.writeBytes(offsets[5], _serviceId);
    return bufferSize;
  }

  @override
  Account deserialize(IsarCollection<Account> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Account(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      isarId: id,
      serverRevAt: reader.readDateTimeOrNull(offsets[4]),
    );
    object.deleted = reader.readBool(offsets[2]);
    object.id = reader.readString(offsets[3]);
    object.serviceId = reader.readStringOrNull(offsets[5]);
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
        return (reader.readDateTimeOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension AccountQueryWhereSort on QueryBuilder<Account, Account, QWhere> {
  QueryBuilder<Account, Account, QAfterWhere> anyIsarId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<Account, Account, QAfterWhere> anyDeleted() {
    return addWhereClause(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<Account, Account, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: 'id'));
  }
}

extension AccountQueryWhere on QueryBuilder<Account, Account, QWhereClause> {
  QueryBuilder<Account, Account, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Account, Account, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<Account, Account, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<Account, Account, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<Account, Account, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<Account, Account, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Account, Account, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<Account, Account, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idNotEqualTo(String id) {
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
}

extension AccountQueryFilter
    on QueryBuilder<Account, Account, QFilterCondition> {
  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serviceId',
      value: null,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'serviceId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> serviceIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'serviceId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension AccountQueryWhereSortBy on QueryBuilder<Account, Account, QSortBy> {
  QueryBuilder<Account, Account, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByServiceId() {
    return addSortByInternal('serviceId', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByServiceIdDesc() {
    return addSortByInternal('serviceId', Sort.desc);
  }
}

extension AccountQueryWhereSortThenBy
    on QueryBuilder<Account, Account, QSortThenBy> {
  QueryBuilder<Account, Account, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByServiceId() {
    return addSortByInternal('serviceId', Sort.asc);
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByServiceIdDesc() {
    return addSortByInternal('serviceId', Sort.desc);
  }
}

extension AccountQueryWhereDistinct
    on QueryBuilder<Account, Account, QDistinct> {
  QueryBuilder<Account, Account, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Account, Account, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, Account, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Account, Account, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Account, Account, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Account, Account, QDistinct> distinctByServiceId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serviceId', caseSensitive: caseSensitive);
  }
}

extension AccountQueryProperty
    on QueryBuilder<Account, Account, QQueryProperty> {
  QueryBuilder<Account, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Account, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Account, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }

  QueryBuilder<Account, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Account, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Account, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Account, String?, QQueryOperations> serviceIdProperty() {
    return addPropertyName('serviceId');
  }
}
