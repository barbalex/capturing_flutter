// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileOperation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetFileOperationCollection on Isar {
  IsarCollection<FileOperation> get fileOperations {
    return getCollection('FileOperation');
  }
}

final FileOperationSchema = CollectionSchema(
  name: 'FileOperation',
  schema:
      '{"name":"FileOperation","properties":[{"name":"time","type":"Long"},{"name":"localPath","type":"String"},{"name":"fileId","type":"String"}],"indexes":[{"name":"time","unique":false,"properties":[{"name":"time","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _FileOperationAdapter(),
  idName: 'id',
  propertyIds: {'time': 0, 'localPath': 1, 'fileId': 2},
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

class _FileOperationAdapter extends IsarTypeAdapter<FileOperation> {
  const _FileOperationAdapter();

  @override
  int serialize(IsarCollection<FileOperation> collection, RawObject rawObj,
      FileOperation object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.id ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.time;
    final _time = value0;
    final value1 = object.localPath;
    Uint8List? _localPath;
    if (value1 != null) {
      _localPath = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _localPath?.length ?? 0;
    final value2 = object.fileId;
    Uint8List? _fileId;
    if (value2 != null) {
      _fileId = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _fileId?.length ?? 0;
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
    writer.writeBytes(offsets[1], _localPath);
    writer.writeBytes(offsets[2], _fileId);
    return bufferSize;
  }

  @override
  FileOperation deserialize(IsarCollection<FileOperation> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = FileOperation(
      localPath: reader.readStringOrNull(offsets[1]),
      fileId: reader.readStringOrNull(offsets[2]),
    );
    object.id = id;
    object.time = reader.readDateTimeOrNull(offsets[0]);
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

extension FileOperationQueryWhereSort
    on QueryBuilder<FileOperation, FileOperation, QWhere> {
  QueryBuilder<FileOperation, FileOperation, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhere> anyTime() {
    return addWhereClause(WhereClause(indexName: 'time'));
  }
}

extension FileOperationQueryWhere
    on QueryBuilder<FileOperation, FileOperation, QWhereClause> {
  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idEqualTo(
      int? id) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeEqualTo(
      DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: true,
      upper: [time],
      includeUpper: true,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeNotEqualTo(
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

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause>
      timeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeGreaterThan(
      DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: false,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeLessThan(
      DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: false,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeBetween(
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

extension FileOperationQueryFilter
    on QueryBuilder<FileOperation, FileOperation, QFilterCondition> {
  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      idGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      timeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> timeEqualTo(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      timeGreaterThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      timeLessThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> timeBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'time',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'localPath',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'localPath',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'localPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'fileId',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fileId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdStartsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'fileId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension FileOperationQueryWhereSortBy
    on QueryBuilder<FileOperation, FileOperation, QSortBy> {
  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy>
      sortByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByFileId() {
    return addSortByInternal('fileId', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByFileIdDesc() {
    return addSortByInternal('fileId', Sort.desc);
  }
}

extension FileOperationQueryWhereSortThenBy
    on QueryBuilder<FileOperation, FileOperation, QSortThenBy> {
  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy>
      thenByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByFileId() {
    return addSortByInternal('fileId', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByFileIdDesc() {
    return addSortByInternal('fileId', Sort.desc);
  }
}

extension FileOperationQueryWhereDistinct
    on QueryBuilder<FileOperation, FileOperation, QDistinct> {
  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }

  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('localPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctByFileId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fileId', caseSensitive: caseSensitive);
  }
}

extension FileOperationQueryProperty
    on QueryBuilder<FileOperation, FileOperation, QQueryProperty> {
  QueryBuilder<FileOperation, int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<FileOperation, DateTime?, QQueryOperations> timeProperty() {
    return addPropertyName('time');
  }

  QueryBuilder<FileOperation, String?, QQueryOperations> localPathProperty() {
    return addPropertyName('localPath');
  }

  QueryBuilder<FileOperation, String?, QQueryOperations> fileIdProperty() {
    return addPropertyName('fileId');
  }
}
