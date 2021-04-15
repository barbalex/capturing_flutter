// ignore_for_file: unused_import, implementation_imports

import 'dart:ffi';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:isar/src/isar_native.dart';
import 'package:isar/src/query_builder.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'models/project.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"Project","idProperty":"id","properties":[{"name":"id","type":3},{"name":"serverId","type":5},{"name":"name","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"name","indexType":2,"caseSensitive":true}]}],"links":[]}]';

Future<Isar> openIsar(
    {String name = 'isar',
    String? directory,
    int maxSize = 1000000000,
    Uint8List? encryptionKey}) async {
  final path = await _preparePath(directory);
  return openIsarInternal(
      name: name,
      directory: path,
      maxSize: maxSize,
      encryptionKey: encryptionKey,
      schema: _schema,
      getCollections: (isar) {
        final collectionPtrPtr = malloc<Pointer>();
        final propertyOffsetsPtr = malloc<Uint32>(3);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(3);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Project'] = IsarCollectionImpl<Project>(
          isar: isar,
          adapter: _ProjectAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 3),
          propertyIds: {'id': 0, 'serverId': 1, 'name': 2},
          indexIds: {'name': 0},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        malloc.free(propertyOffsetsPtr);
        malloc.free(collectionPtrPtr);

        return collections;
      });
}

Future<String> _preparePath(String? path) async {
  if (path == null || p.isRelative(path)) {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, path ?? 'isar');
  } else {
    return path;
  }
}

class _ProjectAdapter extends TypeAdapter<Project> {
  @override
  int serialize(IsarCollectionImpl<Project> collection, RawObject rawObj,
      Project object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _id = value0;
    final value1 = object.id;
    Uint8List? _serverId;
    if (value1 != null) {
      _serverId = _utf8Encoder.convert(value1);
    }
    dynamicSize += _serverId?.length ?? 0;
    final value2 = object.name;
    Uint8List? _name;
    if (value2 != null) {
      _name = _utf8Encoder.convert(value2);
    }
    dynamicSize += _name?.length ?? 0;
    final size = dynamicSize + 26;

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
    final writer = BinaryWriter(buffer, 26);
    writer.writeLong(offsets[0], _id);
    writer.writeBytes(offsets[1], _serverId);
    writer.writeBytes(offsets[2], _name);
    return bufferSize;
  }

  @override
  Project deserialize(IsarCollectionImpl<Project> collection,
      BinaryReader reader, List<int> offsets) {
    final object = Project();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readStringOrNull(offsets[1]);
    object.name = reader.readStringOrNull(offsets[2]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension GetCollection on Isar {
  IsarCollection<Project> get projects {
    return getCollection('Project');
  }
}

extension ProjectQueryWhereSort on QueryBuilder<Project, QWhere> {
  QueryBuilder<Project, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension ProjectQueryWhere on QueryBuilder<Project, QWhereClause> {
  QueryBuilder<Project, QAfterWhereClause> nameWordEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> nameWordStartsWith(String? value) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [convertedValue],
      upper: ['$convertedValue\u{FFFFF}'],
      includeLower: true,
      includeUpper: true,
    ));
  }
}

extension ProjectQueryFilter on QueryBuilder<Project, QFilterCondition> {
  QueryBuilder<Project, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverId',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'serverId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'serverId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> nameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> nameStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> nameEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> nameContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ProjectQueryLinks on QueryBuilder<Project, QFilterCondition> {}

extension ProjectQueryWhereSortBy on QueryBuilder<Project, QSortBy> {
  QueryBuilder<Project, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByServerId() {
    return addSortByInternal('serverId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByServerIdDesc() {
    return addSortByInternal('serverId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }
}

extension ProjectQueryWhereSortThenBy on QueryBuilder<Project, QSortThenBy> {
  QueryBuilder<Project, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByServerId() {
    return addSortByInternal('serverId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByServerIdDesc() {
    return addSortByInternal('serverId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }
}

extension ProjectQueryWhereDistinct on QueryBuilder<Project, QDistinct> {
  QueryBuilder<Project, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Project, QDistinct> distinctByServerId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }
}

extension ProjectQueryProperty on QueryBuilder<Project, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> serverIdProperty() {
    return addPropertyName('serverId');
  }

  QueryBuilder<String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }
}
