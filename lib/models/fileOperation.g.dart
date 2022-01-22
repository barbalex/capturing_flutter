// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileOperation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetFileOperationCollection on Isar {
  IsarCollection<FileOperation> get fileOperations {
    return getCollection('FileOperation');
  }
}

final FileOperationSchema = CollectionSchema(
  name: 'FileOperation',
  schema:
      '{"name":"FileOperation","properties":[{"name":"fileId","type":"String"},{"name":"localPath","type":"String"},{"name":"time","type":"Long"}],"indexes":[{"name":"time","unique":false,"properties":[{"name":"time","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _FileOperationAdapter(),
  idName: 'id',
  propertyIds: {'fileId': 0, 'localPath': 1, 'time': 2},
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
  version: 0,
);

class _FileOperationAdapter extends IsarTypeAdapter<FileOperation> {
  const _FileOperationAdapter();

  @override
  int serialize(IsarCollection<FileOperation> collection, IsarRawObject rawObj,
      FileOperation object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.id ?? Isar.autoIncrement;
    var dynamicSize = 0;
    final value0 = object.fileId;
    IsarUint8List? _fileId;
    if (value0 != null) {
      _fileId = BinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += _fileId?.length ?? 0;
    final value1 = object.localPath;
    IsarUint8List? _localPath;
    if (value1 != null) {
      _localPath = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _localPath?.length ?? 0;
    final value2 = object.time;
    final _time = value2;
    final size = dynamicSize + 26;

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
    final writer = BinaryWriter(buffer, 26);
    writer.writeBytes(offsets[0], _fileId);
    writer.writeBytes(offsets[1], _localPath);
    writer.writeDateTime(offsets[2], _time);
    return bufferSize;
  }

  @override
  FileOperation deserialize(IsarCollection<FileOperation> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = FileOperation(
      fileId: reader.readStringOrNull(offsets[0]),
      localPath: reader.readStringOrNull(offsets[1]),
    );
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

extension FileOperationQueryWhereSort
    on QueryBuilder<FileOperation, FileOperation, QWhere> {
  QueryBuilder<FileOperation, FileOperation, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: null));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhere> anyTime() {
    return addWhereClause(const WhereClause(indexName: 'time'));
  }
}

extension FileOperationQueryWhere
    on QueryBuilder<FileOperation, FileOperation, QWhereClause> {
  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idEqualTo(
      int? id) {
    return addWhereClause(WhereClause(
      indexName: null,
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
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idBetween(
    int? lowerId,
    int? upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
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
    return addWhereClause(const WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause>
      timeIsNotNull() {
    return addWhereClause(const WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeGreaterThan(
    DateTime? time, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: include,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeLessThan(
    DateTime? time, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: include,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeBetween(
    DateTime? lowerTime,
    DateTime? upperTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [lowerTime],
      includeLower: includeLower,
      upper: [upperTime],
      includeUpper: includeUpper,
    ));
  }
}

extension FileOperationQueryFilter
    on QueryBuilder<FileOperation, FileOperation, QFilterCondition> {
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'fileId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
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
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
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
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'localPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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
      timeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> timeEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      timeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      timeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> timeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'time',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension FileOperationQueryWhereSortBy
    on QueryBuilder<FileOperation, FileOperation, QSortBy> {
  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByFileId() {
    return addSortByInternal('fileId', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByFileIdDesc() {
    return addSortByInternal('fileId', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy>
      sortByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }
}

extension FileOperationQueryWhereSortThenBy
    on QueryBuilder<FileOperation, FileOperation, QSortThenBy> {
  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByFileId() {
    return addSortByInternal('fileId', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByFileIdDesc() {
    return addSortByInternal('fileId', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByLocalPath() {
    return addSortByInternal('localPath', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy>
      thenByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.desc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.asc);
  }

  QueryBuilder<FileOperation, FileOperation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.desc);
  }
}

extension FileOperationQueryWhereDistinct
    on QueryBuilder<FileOperation, FileOperation, QDistinct> {
  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctByFileId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fileId', caseSensitive: caseSensitive);
  }

  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('localPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<FileOperation, FileOperation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }
}

extension FileOperationQueryProperty
    on QueryBuilder<FileOperation, FileOperation, QQueryProperty> {
  QueryBuilder<FileOperation, String?, QQueryOperations> fileIdProperty() {
    return addPropertyName('fileId');
  }

  QueryBuilder<FileOperation, int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<FileOperation, String?, QQueryOperations> localPathProperty() {
    return addPropertyName('localPath');
  }

  QueryBuilder<FileOperation, DateTime?, QQueryOperations> timeProperty() {
    return addPropertyName('time');
  }
}
