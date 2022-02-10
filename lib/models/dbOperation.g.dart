// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbOperation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetDbOperationCollection on Isar {
  IsarCollection<DbOperation> get dbOperations {
    return getCollection('DbOperation');
  }
}

final DbOperationSchema = CollectionSchema(
  name: 'DbOperation',
  schema:
      '{"name":"DbOperation","properties":[{"name":"data","type":"String"},{"name":"table","type":"String"},{"name":"time","type":"Long"}],"indexes":[{"name":"time","unique":false,"properties":[{"name":"time","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _DbOperationAdapter(),
  idName: 'id',
  propertyIds: {'data': 0, 'table': 1, 'time': 2},
  indexIds: {'time': 0},
  indexTypes: {
    'time': [
      NativeIndexType.long,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) => obj.id,
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 1,
);

class _DbOperationAdapter extends IsarTypeAdapter<DbOperation> {
  const _DbOperationAdapter();

  @override
  void serialize(IsarCollection<DbOperation> collection, IsarRawObject rawObj,
      DbOperation object, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.data;
    IsarUint8List? _data;
    if (value0 != null) {
      _data = BinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += _data?.length ?? 0;
    final value1 = object.table;
    IsarUint8List? _table;
    if (value1 != null) {
      _table = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _table?.length ?? 0;
    final value2 = object.time;
    final _time = value2;
    final size = dynamicSize + 26;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = bufAsBytes(rawObj.buffer, size);
    final writer = BinaryWriter(buffer, 26);
    writer.writeBytes(offsets[0], _data);
    writer.writeBytes(offsets[1], _table);
    writer.writeDateTime(offsets[2], _time);
  }

  @override
  DbOperation deserialize(IsarCollection<DbOperation> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = DbOperation(
      table: reader.readStringOrNull(offsets[1]),
    );
    object.data = reader.readStringOrNull(offsets[0]);
    object.id = id;
    object.time = reader.readDateTimeOrNull(offsets[2]);
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
        return (reader.readDateTimeOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension DbOperationQueryWhereSort
    on QueryBuilder<DbOperation, DbOperation, QWhere> {
  QueryBuilder<DbOperation, DbOperation, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhere> anyTime() {
    return addWhereClauseInternal(const WhereClause(indexName: 'time'));
  }
}

extension DbOperationQueryWhere
    on QueryBuilder<DbOperation, DbOperation, QWhereClause> {
  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idNotEqualTo(
      int? id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idBetween(
    int? lowerId,
    int? upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeEqualTo(
      DateTime? time) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: true,
      upper: [time],
      includeUpper: true,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeNotEqualTo(
      DateTime? time) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'time',
        upper: [time],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'time',
        lower: [time],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'time',
        lower: [time],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'time',
        upper: [time],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeGreaterThan(
    DateTime? time, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: include,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeLessThan(
    DateTime? time, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: include,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeBetween(
    DateTime? lowerTime,
    DateTime? upperTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'time',
      lower: [lowerTime],
      includeLower: includeLower,
      upper: [upperTime],
      includeUpper: includeUpper,
    ));
  }
}

extension DbOperationQueryFilter
    on QueryBuilder<DbOperation, DbOperation, QFilterCondition> {
  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'data',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'data',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'data',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'table',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition>
      tableGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'table',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'table',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'time',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension DbOperationQueryWhereSortBy
    on QueryBuilder<DbOperation, DbOperation, QSortBy> {
  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByData() {
    return addSortByInternal('data', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByDataDesc() {
    return addSortByInternal('data', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTable() {
    return addSortByInternal('table', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTableDesc() {
    return addSortByInternal('table', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }
}

extension DbOperationQueryWhereSortThenBy
    on QueryBuilder<DbOperation, DbOperation, QSortThenBy> {
  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByData() {
    return addSortByInternal('data', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByDataDesc() {
    return addSortByInternal('data', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTable() {
    return addSortByInternal('table', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTableDesc() {
    return addSortByInternal('table', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }
}

extension DbOperationQueryWhereDistinct
    on QueryBuilder<DbOperation, DbOperation, QDistinct> {
  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('data', caseSensitive: caseSensitive);
  }

  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctByTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('table', caseSensitive: caseSensitive);
  }

  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }
}

extension DbOperationQueryProperty
    on QueryBuilder<DbOperation, DbOperation, QQueryProperty> {
  QueryBuilder<DbOperation, String?, QQueryOperations> dataProperty() {
    return addPropertyNameInternal('data');
  }

  QueryBuilder<DbOperation, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<DbOperation, String?, QQueryOperations> tableProperty() {
    return addPropertyNameInternal('table');
  }

  QueryBuilder<DbOperation, DateTime?, QQueryOperations> timeProperty() {
    return addPropertyNameInternal('time');
  }
}
