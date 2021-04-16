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
import 'models/account.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"Project","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"accountId","type":5},{"name":"label","type":5},{"name":"srsId","type":3},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"name","indexType":2,"caseSensitive":true}]}],"links":[]},{"name":"Account","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"serviceId","type":5},{"name":"manager","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"name","indexType":2,"caseSensitive":true}]}],"links":[]}]';

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
        final propertyOffsetsPtr = malloc<Uint32>(9);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(9);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Project'] = IsarCollectionImpl<Project>(
          isar: isar,
          adapter: _ProjectAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 9),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'accountId': 3,
            'label': 4,
            'srsId': 5,
            'clientRevAt': 6,
            'clientRevBy': 7,
            'serverRevAt': 8
          },
          indexIds: {'name': 0},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 1));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Account'] = IsarCollectionImpl<Account>(
          isar: isar,
          adapter: _AccountAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 8),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'serviceId': 3,
            'manager': 4,
            'clientRevAt': 5,
            'clientRevBy': 6,
            'serverRevAt': 7
          },
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
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.name;
    Uint8List? _name;
    if (value2 != null) {
      _name = _utf8Encoder.convert(value2);
    }
    dynamicSize += _name?.length ?? 0;
    final value3 = object.accountId;
    Uint8List? _accountId;
    if (value3 != null) {
      _accountId = _utf8Encoder.convert(value3);
    }
    dynamicSize += _accountId?.length ?? 0;
    final value4 = object.label;
    Uint8List? _label;
    if (value4 != null) {
      _label = _utf8Encoder.convert(value4);
    }
    dynamicSize += _label?.length ?? 0;
    final value5 = object.srsId;
    final _srsId = value5;
    final value6 = object.clientRevAt;
    final _clientRevAt = _utf8Encoder.convert(value6);
    dynamicSize += _clientRevAt.length;
    final value7 = object.clientRevBy;
    final _clientRevBy = _utf8Encoder.convert(value7);
    dynamicSize += _clientRevBy.length;
    final value8 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value8 != null) {
      _serverRevAt = _utf8Encoder.convert(value8);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final size = dynamicSize + 74;

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
    final writer = BinaryWriter(buffer, 74);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _accountId);
    writer.writeBytes(offsets[4], _label);
    writer.writeLong(offsets[5], _srsId);
    writer.writeBytes(offsets[6], _clientRevAt);
    writer.writeBytes(offsets[7], _clientRevBy);
    writer.writeBytes(offsets[8], _serverRevAt);
    return bufferSize;
  }

  @override
  Project deserialize(IsarCollectionImpl<Project> collection,
      BinaryReader reader, List<int> offsets) {
    final object = Project();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.name = reader.readStringOrNull(offsets[2]);
    object.accountId = reader.readStringOrNull(offsets[3]);
    object.label = reader.readStringOrNull(offsets[4]);
    object.srsId = reader.readLongOrNull(offsets[5]);
    object.clientRevAt = reader.readString(offsets[6]);
    object.clientRevBy = reader.readString(offsets[7]);
    object.serverRevAt = reader.readStringOrNull(offsets[8]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readLongOrNull(offset)) as P;
      case 6:
        return (reader.readString(offset)) as P;
      case 7:
        return (reader.readString(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _AccountAdapter extends TypeAdapter<Account> {
  @override
  int serialize(IsarCollectionImpl<Account> collection, RawObject rawObj,
      Account object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.name;
    Uint8List? _name;
    if (value2 != null) {
      _name = _utf8Encoder.convert(value2);
    }
    dynamicSize += _name?.length ?? 0;
    final value3 = object.serviceId;
    Uint8List? _serviceId;
    if (value3 != null) {
      _serviceId = _utf8Encoder.convert(value3);
    }
    dynamicSize += _serviceId?.length ?? 0;
    final value4 = object.manager;
    Uint8List? _manager;
    if (value4 != null) {
      _manager = _utf8Encoder.convert(value4);
    }
    dynamicSize += _manager?.length ?? 0;
    final value5 = object.clientRevAt;
    final _clientRevAt = _utf8Encoder.convert(value5);
    dynamicSize += _clientRevAt.length;
    final value6 = object.clientRevBy;
    final _clientRevBy = _utf8Encoder.convert(value6);
    dynamicSize += _clientRevBy.length;
    final value7 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value7 != null) {
      _serverRevAt = _utf8Encoder.convert(value7);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final size = dynamicSize + 66;

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
    final writer = BinaryWriter(buffer, 66);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _serviceId);
    writer.writeBytes(offsets[4], _manager);
    writer.writeBytes(offsets[5], _clientRevAt);
    writer.writeBytes(offsets[6], _clientRevBy);
    writer.writeBytes(offsets[7], _serverRevAt);
    return bufferSize;
  }

  @override
  Account deserialize(IsarCollectionImpl<Account> collection,
      BinaryReader reader, List<int> offsets) {
    final object = Account();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.name = reader.readStringOrNull(offsets[2]);
    object.serviceId = reader.readStringOrNull(offsets[3]);
    object.manager = reader.readStringOrNull(offsets[4]);
    object.clientRevAt = reader.readString(offsets[5]);
    object.clientRevBy = reader.readString(offsets[6]);
    object.serverRevAt = reader.readStringOrNull(offsets[7]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      case 6:
        return (reader.readString(offset)) as P;
      case 7:
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

  IsarCollection<Account> get accounts {
    return getCollection('Account');
  }
}

extension ProjectQueryWhereSort on QueryBuilder<Project, QWhere> {
  QueryBuilder<Project, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
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

extension AccountQueryWhereSort on QueryBuilder<Account, QWhere> {
  QueryBuilder<Account, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }
}

extension AccountQueryWhere on QueryBuilder<Account, QWhereClause> {
  QueryBuilder<Account, QAfterWhereClause> nameWordEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> nameWordStartsWith(String? value) {
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
  QueryBuilder<Project, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
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

  QueryBuilder<Project, QAfterFilterCondition> accountIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'accountId',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> accountIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> accountIdStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'accountId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> accountIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'accountId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> accountIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'accountId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> accountIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'accountId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> labelEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> labelStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'label',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> labelEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'label',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> labelContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> srsIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'srsId',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> srsIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'srsId',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> srsIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'srsId',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> srsIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'srsId',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> srsIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'srsId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverRevAtStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'serverRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverRevAtEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'serverRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverRevAtContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension AccountQueryFilter on QueryBuilder<Account, QFilterCondition> {
  QueryBuilder<Account, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> nameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> nameStartsWith(String? value,
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

  QueryBuilder<Account, QAfterFilterCondition> nameEndsWith(String? value,
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

  QueryBuilder<Account, QAfterFilterCondition> nameContains(String? value,
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

  QueryBuilder<Account, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serviceIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serviceId',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serviceIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serviceId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serviceIdStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'serviceId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serviceIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'serviceId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serviceIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serviceId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serviceIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serviceId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'manager',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'manager',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'manager',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'manager',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'manager',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'manager',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serverRevAtStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'serverRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serverRevAtEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'serverRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serverRevAtContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ProjectQueryLinks on QueryBuilder<Project, QFilterCondition> {}

extension AccountQueryLinks on QueryBuilder<Account, QFilterCondition> {}

extension ProjectQueryWhereSortBy on QueryBuilder<Project, QSortBy> {
  QueryBuilder<Project, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByAccountId() {
    return addSortByInternal('accountId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortBySrsId() {
    return addSortByInternal('srsId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortBySrsIdDesc() {
    return addSortByInternal('srsId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }
}

extension ProjectQueryWhereSortThenBy on QueryBuilder<Project, QSortThenBy> {
  QueryBuilder<Project, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByAccountId() {
    return addSortByInternal('accountId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenBySrsId() {
    return addSortByInternal('srsId', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenBySrsIdDesc() {
    return addSortByInternal('srsId', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }
}

extension AccountQueryWhereSortBy on QueryBuilder<Account, QSortBy> {
  QueryBuilder<Account, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByServiceId() {
    return addSortByInternal('serviceId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByServiceIdDesc() {
    return addSortByInternal('serviceId', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByManager() {
    return addSortByInternal('manager', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByManagerDesc() {
    return addSortByInternal('manager', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }
}

extension AccountQueryWhereSortThenBy on QueryBuilder<Account, QSortThenBy> {
  QueryBuilder<Account, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByServiceId() {
    return addSortByInternal('serviceId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByServiceIdDesc() {
    return addSortByInternal('serviceId', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByManager() {
    return addSortByInternal('manager', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByManagerDesc() {
    return addSortByInternal('manager', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }
}

extension ProjectQueryWhereDistinct on QueryBuilder<Project, QDistinct> {
  QueryBuilder<Project, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Project, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctByAccountId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('accountId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctBySrsId() {
    return addDistinctByInternal('srsId');
  }

  QueryBuilder<Project, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Project, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }
}

extension AccountQueryWhereDistinct on QueryBuilder<Account, QDistinct> {
  QueryBuilder<Account, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Account, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByServiceId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serviceId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByManager(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('manager', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }
}

extension ProjectQueryProperty on QueryBuilder<Project, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String?, QQueryOperations> accountIdProperty() {
    return addPropertyName('accountId');
  }

  QueryBuilder<String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<int?, QQueryOperations> srsIdProperty() {
    return addPropertyName('srsId');
  }

  QueryBuilder<String, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<String, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }
}

extension AccountQueryProperty on QueryBuilder<Account, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String?, QQueryOperations> serviceIdProperty() {
    return addPropertyName('serviceId');
  }

  QueryBuilder<String?, QQueryOperations> managerProperty() {
    return addPropertyName('manager');
  }

  QueryBuilder<String, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<String, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }
}
