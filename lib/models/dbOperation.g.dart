// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbOperation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetDbOperationCollection on Isar {
  IsarCollection<DbOperation> get dbOperations {
    return getCollection('DbOperation');
  }
}

final DbOperationSchema = CollectionSchema(
  name: 'DbOperation',
  schema:
      '{"name":"DbOperation","properties":[{"name":"time","type":"Long"},{"name":"table","type":"String"},{"name":"data","type":"String"}],"indexes":[{"name":"time","unique":false,"properties":[{"name":"time","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _DbOperationAdapter(),
  idName: 'id',
  propertyIds: {'time': 0, 'table': 1, 'data': 2},
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
  version: 0,
);

class _DbOperationAdapter extends IsarTypeAdapter<DbOperation> {
  const _DbOperationAdapter();

  @override
  int serialize(IsarCollection<DbOperation> collection, RawObject rawObj,
      DbOperation object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.id ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.time;
    final _time = value0;
    final value1 = object.table;
    Uint8List? _table;
    if (value1 != null) {
      _table = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _table?.length ?? 0;
    final value2 = object.data;
    Uint8List? _data;
    if (value2 != null) {
      _data = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _data?.length ?? 0;
    final size = dynamicSize + 34;

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
    final writer = BinaryWriter(buffer, 34);
    writer.writeDateTime(offsets[0], _time);
    writer.writeBytes(offsets[1], _table);
    writer.writeBytes(offsets[2], _data);
    return bufferSize;
  }

  @override
  DbOperation deserialize(IsarCollection<DbOperation> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = DbOperation(
      table: reader.readStringOrNull(offsets[1]),
    );
    object.id = id;
    object.time = reader.readDateTimeOrNull(offsets[0]);
    object.data = reader.readStringOrNull(offsets[2]);
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
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension DbOperationQueryWhereSort
    on QueryBuilder<DbOperation, DbOperation, QWhere> {
  QueryBuilder<DbOperation, DbOperation, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhere> anyTime() {
    return addWhereClause(WhereClause(indexName: 'time'));
  }
}

extension DbOperationQueryWhere
    on QueryBuilder<DbOperation, DbOperation, QWhereClause> {
  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idNotEqualTo(
      int? id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: '_id',
        upper: [id],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: '_id',
        lower: [id],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> idIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeEqualTo(
      DateTime? time) {
    return addWhereClause(WhereClause(
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
      return addWhereClause(WhereClause(
        indexName: 'time',
        upper: [time],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'time',
        lower: [time],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'time',
        lower: [time],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'time',
        upper: [time],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeGreaterThan(
      DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: false,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeLessThan(
      DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: false,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterWhereClause> timeBetween(
      DateTime? lowerTime, DateTime? upperTime) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [lowerTime],
      includeLower: true,
      upper: [upperTime],
      includeUpper: true,
    ));
  }
}

extension DbOperationQueryFilter
    on QueryBuilder<DbOperation, DbOperation, QFilterCondition> {
  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeEqualTo(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeGreaterThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeLessThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> timeBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'time',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'table',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'table',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> tableMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'table',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'data',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'data',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, DbOperation, QAfterFilterCondition> dataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'data',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension DbOperationQueryWhereSortBy
    on QueryBuilder<DbOperation, DbOperation, QSortBy> {
  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTable() {
    return addSortByInternal('table', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByTableDesc() {
    return addSortByInternal('table', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByData() {
    return addSortByInternal('data', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> sortByDataDesc() {
    return addSortByInternal('data', Sort.desc);
  }
}

extension DbOperationQueryWhereSortThenBy
    on QueryBuilder<DbOperation, DbOperation, QSortThenBy> {
  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTable() {
    return addSortByInternal('table', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByTableDesc() {
    return addSortByInternal('table', Sort.desc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByData() {
    return addSortByInternal('data', Sort.asc);
  }

  QueryBuilder<DbOperation, DbOperation, QAfterSortBy> thenByDataDesc() {
    return addSortByInternal('data', Sort.desc);
  }
}

extension DbOperationQueryWhereDistinct
    on QueryBuilder<DbOperation, DbOperation, QDistinct> {
  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }

  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctByTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('table', caseSensitive: caseSensitive);
  }

  QueryBuilder<DbOperation, DbOperation, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('data', caseSensitive: caseSensitive);
  }
}

extension DbOperationQueryProperty
    on QueryBuilder<DbOperation, DbOperation, QQueryProperty> {
  QueryBuilder<DbOperation, int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<DbOperation, DateTime?, QQueryOperations> timeProperty() {
    return addPropertyName('time');
  }

  QueryBuilder<DbOperation, String?, QQueryOperations> tableProperty() {
    return addPropertyName('table');
  }

  QueryBuilder<DbOperation, String?, QQueryOperations> dataProperty() {
    return addPropertyName('data');
  }
}
