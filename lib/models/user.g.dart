// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetCUserCollection on Isar {
  IsarCollection<CUser> get cUsers {
    return getCollection('CUser');
  }
}

final CUserSchema = CollectionSchema(
  name: 'CUser',
  schema:
      '{"name":"CUser","idName":"isarId","properties":[{"name":"accountId","type":"String"},{"name":"authId","type":"String"},{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Bool"},{"name":"email","type":"String"},{"name":"id","type":"String"},{"name":"name","type":"String"},{"name":"serverRevAt","type":"Long"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"email","unique":true,"properties":[{"name":"email","type":"Hash","caseSensitive":true}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"name","unique":true,"properties":[{"name":"name","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  nativeAdapter: const _CUserNativeAdapter(),
  webAdapter: const _CUserWebAdapter(),
  idName: 'isarId',
  propertyIds: {
    'accountId': 0,
    'authId': 1,
    'clientRevAt': 2,
    'clientRevBy': 3,
    'deleted': 4,
    'email': 5,
    'id': 6,
    'name': 7,
    'serverRevAt': 8
  },
  listProperties: {},
  indexIds: {'deleted': 0, 'email': 1, 'id': 2, 'name': 3, 'serverRevAt': 4},
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'email': [
      NativeIndexType.stringHash,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'name': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.isarId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.isarId;
    }
  },
  setId: (obj, id) => obj.isarId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _CUserWebAdapter extends IsarWebTypeAdapter<CUser> {
  const _CUserWebAdapter();

  @override
  Object serialize(IsarCollection<CUser> collection, CUser object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'accountId', object.accountId);
    IsarNative.jsObjectSet(jsObj, 'authId', object.authId);
    IsarNative.jsObjectSet(jsObj, 'clientRevAt',
        object.clientRevAt?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'clientRevBy', object.clientRevBy);
    IsarNative.jsObjectSet(jsObj, 'deleted', object.deleted);
    IsarNative.jsObjectSet(jsObj, 'email', object.email);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
    IsarNative.jsObjectSet(jsObj, 'name', object.name);
    IsarNative.jsObjectSet(jsObj, 'serverRevAt',
        object.serverRevAt.toUtc().millisecondsSinceEpoch);
    return jsObj;
  }

  @override
  CUser deserialize(IsarCollection<CUser> collection, dynamic jsObj) {
    final object = CUser(
      accountId: IsarNative.jsObjectGet(jsObj, 'accountId'),
      authId: IsarNative.jsObjectGet(jsObj, 'authId'),
      clientRevAt: IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                  isUtc: true)
              .toLocal()
          : null,
      clientRevBy: IsarNative.jsObjectGet(jsObj, 'clientRevBy'),
      email: IsarNative.jsObjectGet(jsObj, 'email'),
      name: IsarNative.jsObjectGet(jsObj, 'name'),
    );
    object.deleted = IsarNative.jsObjectGet(jsObj, 'deleted') ?? false;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? '';
    object.isarId = IsarNative.jsObjectGet(jsObj, 'isarId');
    object.serverRevAt = IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'accountId':
        return (IsarNative.jsObjectGet(jsObj, 'accountId')) as P;
      case 'authId':
        return (IsarNative.jsObjectGet(jsObj, 'authId')) as P;
      case 'clientRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                    isUtc: true)
                .toLocal()
            : null) as P;
      case 'clientRevBy':
        return (IsarNative.jsObjectGet(jsObj, 'clientRevBy')) as P;
      case 'deleted':
        return (IsarNative.jsObjectGet(jsObj, 'deleted') ?? false) as P;
      case 'email':
        return (IsarNative.jsObjectGet(jsObj, 'email')) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
      case 'isarId':
        return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
      case 'name':
        return (IsarNative.jsObjectGet(jsObj, 'name')) as P;
      case 'serverRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, CUser object) {}
}

class _CUserNativeAdapter extends IsarNativeTypeAdapter<CUser> {
  const _CUserNativeAdapter();

