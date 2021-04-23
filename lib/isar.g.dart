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
import 'models/account.dart';
import 'models/project.dart';
import 'models/operation.dart';
import 'models/table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"Account","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"serviceId","type":5},{"name":"manager","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Project","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"accountId","type":5},{"name":"label","type":5},{"name":"srsId","type":3},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"account","collection":"Account"}]},{"name":"Operation","idProperty":"id","properties":[{"name":"id","type":3},{"name":"time","type":3},{"name":"table","type":5},{"name":"data","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"time","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Table","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"label","type":5},{"name":"relType","type":5},{"name":"isOptions","type":0},{"name":"projectId","type":5},{"name":"parentId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true},{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"isOptions","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"project","collection":"Project"},{"name":"table","collection":"Table"}]}]';

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
        final propertyOffsetsPtr = malloc<Uint32>(12);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(12);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Account'] = IsarCollectionImpl<Account>(
          isar: isar,
          adapter: _AccountAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 9),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'serviceId': 3,
            'manager': 4,
            'clientRevAt': 5,
            'clientRevBy': 6,
            'serverRevAt': 7,
            'deleted': 8
          },
          indexIds: {'name': 0, 'deleted': 1},
          linkIds: {},
          backlinkIds: {'project': 0},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 1));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Project'] = IsarCollectionImpl<Project>(
          isar: isar,
          adapter: _ProjectAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 10),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'accountId': 3,
            'label': 4,
            'srsId': 5,
            'clientRevAt': 6,
            'clientRevBy': 7,
            'serverRevAt': 8,
            'deleted': 9
          },
          indexIds: {'id': 0, 'name': 1, 'serverRevAt': 2, 'deleted': 3},
          linkIds: {'account': 0},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 2));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Operation'] = IsarCollectionImpl<Operation>(
          isar: isar,
          adapter: _OperationAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 4),
          propertyIds: {'id': 0, 'time': 1, 'table': 2, 'data': 3},
          indexIds: {'time': 0},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.id,
          setId: (obj, id) => obj.id = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 3));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Table'] = IsarCollectionImpl<Table>(
          isar: isar,
          adapter: _TableAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 12),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'label': 3,
            'relType': 4,
            'isOptions': 5,
            'projectId': 6,
            'parentId': 7,
            'clientRevAt': 8,
            'clientRevBy': 9,
            'serverRevAt': 10,
            'deleted': 11
          },
          indexIds: {
            'id': 0,
            'name': 1,
            'isOptions': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          linkIds: {'project': 0, 'table': 1},
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
    Uint8List? _clientRevAt;
    if (value5 != null) {
      _clientRevAt = _utf8Encoder.convert(value5);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value6 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value6 != null) {
      _clientRevBy = _utf8Encoder.convert(value6);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value7 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value7 != null) {
      _serverRevAt = _utf8Encoder.convert(value7);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value8 = object.deleted;
    final _deleted = value8;
    final size = dynamicSize + 67;

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
    final writer = BinaryWriter(buffer, 67);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _serviceId);
    writer.writeBytes(offsets[4], _manager);
    writer.writeBytes(offsets[5], _clientRevAt);
    writer.writeBytes(offsets[6], _clientRevBy);
    writer.writeBytes(offsets[7], _serverRevAt);
    writer.writeBool(offsets[8], _deleted);
    if (!(object.project as IsarLinkImpl).attached) {
      (object.project as IsarLinkImpl).attach(
        collection,
        collection.isar.projects as IsarCollectionImpl<Project>,
        object,
        0,
        true,
      );
    }
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
    object.clientRevAt = reader.readStringOrNull(offsets[5]);
    object.clientRevBy = reader.readStringOrNull(offsets[6]);
    object.serverRevAt = reader.readStringOrNull(offsets[7]);
    object.deleted = reader.readBool(offsets[8]);
    object.project = IsarLinkImpl()
      ..attach(
        collection,
        collection.isar.projects as IsarCollectionImpl<Project>,
        object,
        0,
        true,
      );

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
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
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
    Uint8List? _clientRevAt;
    if (value6 != null) {
      _clientRevAt = _utf8Encoder.convert(value6);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value7 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value7 != null) {
      _clientRevBy = _utf8Encoder.convert(value7);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value8 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value8 != null) {
      _serverRevAt = _utf8Encoder.convert(value8);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value9 = object.deleted;
    final _deleted = value9;
    final size = dynamicSize + 75;

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
    final writer = BinaryWriter(buffer, 75);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _accountId);
    writer.writeBytes(offsets[4], _label);
    writer.writeLong(offsets[5], _srsId);
    writer.writeBytes(offsets[6], _clientRevAt);
    writer.writeBytes(offsets[7], _clientRevBy);
    writer.writeBytes(offsets[8], _serverRevAt);
    writer.writeBool(offsets[9], _deleted);
    if (!(object.account as IsarLinkImpl).attached) {
      (object.account as IsarLinkImpl).attach(
        collection,
        collection.isar.accounts as IsarCollectionImpl<Account>,
        object,
        0,
        false,
      );
    }
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
    object.clientRevAt = reader.readStringOrNull(offsets[6]);
    object.clientRevBy = reader.readStringOrNull(offsets[7]);
    object.serverRevAt = reader.readStringOrNull(offsets[8]);
    object.deleted = reader.readBool(offsets[9]);
    object.account = IsarLinkImpl()
      ..attach(
        collection,
        collection.isar.accounts as IsarCollectionImpl<Account>,
        object,
        0,
        false,
      );

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
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _OperationAdapter extends TypeAdapter<Operation> {
  @override
  int serialize(IsarCollectionImpl<Operation> collection, RawObject rawObj,
      Operation object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = value0;
    final value1 = object.time;
    final _time = value1;
    final value2 = object.table;
    Uint8List? _table;
    if (value2 != null) {
      _table = _utf8Encoder.convert(value2);
    }
    dynamicSize += _table?.length ?? 0;
    final value3 = object.data;
    Uint8List? _data;
    if (value3 != null) {
      _data = _utf8Encoder.convert(value3);
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
    writer.writeLong(offsets[0], _id);
    writer.writeDateTime(offsets[1], _time);
    writer.writeBytes(offsets[2], _table);
    writer.writeBytes(offsets[3], _data);
    return bufferSize;
  }

  @override
  Operation deserialize(IsarCollectionImpl<Operation> collection,
      BinaryReader reader, List<int> offsets) {
    final object = Operation();
    object.id = reader.readLongOrNull(offsets[0]);
    object.time = reader.readDateTime(offsets[1]);
    object.table = reader.readStringOrNull(offsets[2]);
    object.data = reader.readStringOrNull(offsets[3]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readDateTime(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _TableAdapter extends TypeAdapter<Table> {
  @override
  int serialize(IsarCollectionImpl<Table> collection, RawObject rawObj,
      Table object, List<int> offsets,
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
    final value3 = object.label;
    Uint8List? _label;
    if (value3 != null) {
      _label = _utf8Encoder.convert(value3);
    }
    dynamicSize += _label?.length ?? 0;
    final value4 = object.relType;
    Uint8List? _relType;
    if (value4 != null) {
      _relType = _utf8Encoder.convert(value4);
    }
    dynamicSize += _relType?.length ?? 0;
    final value5 = object.isOptions;
    final _isOptions = value5;
    final value6 = object.projectId;
    Uint8List? _projectId;
    if (value6 != null) {
      _projectId = _utf8Encoder.convert(value6);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value7 = object.parentId;
    Uint8List? _parentId;
    if (value7 != null) {
      _parentId = _utf8Encoder.convert(value7);
    }
    dynamicSize += _parentId?.length ?? 0;
    final value8 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value8 != null) {
      _clientRevAt = _utf8Encoder.convert(value8);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value9 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value9 != null) {
      _clientRevBy = _utf8Encoder.convert(value9);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value10 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value10 != null) {
      _serverRevAt = _utf8Encoder.convert(value10);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value11 = object.deleted;
    final _deleted = value11;
    final size = dynamicSize + 84;

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
    final writer = BinaryWriter(buffer, 84);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _label);
    writer.writeBytes(offsets[4], _relType);
    writer.writeBool(offsets[5], _isOptions);
    writer.writeBytes(offsets[6], _projectId);
    writer.writeBytes(offsets[7], _parentId);
    writer.writeBytes(offsets[8], _clientRevAt);
    writer.writeBytes(offsets[9], _clientRevBy);
    writer.writeBytes(offsets[10], _serverRevAt);
    writer.writeBool(offsets[11], _deleted);
    if (!(object.project as IsarLinkImpl).attached) {
      (object.project as IsarLinkImpl).attach(
        collection,
        collection.isar.projects as IsarCollectionImpl<Project>,
        object,
        0,
        false,
      );
    }
    if (!(object.table as IsarLinkImpl).attached) {
      (object.table as IsarLinkImpl).attach(
        collection,
        collection,
        object,
        1,
        false,
      );
    }
    return bufferSize;
  }

  @override
  Table deserialize(IsarCollectionImpl<Table> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Table();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.name = reader.readStringOrNull(offsets[2]);
    object.label = reader.readStringOrNull(offsets[3]);
    object.relType = reader.readStringOrNull(offsets[4]);
    object.isOptions = reader.readBoolOrNull(offsets[5]);
    object.projectId = reader.readStringOrNull(offsets[6]);
    object.parentId = reader.readStringOrNull(offsets[7]);
    object.clientRevAt = reader.readStringOrNull(offsets[8]);
    object.clientRevBy = reader.readStringOrNull(offsets[9]);
    object.serverRevAt = reader.readStringOrNull(offsets[10]);
    object.deleted = reader.readBool(offsets[11]);
    object.project = IsarLinkImpl()
      ..attach(
        collection,
        collection.isar.projects as IsarCollectionImpl<Project>,
        object,
        0,
        false,
      );
    object.table = IsarLinkImpl()
      ..attach(
        collection,
        collection,
        object,
        1,
        false,
      );

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
        return (reader.readBoolOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension GetCollection on Isar {
  IsarCollection<Account> get accounts {
    return getCollection('Account');
  }

  IsarCollection<Project> get projects {
    return getCollection('Project');
  }

  IsarCollection<Operation> get operations {
    return getCollection('Operation');
  }

  IsarCollection<Table> get tables {
    return getCollection('Table');
  }
}

extension AccountQueryWhereSort on QueryBuilder<Account, QWhere> {
  QueryBuilder<Account, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Account, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension AccountQueryWhere on QueryBuilder<Account, QWhereClause> {
  QueryBuilder<Account, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> nameNotEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'name',
      lower: [name],
      includeLower: false,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> nameIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> nameIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: false,
    ));
  }
}

extension ProjectQueryWhereSort on QueryBuilder<Project, QWhere> {
  QueryBuilder<Project, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Project, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension ProjectQueryWhere on QueryBuilder<Project, QWhereClause> {
  QueryBuilder<Project, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> idNotEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> nameNotEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'name',
      lower: [name],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> nameIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> nameIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> serverRevAtNotEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: false,
    ));
  }
}

extension OperationQueryWhereSort on QueryBuilder<Operation, QWhere> {
  QueryBuilder<Operation, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<Operation, QAfterWhere> anyTime() {
    return addWhereClause(WhereClause(indexName: 'time'));
  }
}

extension OperationQueryWhere on QueryBuilder<Operation, QWhereClause> {
  QueryBuilder<Operation, QAfterWhereClause> timeEqualTo(DateTime time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: true,
      lower: [time],
      includeLower: true,
    ));
  }

  QueryBuilder<Operation, QAfterWhereClause> timeNotEqualTo(DateTime time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'time',
      lower: [time],
      includeLower: false,
    ));
  }

  QueryBuilder<Operation, QAfterWhereClause> timeBetween(
      DateTime lower, DateTime upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }
}

extension TableQueryWhereSort on QueryBuilder<Table, QWhere> {
  QueryBuilder<Table, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Table, QAfterWhere> anyIsOptions() {
    return addWhereClause(WhereClause(indexName: 'isOptions'));
  }

  QueryBuilder<Table, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension TableQueryWhere on QueryBuilder<Table, QWhereClause> {
  QueryBuilder<Table, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> idNotEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> nameNotEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'name',
      lower: [name],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> nameIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> nameIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> nameProjectIdEqualTo(
      String? name, String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name, projectId],
      includeUpper: true,
      lower: [name, projectId],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> nameProjectIdNotEqualTo(
      String? name, String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name, projectId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'name',
      lower: [name, projectId],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> isOptionsEqualTo(bool? isOptions) {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      upper: [isOptions],
      includeUpper: true,
      lower: [isOptions],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> isOptionsNotEqualTo(bool? isOptions) {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      upper: [isOptions],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'isOptions',
      lower: [isOptions],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> isOptionsIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> isOptionsIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> serverRevAtNotEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Table, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: false,
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

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevAtContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
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

  QueryBuilder<Account, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> clientRevByContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
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

  QueryBuilder<Account, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
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

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevAtContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
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

  QueryBuilder<Project, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> clientRevByContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
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

  QueryBuilder<Project, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension OperationQueryFilter on QueryBuilder<Operation, QFilterCondition> {
  QueryBuilder<Operation, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> idBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> timeEqualTo(DateTime value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> timeGreaterThan(
      DateTime value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> timeLessThan(DateTime value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> timeBetween(
      DateTime lower, DateTime upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'time',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> tableIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'table',
      value: null,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> tableEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> tableStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'table',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> tableEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'table',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> tableContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'table',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> tableMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'table',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> dataIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'data',
      value: null,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> dataEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> dataStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'data',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> dataEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'data',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> dataContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'data',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Operation, QAfterFilterCondition> dataMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'data',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension TableQueryFilter on QueryBuilder<Table, QFilterCondition> {
  QueryBuilder<Table, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> nameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> nameStartsWith(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> nameEndsWith(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> nameContains(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> labelEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> labelStartsWith(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> labelEndsWith(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> labelContains(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> relTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'relType',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> relTypeEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> relTypeStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'relType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> relTypeEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'relType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> relTypeContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'relType',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> relTypeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'relType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> isOptionsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isOptions',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> isOptionsEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isOptions',
      value: value,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> projectIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> projectIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'projectId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> projectIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'projectId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> projectIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'projectId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> projectIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> parentIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentId',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> parentIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> parentIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'parentId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> parentIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'parentId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> parentIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> parentIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevAtStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevAtEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevAt',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevAtContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevByStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevByEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'clientRevBy',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevByContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> clientRevByMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<Table, QAfterFilterCondition> serverRevAtEndsWith(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> serverRevAtContains(String? value,
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

  QueryBuilder<Table, QAfterFilterCondition> serverRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Table, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension AccountQueryLinks on QueryBuilder<Account, QFilterCondition> {
  QueryBuilder<Account, QAfterFilterCondition> project(FilterQuery<Project> q) {
    return linkInternal(
      isar.projects,
      q,
      'project',
    );
  }
}

extension ProjectQueryLinks on QueryBuilder<Project, QFilterCondition> {
  QueryBuilder<Project, QAfterFilterCondition> account(FilterQuery<Account> q) {
    return linkInternal(
      isar.accounts,
      q,
      'account',
    );
  }
}

extension OperationQueryLinks on QueryBuilder<Operation, QFilterCondition> {}

extension TableQueryLinks on QueryBuilder<Table, QFilterCondition> {
  QueryBuilder<Table, QAfterFilterCondition> project(FilterQuery<Project> q) {
    return linkInternal(
      isar.projects,
      q,
      'project',
    );
  }

  QueryBuilder<Table, QAfterFilterCondition> table(FilterQuery<Table> q) {
    return linkInternal(
      isar.tables,
      q,
      'table',
    );
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

  QueryBuilder<Account, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
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

  QueryBuilder<Account, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

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

  QueryBuilder<Project, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
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

  QueryBuilder<Project, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension OperationQueryWhereSortBy on QueryBuilder<Operation, QSortBy> {
  QueryBuilder<Operation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.Desc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByTable() {
    return addSortByInternal('table', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByTableDesc() {
    return addSortByInternal('table', Sort.Desc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByData() {
    return addSortByInternal('data', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> sortByDataDesc() {
    return addSortByInternal('data', Sort.Desc);
  }
}

extension OperationQueryWhereSortThenBy
    on QueryBuilder<Operation, QSortThenBy> {
  QueryBuilder<Operation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.Desc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByTable() {
    return addSortByInternal('table', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByTableDesc() {
    return addSortByInternal('table', Sort.Desc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByData() {
    return addSortByInternal('data', Sort.Asc);
  }

  QueryBuilder<Operation, QAfterSortBy> thenByDataDesc() {
    return addSortByInternal('data', Sort.Desc);
  }
}

extension TableQueryWhereSortBy on QueryBuilder<Table, QSortBy> {
  QueryBuilder<Table, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByRelType() {
    return addSortByInternal('relType', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByRelTypeDesc() {
    return addSortByInternal('relType', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByIsOptions() {
    return addSortByInternal('isOptions', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByIsOptionsDesc() {
    return addSortByInternal('isOptions', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByParentId() {
    return addSortByInternal('parentId', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByParentIdDesc() {
    return addSortByInternal('parentId', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension TableQueryWhereSortThenBy on QueryBuilder<Table, QSortThenBy> {
  QueryBuilder<Table, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByRelType() {
    return addSortByInternal('relType', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByRelTypeDesc() {
    return addSortByInternal('relType', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByIsOptions() {
    return addSortByInternal('isOptions', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByIsOptionsDesc() {
    return addSortByInternal('isOptions', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByParentId() {
    return addSortByInternal('parentId', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByParentIdDesc() {
    return addSortByInternal('parentId', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Table, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
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

  QueryBuilder<Account, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
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

  QueryBuilder<Project, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension OperationQueryWhereDistinct on QueryBuilder<Operation, QDistinct> {
  QueryBuilder<Operation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Operation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }

  QueryBuilder<Operation, QDistinct> distinctByTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('table', caseSensitive: caseSensitive);
  }

  QueryBuilder<Operation, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('data', caseSensitive: caseSensitive);
  }
}

extension TableQueryWhereDistinct on QueryBuilder<Table, QDistinct> {
  QueryBuilder<Table, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Table, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByLabel({bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByRelType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('relType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByIsOptions() {
    return addDistinctByInternal('isOptions');
  }

  QueryBuilder<Table, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Table, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
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

  QueryBuilder<String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
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

  QueryBuilder<String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}

extension OperationQueryProperty on QueryBuilder<Operation, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<DateTime, QQueryOperations> timeProperty() {
    return addPropertyName('time');
  }

  QueryBuilder<String?, QQueryOperations> tableProperty() {
    return addPropertyName('table');
  }

  QueryBuilder<String?, QQueryOperations> dataProperty() {
    return addPropertyName('data');
  }
}

extension TableQueryProperty on QueryBuilder<Table, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<String?, QQueryOperations> relTypeProperty() {
    return addPropertyName('relType');
  }

  QueryBuilder<bool?, QQueryOperations> isOptionsProperty() {
    return addPropertyName('isOptions');
  }

  QueryBuilder<String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<String?, QQueryOperations> parentIdProperty() {
    return addPropertyName('parentId');
  }

  QueryBuilder<String?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
