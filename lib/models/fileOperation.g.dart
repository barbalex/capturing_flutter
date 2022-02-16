// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileOperation.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetFileOperationCollection on Isar {
  IsarCollection<FileOperation> get fileOperations {
    return getCollection('FileOperation');
  }
}

final FileOperationSchema = CollectionSchema(
  name: 'FileOperation',
  schema:
      '{"name":"FileOperation","idName":"id","properties":[{"name":"fileId","type":"String"},{"name":"localPath","type":"String"},{"name":"time","type":"Long"}],"indexes":[{"name":"time","unique":false,"properties":[{"name":"time","type":"Value","caseSensitive":false}]}],"links":[]}',
  nativeAdapter: const _FileOperationNativeAdapter(),
  webAdapter: const _FileOperationWebAdapter(),
  idName: 'id',
  propertyIds: {'fileId': 0, 'localPath': 1, 'time': 2},
  listProperties: {},
  indexIds: {'time': 0},
  indexTypes: {
    'time': [
      NativeIndexType.long,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _FileOperationWebAdapter extends IsarWebTypeAdapter<FileOperation> {
  const _FileOperationWebAdapter();

  @override
  Object serialize(
      IsarCollection<FileOperation> collection, FileOperation object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'fileId', object.fileId);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'localPath', object.localPath);
    IsarNative.jsObjectSet(
        jsObj, 'time', object.time?.toUtc().millisecondsSinceEpoch);
    return jsObj;
  }

  @override
  FileOperation deserialize(
      IsarCollection<FileOperation> collection, dynamic jsObj) {
    final object = FileOperation(
      fileId: IsarNative.jsObjectGet(jsObj, 'fileId'),
      localPath: IsarNative.jsObjectGet(jsObj, 'localPath'),
    );
    object.id = IsarNative.jsObjectGet(jsObj, 'id');
    object.time = IsarNative.jsObjectGet(jsObj, 'time') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'time'),
                isUtc: true)
            .toLocal()
        : null;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'fileId':
        return (IsarNative.jsObjectGet(jsObj, 'fileId')) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
      case 'localPath':
        return (IsarNative.jsObjectGet(jsObj, 'localPath')) as P;
      case 'time':
        return (IsarNative.jsObjectGet(jsObj, 'time') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'time'),
                    isUtc: true)
                .toLocal()
            : null) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, FileOperation object) {}
}

class _FileOperationNativeAdapter extends IsarNativeTypeAdapter<FileOperation> {
  const _FileOperationNativeAdapter();

  @override
  void serialize(
      IsarCollection<FileOperation> collection,
      IsarRawObject rawObj,
      FileOperation object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.fileId;
    IsarUint8List? _fileId;
    if (value0 != null) {
      _fileId = IsarBinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += (_fileId?.length ?? 0) as int;
    final value1 = object.localPath;
    IsarUint8List? _localPath;
    if (value1 != null) {
      _localPath = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_localPath?.length ?? 0) as int;
    final value2 = object.time;
    final _time = value2;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _fileId);
    writer.writeBytes(offsets[1], _localPath);
    writer.writeDateTime(offsets[2], _time);
  }

  @override
  FileOperation deserialize(IsarCollection<FileOperation> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
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
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, FileOperation object) {}
}

extension FileOperationQueryWhereSort
    on QueryBuilder<FileOperation, FileOperation, QWhere> {
  QueryBuilder<FileOperation, FileOperation, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhere> anyTime() {
    return addWhereClauseInternal(const WhereClause(indexName: 'time'));
  }
}

extension FileOperationQueryWhere
    on QueryBuilder<FileOperation, FileOperation, QWhereClause> {
  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idEqualTo(
      int? id) {
    return addWhereClauseInternal(WhereClause(
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

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
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
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeEqualTo(
      DateTime? time) {
    return addWhereClauseInternal(WhereClause(
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

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause>
      timeIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeGreaterThan(
    DateTime? time, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: include,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterWhereClause> timeLessThan(
    DateTime? time, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
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
    return addWhereClauseInternal(WhereClause(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      fileIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fileId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> idEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathIsNull() {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      localPathMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'localPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition>
      timeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, FileOperation, QAfterFilterCondition> timeEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
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
    return addPropertyNameInternal('fileId');
  }

  QueryBuilder<FileOperation, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<FileOperation, String?, QQueryOperations> localPathProperty() {
    return addPropertyNameInternal('localPath');
  }

  QueryBuilder<FileOperation, DateTime?, QQueryOperations> timeProperty() {
    return addPropertyNameInternal('time');
  }
}