  @override
  void serialize(IsarCollection<CUser> collection, IsarRawObject rawObj,
      CUser object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.accountId;
    IsarUint8List? _accountId;
    if (value0 != null) {
      _accountId = IsarBinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += (_accountId?.length ?? 0) as int;
    final value1 = object.authId;
    IsarUint8List? _authId;
    if (value1 != null) {
      _authId = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_authId?.length ?? 0) as int;
    final value2 = object.clientRevAt;
    final _clientRevAt = value2;
    final value3 = object.clientRevBy;
    IsarUint8List? _clientRevBy;
    if (value3 != null) {
      _clientRevBy = IsarBinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += (_clientRevBy?.length ?? 0) as int;
    final value4 = object.deleted;
    final _deleted = value4;
    final value5 = object.email;
    IsarUint8List? _email;
    if (value5 != null) {
      _email = IsarBinaryWriter.utf8Encoder.convert(value5);
    }
    dynamicSize += (_email?.length ?? 0) as int;
    final value6 = object.id;
    final _id = IsarBinaryWriter.utf8Encoder.convert(value6);
    dynamicSize += (_id.length) as int;
    final value7 = object.name;
    IsarUint8List? _name;
    if (value7 != null) {
      _name = IsarBinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += (_name?.length ?? 0) as int;
    final value8 = object.serverRevAt;
    final _serverRevAt = value8;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _accountId);
    writer.writeBytes(offsets[1], _authId);
    writer.writeDateTime(offsets[2], _clientRevAt);
    writer.writeBytes(offsets[3], _clientRevBy);
    writer.writeBool(offsets[4], _deleted);
    writer.writeBytes(offsets[5], _email);
    writer.writeBytes(offsets[6], _id);
    writer.writeBytes(offsets[7], _name);
    writer.writeDateTime(offsets[8], _serverRevAt);
  }

  @override
  CUser deserialize(IsarCollection<CUser> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = CUser(
      accountId: reader.readStringOrNull(offsets[0]),
      authId: reader.readStringOrNull(offsets[1]),
      clientRevAt: reader.readDateTimeOrNull(offsets[2]),
      clientRevBy: reader.readStringOrNull(offsets[3]),
      email: reader.readStringOrNull(offsets[5]),
      name: reader.readStringOrNull(offsets[7]),
    );
    object.deleted = reader.readBool(offsets[4]);
    object.id = reader.readString(offsets[6]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[8]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readStringOrNull(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readBool(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readString(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readDateTime(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, CUser object) {}
}

extension CUserByIndex on IsarCollection<CUser> {
  Future<CUser?> getByEmail(String? email) {
    return getByIndex('email', [email]);
  }

  CUser? getByEmailSync(String? email) {
    return getByIndexSync('email', [email]);
  }

  Future<bool> deleteByEmail(String? email) {
    return deleteByIndex('email', [email]);
  }

  bool deleteByEmailSync(String? email) {
    return deleteByIndexSync('email', [email]);
  }

  Future<List<CUser?>> getAllByEmail(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndex('email', values);
  }

  List<CUser?> getAllByEmailSync(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndexSync('email', values);
  }

  Future<int> deleteAllByEmail(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndex('email', values);
  }

  int deleteAllByEmailSync(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('email', values);
  }

  Future<CUser?> getByName(String? name) {
    return getByIndex('name', [name]);
  }

  CUser? getByNameSync(String? name) {
    return getByIndexSync('name', [name]);
  }

  Future<bool> deleteByName(String? name) {
    return deleteByIndex('name', [name]);
  }

  bool deleteByNameSync(String? name) {
    return deleteByIndexSync('name', [name]);
  }

  Future<List<CUser?>> getAllByName(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex('name', values);
  }

  List<CUser?> getAllByNameSync(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync('name', values);
  }

  Future<int> deleteAllByName(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex('name', values);
  }

  int deleteAllByNameSync(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('name', values);
  }
}

extension CUserQueryWhereSort on QueryBuilder<CUser, CUser, QWhere> {
  QueryBuilder<CUser, CUser, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<CUser, CUser, QAfterWhere> anyDeleted() {
    return addWhereClauseInternal(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<CUser, CUser, QAfterWhere> anyEmail() {
    return addWhereClauseInternal(const WhereClause(indexName: 'email'));
  }

  QueryBuilder<CUser, CUser, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<CUser, CUser, QAfterWhere> anyName() {
    return addWhereClauseInternal(const WhereClause(indexName: 'name'));
  }

  QueryBuilder<CUser, CUser, QAfterWhere> anyServerRevAt() {
    return addWhereClauseInternal(const WhereClause(indexName: 'serverRevAt'));
  }
}

extension CUserQueryWhere on QueryBuilder<CUser, CUser, QWhereClause> {
  QueryBuilder<CUser, CUser, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> isarIdBetween(
    int? lowerIsarId,
    int? upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerIsarId],
      includeLower: includeLower,
      upper: [upperIsarId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> deletedNotEqualTo(
      bool deleted) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> emailEqualTo(String? email) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'email',
      lower: [email],
      includeLower: true,
      upper: [email],
      includeUpper: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> emailNotEqualTo(String? email) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'email',
        upper: [email],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'email',
        lower: [email],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'email',
        lower: [email],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'email',
        upper: [email],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> emailIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'email',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> emailIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'email',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> idNotEqualTo(String id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'name',
      lower: [name],
      includeLower: true,
      upper: [name],
      includeUpper: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> nameNotEqualTo(String? name) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name',
        upper: [name],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name',
        lower: [name],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name',
        lower: [name],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name',
        upper: [name],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> nameIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> nameIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> serverRevAtEqualTo(
      DateTime serverRevAt) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> serverRevAtNotEqualTo(
      DateTime serverRevAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> serverRevAtBetween(
    DateTime lowerServerRevAt,
    DateTime upperServerRevAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [lowerServerRevAt],
      includeLower: includeLower,
      upper: [upperServerRevAt],
      includeUpper: includeUpper,
    ));
  }
}

extension CUserQueryFilter on QueryBuilder<CUser, CUser, QFilterCondition> {
  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'accountId',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'accountId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> accountIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'accountId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'authId',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'authId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> authIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'authId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clientRevBy',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'email',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'email',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> emailMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'email',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isarIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isarIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> serverRevAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> serverRevAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> serverRevAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension CUserQueryLinks on QueryBuilder<CUser, CUser, QFilterCondition> {}

extension CUserQueryWhereSortBy on QueryBuilder<CUser, CUser, QSortBy> {
  QueryBuilder<CUser, CUser, QAfterSortBy> sortByAccountId() {
    return addSortByInternal('accountId', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByAuthId() {
    return addSortByInternal('authId', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByAuthIdDesc() {
    return addSortByInternal('authId', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByEmail() {
    return addSortByInternal('email', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByEmailDesc() {
    return addSortByInternal('email', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }
}

extension CUserQueryWhereSortThenBy on QueryBuilder<CUser, CUser, QSortThenBy> {
  QueryBuilder<CUser, CUser, QAfterSortBy> thenByAccountId() {
    return addSortByInternal('accountId', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByAuthId() {
    return addSortByInternal('authId', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByAuthIdDesc() {
    return addSortByInternal('authId', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByEmail() {
    return addSortByInternal('email', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByEmailDesc() {
    return addSortByInternal('email', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }
}

extension CUserQueryWhereDistinct on QueryBuilder<CUser, CUser, QDistinct> {
  QueryBuilder<CUser, CUser, QDistinct> distinctByAccountId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('accountId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByAuthId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('authId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('email', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }
}

extension CUserQueryProperty on QueryBuilder<CUser, CUser, QQueryProperty> {
  QueryBuilder<CUser, String?, QQueryOperations> accountIdProperty() {
    return addPropertyNameInternal('accountId');
  }

  QueryBuilder<CUser, String?, QQueryOperations> authIdProperty() {
    return addPropertyNameInternal('authId');
  }

  QueryBuilder<CUser, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyNameInternal('clientRevAt');
  }

  QueryBuilder<CUser, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyNameInternal('clientRevBy');
  }

  QueryBuilder<CUser, bool, QQueryOperations> deletedProperty() {
    return addPropertyNameInternal('deleted');
  }

  QueryBuilder<CUser, String?, QQueryOperations> emailProperty() {
    return addPropertyNameInternal('email');
  }

  QueryBuilder<CUser, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CUser, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<CUser, String?, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<CUser, DateTime, QQueryOperations> serverRevAtProperty() {
    return addPropertyNameInternal('serverRevAt');
  }
}
