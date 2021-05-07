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
import 'models/field.dart';
import 'models/fieldType.dart';
import 'models/operation.dart';
import 'models/optionType.dart';
import 'models/project.dart';
import 'models/projectUser.dart';
import 'models/relType.dart';
import 'models/row.dart';
import 'models/table.dart';
import 'models/user.dart';
import 'models/widgetsForField.dart';
import 'models/widgetType.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"Account","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"serviceId","type":5},{"name":"managerId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"manager","collection":"CUser"}]},{"name":"Field","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"tableId","type":5},{"name":"name","type":5},{"name":"label","type":5},{"name":"isInternalId","type":0},{"name":"fieldType","type":5},{"name":"widgetType","type":5},{"name":"optionsTable","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"tableId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true},{"name":"tableId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"FieldType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Operation","idProperty":"id","properties":[{"name":"id","type":3},{"name":"time","type":3},{"name":"table","type":5},{"name":"data","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"time","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"OptionType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"value","type":5},{"name":"saveId","type":0},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Project","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"accountId","type":5},{"name":"label","type":5},{"name":"srsId","type":3},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"account","collection":"Account"}]},{"name":"ProjectUser","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"projectId","type":5},{"name":"userEmail","type":5},{"name":"role","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"projectId","indexType":1,"caseSensitive":true},{"name":"userEmail","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"project","collection":"Project"}]},{"name":"RelType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Crow","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"tableId","type":5},{"name":"geometry","type":5},{"name":"data","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0},{"name":"rev","type":5},{"name":"parentRev","type":5},{"name":"revisions","type":11},{"name":"depth","type":3},{"name":"conflicts","type":11}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"tableId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Ctable","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"label","type":5},{"name":"labelFields","type":11},{"name":"labelFieldsSeparator","type":5},{"name":"relType","type":5},{"name":"isOptions","type":0},{"name":"optionType","type":0},{"name":"projectId","type":5},{"name":"parentId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true},{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"isOptions","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"optionType","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"project","collection":"Project"},{"name":"parent","collection":"Ctable"}]},{"name":"CUser","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"email","type":5},{"name":"accountId","type":5},{"name":"authId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"email","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[{"name":"account","collection":"Account"}]},{"name":"WidgetsForField","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"fieldValue","type":5},{"name":"widgetValue","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"fieldValue","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"widgetValue","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"WidgetType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"needsList","type":0},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]}]';

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
        final propertyOffsetsPtr = malloc<Uint32>(15);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(15);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
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
            'serviceId': 2,
            'managerId': 3,
            'clientRevAt': 4,
            'clientRevBy': 5,
            'serverRevAt': 6,
            'deleted': 7
          },
          indexIds: {'id': 0, 'deleted': 1},
          linkIds: {'manager': 0},
          backlinkIds: {'projects': 0},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 1));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Field'] = IsarCollectionImpl<Field>(
          isar: isar,
          adapter: _FieldAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 13),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'tableId': 2,
            'name': 3,
            'label': 4,
            'isInternalId': 5,
            'fieldType': 6,
            'widgetType': 7,
            'optionsTable': 8,
            'clientRevAt': 9,
            'clientRevBy': 10,
            'serverRevAt': 11,
            'deleted': 12
          },
          indexIds: {
            'id': 0,
            'tableId': 1,
            'name': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 2));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['FieldType'] = IsarCollectionImpl<FieldType>(
          isar: isar,
          adapter: _FieldTypeAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 6),
          propertyIds: {
            'isarId': 0,
            'value': 1,
            'sort': 2,
            'comment': 3,
            'serverRevAt': 4,
            'deleted': 5
          },
          indexIds: {'value': 0, 'sort': 1, 'serverRevAt': 2, 'deleted': 3},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 3));
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
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 4));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['OptionType'] = IsarCollectionImpl<OptionType>(
          isar: isar,
          adapter: _OptionTypeAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 8),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'value': 2,
            'saveId': 3,
            'sort': 4,
            'comment': 5,
            'serverRevAt': 6,
            'deleted': 7
          },
          indexIds: {
            'id': 0,
            'value': 1,
            'sort': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 5));
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
          backlinkIds: {'projectUsers': 0},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 6));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['ProjectUser'] = IsarCollectionImpl<ProjectUser>(
          isar: isar,
          adapter: _ProjectUserAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 9),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'projectId': 2,
            'userEmail': 3,
            'role': 4,
            'clientRevAt': 5,
            'clientRevBy': 6,
            'serverRevAt': 7,
            'deleted': 8
          },
          indexIds: {'id': 0, 'projectId': 1, 'serverRevAt': 2, 'deleted': 3},
          linkIds: {'project': 0},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 7));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['RelType'] = IsarCollectionImpl<RelType>(
          isar: isar,
          adapter: _RelTypeAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 6),
          propertyIds: {
            'isarId': 0,
            'value': 1,
            'sort': 2,
            'comment': 3,
            'serverRevAt': 4,
            'deleted': 5
          },
          indexIds: {'value': 0, 'sort': 1, 'serverRevAt': 2, 'deleted': 3},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 8));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Crow'] = IsarCollectionImpl<Crow>(
          isar: isar,
          adapter: _CrowAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 14),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'tableId': 2,
            'geometry': 3,
            'data': 4,
            'clientRevAt': 5,
            'clientRevBy': 6,
            'serverRevAt': 7,
            'deleted': 8,
            'rev': 9,
            'parentRev': 10,
            'revisions': 11,
            'depth': 12,
            'conflicts': 13
          },
          indexIds: {'id': 0, 'tableId': 1, 'serverRevAt': 2, 'deleted': 3},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 9));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Ctable'] = IsarCollectionImpl<Ctable>(
          isar: isar,
          adapter: _CtableAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 15),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'label': 3,
            'labelFields': 4,
            'labelFieldsSeparator': 5,
            'relType': 6,
            'isOptions': 7,
            'optionType': 8,
            'projectId': 9,
            'parentId': 10,
            'clientRevAt': 11,
            'clientRevBy': 12,
            'serverRevAt': 13,
            'deleted': 14
          },
          indexIds: {
            'id': 0,
            'name': 1,
            'isOptions': 2,
            'optionType': 3,
            'projectId': 4,
            'serverRevAt': 5,
            'deleted': 6
          },
          linkIds: {'project': 0, 'parent': 1},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 10));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['CUser'] = IsarCollectionImpl<CUser>(
          isar: isar,
          adapter: _CUserAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 10),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'email': 3,
            'accountId': 4,
            'authId': 5,
            'clientRevAt': 6,
            'clientRevBy': 7,
            'serverRevAt': 8,
            'deleted': 9
          },
          indexIds: {
            'id': 0,
            'name': 1,
            'email': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          linkIds: {'account': 0},
          backlinkIds: {'projectUsers': 0},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 11));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['WidgetsForField'] = IsarCollectionImpl<WidgetsForField>(
          isar: isar,
          adapter: _WidgetsForFieldAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 5),
          propertyIds: {
            'isarId': 0,
            'fieldValue': 1,
            'widgetValue': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          indexIds: {
            'fieldValue': 0,
            'widgetValue': 1,
            'serverRevAt': 2,
            'deleted': 3
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 12));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['WidgetType'] = IsarCollectionImpl<WidgetType>(
          isar: isar,
          adapter: _WidgetTypeAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 7),
          propertyIds: {
            'isarId': 0,
            'value': 1,
            'needsList': 2,
            'sort': 3,
            'comment': 4,
            'serverRevAt': 5,
            'deleted': 6
          },
          indexIds: {'value': 0, 'sort': 1, 'serverRevAt': 2, 'deleted': 3},
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
    final value2 = object.serviceId;
    Uint8List? _serviceId;
    if (value2 != null) {
      _serviceId = _utf8Encoder.convert(value2);
    }
    dynamicSize += _serviceId?.length ?? 0;
    final value3 = object.managerId;
    Uint8List? _managerId;
    if (value3 != null) {
      _managerId = _utf8Encoder.convert(value3);
    }
    dynamicSize += _managerId?.length ?? 0;
    final value4 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value4 != null) {
      _clientRevAt = _utf8Encoder.convert(value4);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value5 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value5 != null) {
      _clientRevBy = _utf8Encoder.convert(value5);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value6 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value6 != null) {
      _serverRevAt = _utf8Encoder.convert(value6);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value7 = object.deleted;
    final _deleted = value7;
    final size = dynamicSize + 59;

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
    final writer = BinaryWriter(buffer, 59);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _serviceId);
    writer.writeBytes(offsets[3], _managerId);
    writer.writeBytes(offsets[4], _clientRevAt);
    writer.writeBytes(offsets[5], _clientRevBy);
    writer.writeBytes(offsets[6], _serverRevAt);
    writer.writeBool(offsets[7], _deleted);
    if (!(object.manager as IsarLinkImpl).attached) {
      (object.manager as IsarLinkImpl).attach(
        collection,
        collection.isar.cUsers as IsarCollectionImpl<CUser>,
        object,
        0,
        false,
      );
    }
    if (!(object.projects as IsarLinksImpl).attached) {
      (object.projects as IsarLinksImpl).attach(
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
    object.serviceId = reader.readStringOrNull(offsets[2]);
    object.managerId = reader.readStringOrNull(offsets[3]);
    object.clientRevAt = reader.readStringOrNull(offsets[4]);
    object.clientRevBy = reader.readStringOrNull(offsets[5]);
    object.serverRevAt = reader.readStringOrNull(offsets[6]);
    object.deleted = reader.readBool(offsets[7]);
    object.manager = IsarLinkImpl()
      ..attach(
        collection,
        collection.isar.cUsers as IsarCollectionImpl<CUser>,
        object,
        0,
        false,
      );
    object.projects = IsarLinksImpl()
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
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _FieldAdapter extends TypeAdapter<Field> {
  @override
  int serialize(IsarCollectionImpl<Field> collection, RawObject rawObj,
      Field object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.tableId;
    Uint8List? _tableId;
    if (value2 != null) {
      _tableId = _utf8Encoder.convert(value2);
    }
    dynamicSize += _tableId?.length ?? 0;
    final value3 = object.name;
    Uint8List? _name;
    if (value3 != null) {
      _name = _utf8Encoder.convert(value3);
    }
    dynamicSize += _name?.length ?? 0;
    final value4 = object.label;
    Uint8List? _label;
    if (value4 != null) {
      _label = _utf8Encoder.convert(value4);
    }
    dynamicSize += _label?.length ?? 0;
    final value5 = object.isInternalId;
    final _isInternalId = value5;
    final value6 = object.fieldType;
    Uint8List? _fieldType;
    if (value6 != null) {
      _fieldType = _utf8Encoder.convert(value6);
    }
    dynamicSize += _fieldType?.length ?? 0;
    final value7 = object.widgetType;
    Uint8List? _widgetType;
    if (value7 != null) {
      _widgetType = _utf8Encoder.convert(value7);
    }
    dynamicSize += _widgetType?.length ?? 0;
    final value8 = object.optionsTable;
    Uint8List? _optionsTable;
    if (value8 != null) {
      _optionsTable = _utf8Encoder.convert(value8);
    }
    dynamicSize += _optionsTable?.length ?? 0;
    final value9 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value9 != null) {
      _clientRevAt = _utf8Encoder.convert(value9);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value10 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value10 != null) {
      _clientRevBy = _utf8Encoder.convert(value10);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value11 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value11 != null) {
      _serverRevAt = _utf8Encoder.convert(value11);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value12 = object.deleted;
    final _deleted = value12;
    final size = dynamicSize + 92;

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
    final writer = BinaryWriter(buffer, 92);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _tableId);
    writer.writeBytes(offsets[3], _name);
    writer.writeBytes(offsets[4], _label);
    writer.writeBool(offsets[5], _isInternalId);
    writer.writeBytes(offsets[6], _fieldType);
    writer.writeBytes(offsets[7], _widgetType);
    writer.writeBytes(offsets[8], _optionsTable);
    writer.writeBytes(offsets[9], _clientRevAt);
    writer.writeBytes(offsets[10], _clientRevBy);
    writer.writeBytes(offsets[11], _serverRevAt);
    writer.writeBool(offsets[12], _deleted);
    return bufferSize;
  }

  @override
  Field deserialize(IsarCollectionImpl<Field> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Field();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.tableId = reader.readStringOrNull(offsets[2]);
    object.name = reader.readStringOrNull(offsets[3]);
    object.label = reader.readStringOrNull(offsets[4]);
    object.isInternalId = reader.readBoolOrNull(offsets[5]);
    object.fieldType = reader.readStringOrNull(offsets[6]);
    object.widgetType = reader.readStringOrNull(offsets[7]);
    object.optionsTable = reader.readStringOrNull(offsets[8]);
    object.clientRevAt = reader.readStringOrNull(offsets[9]);
    object.clientRevBy = reader.readStringOrNull(offsets[10]);
    object.serverRevAt = reader.readStringOrNull(offsets[11]);
    object.deleted = reader.readBool(offsets[12]);
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
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _FieldTypeAdapter extends TypeAdapter<FieldType> {
  @override
  int serialize(IsarCollectionImpl<FieldType> collection, RawObject rawObj,
      FieldType object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.value;
    Uint8List? _value;
    if (value1 != null) {
      _value = _utf8Encoder.convert(value1);
    }
    dynamicSize += _value?.length ?? 0;
    final value2 = object.sort;
    final _sort = value2;
    final value3 = object.comment;
    Uint8List? _comment;
    if (value3 != null) {
      _comment = _utf8Encoder.convert(value3);
    }
    dynamicSize += _comment?.length ?? 0;
    final value4 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value4 != null) {
      _serverRevAt = _utf8Encoder.convert(value4);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value5 = object.deleted;
    final _deleted = value5;
    final size = dynamicSize + 43;

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
    final writer = BinaryWriter(buffer, 43);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _value);
    writer.writeLong(offsets[2], _sort);
    writer.writeBytes(offsets[3], _comment);
    writer.writeBytes(offsets[4], _serverRevAt);
    writer.writeBool(offsets[5], _deleted);
    return bufferSize;
  }

  @override
  FieldType deserialize(IsarCollectionImpl<FieldType> collection,
      BinaryReader reader, List<int> offsets) {
    final object = FieldType();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.value = reader.readStringOrNull(offsets[1]);
    object.sort = reader.readLongOrNull(offsets[2]);
    object.comment = reader.readStringOrNull(offsets[3]);
    object.serverRevAt = reader.readStringOrNull(offsets[4]);
    object.deleted = reader.readBool(offsets[5]);
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
        return (reader.readLongOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
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

class _OptionTypeAdapter extends TypeAdapter<OptionType> {
  @override
  int serialize(IsarCollectionImpl<OptionType> collection, RawObject rawObj,
      OptionType object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.value;
    Uint8List? _value;
    if (value2 != null) {
      _value = _utf8Encoder.convert(value2);
    }
    dynamicSize += _value?.length ?? 0;
    final value3 = object.saveId;
    final _saveId = value3;
    final value4 = object.sort;
    final _sort = value4;
    final value5 = object.comment;
    Uint8List? _comment;
    if (value5 != null) {
      _comment = _utf8Encoder.convert(value5);
    }
    dynamicSize += _comment?.length ?? 0;
    final value6 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value6 != null) {
      _serverRevAt = _utf8Encoder.convert(value6);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value7 = object.deleted;
    final _deleted = value7;
    final size = dynamicSize + 52;

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
    final writer = BinaryWriter(buffer, 52);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _value);
    writer.writeBool(offsets[3], _saveId);
    writer.writeLong(offsets[4], _sort);
    writer.writeBytes(offsets[5], _comment);
    writer.writeBytes(offsets[6], _serverRevAt);
    writer.writeBool(offsets[7], _deleted);
    return bufferSize;
  }

  @override
  OptionType deserialize(IsarCollectionImpl<OptionType> collection,
      BinaryReader reader, List<int> offsets) {
    final object = OptionType();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.value = reader.readStringOrNull(offsets[2]);
    object.saveId = reader.readBoolOrNull(offsets[3]);
    object.sort = reader.readLongOrNull(offsets[4]);
    object.comment = reader.readStringOrNull(offsets[5]);
    object.serverRevAt = reader.readStringOrNull(offsets[6]);
    object.deleted = reader.readBool(offsets[7]);
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
        return (reader.readBoolOrNull(offset)) as P;
      case 4:
        return (reader.readLongOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
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
    if (!(object.projectUsers as IsarLinksImpl).attached) {
      (object.projectUsers as IsarLinksImpl).attach(
        collection,
        collection.isar.projectUsers as IsarCollectionImpl<ProjectUser>,
        object,
        0,
        true,
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
    object.projectUsers = IsarLinksImpl()
      ..attach(
        collection,
        collection.isar.projectUsers as IsarCollectionImpl<ProjectUser>,
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

class _ProjectUserAdapter extends TypeAdapter<ProjectUser> {
  @override
  int serialize(IsarCollectionImpl<ProjectUser> collection, RawObject rawObj,
      ProjectUser object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.projectId;
    Uint8List? _projectId;
    if (value2 != null) {
      _projectId = _utf8Encoder.convert(value2);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value3 = object.userEmail;
    Uint8List? _userEmail;
    if (value3 != null) {
      _userEmail = _utf8Encoder.convert(value3);
    }
    dynamicSize += _userEmail?.length ?? 0;
    final value4 = object.role;
    Uint8List? _role;
    if (value4 != null) {
      _role = _utf8Encoder.convert(value4);
    }
    dynamicSize += _role?.length ?? 0;
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
    writer.writeBytes(offsets[2], _projectId);
    writer.writeBytes(offsets[3], _userEmail);
    writer.writeBytes(offsets[4], _role);
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
        false,
      );
    }
    return bufferSize;
  }

  @override
  ProjectUser deserialize(IsarCollectionImpl<ProjectUser> collection,
      BinaryReader reader, List<int> offsets) {
    final object = ProjectUser();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.projectId = reader.readStringOrNull(offsets[2]);
    object.userEmail = reader.readStringOrNull(offsets[3]);
    object.role = reader.readStringOrNull(offsets[4]);
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

class _RelTypeAdapter extends TypeAdapter<RelType> {
  @override
  int serialize(IsarCollectionImpl<RelType> collection, RawObject rawObj,
      RelType object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.value;
    Uint8List? _value;
    if (value1 != null) {
      _value = _utf8Encoder.convert(value1);
    }
    dynamicSize += _value?.length ?? 0;
    final value2 = object.sort;
    final _sort = value2;
    final value3 = object.comment;
    Uint8List? _comment;
    if (value3 != null) {
      _comment = _utf8Encoder.convert(value3);
    }
    dynamicSize += _comment?.length ?? 0;
    final value4 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value4 != null) {
      _serverRevAt = _utf8Encoder.convert(value4);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value5 = object.deleted;
    final _deleted = value5;
    final size = dynamicSize + 43;

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
    final writer = BinaryWriter(buffer, 43);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _value);
    writer.writeLong(offsets[2], _sort);
    writer.writeBytes(offsets[3], _comment);
    writer.writeBytes(offsets[4], _serverRevAt);
    writer.writeBool(offsets[5], _deleted);
    return bufferSize;
  }

  @override
  RelType deserialize(IsarCollectionImpl<RelType> collection,
      BinaryReader reader, List<int> offsets) {
    final object = RelType();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.value = reader.readStringOrNull(offsets[1]);
    object.sort = reader.readLongOrNull(offsets[2]);
    object.comment = reader.readStringOrNull(offsets[3]);
    object.serverRevAt = reader.readStringOrNull(offsets[4]);
    object.deleted = reader.readBool(offsets[5]);
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
        return (reader.readLongOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _CrowAdapter extends TypeAdapter<Crow> {
  @override
  int serialize(IsarCollectionImpl<Crow> collection, RawObject rawObj,
      Crow object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.tableId;
    Uint8List? _tableId;
    if (value2 != null) {
      _tableId = _utf8Encoder.convert(value2);
    }
    dynamicSize += _tableId?.length ?? 0;
    final value3 = object.geometry;
    Uint8List? _geometry;
    if (value3 != null) {
      _geometry = _utf8Encoder.convert(value3);
    }
    dynamicSize += _geometry?.length ?? 0;
    final value4 = object.data;
    Uint8List? _data;
    if (value4 != null) {
      _data = _utf8Encoder.convert(value4);
    }
    dynamicSize += _data?.length ?? 0;
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
    final value9 = object.rev;
    Uint8List? _rev;
    if (value9 != null) {
      _rev = _utf8Encoder.convert(value9);
    }
    dynamicSize += _rev?.length ?? 0;
    final value10 = object.parentRev;
    Uint8List? _parentRev;
    if (value10 != null) {
      _parentRev = _utf8Encoder.convert(value10);
    }
    dynamicSize += _parentRev?.length ?? 0;
    final value11 = object.revisions;
    dynamicSize += (value11?.length ?? 0) * 8;
    List<Uint8List?>? bytesList11;
    if (value11 != null) {
      bytesList11 = [];
      for (var str in value11) {
        final bytes = _utf8Encoder.convert(str);
        bytesList11.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _revisions = bytesList11;
    final value12 = object.depth;
    final _depth = value12;
    final value13 = object.conflicts;
    dynamicSize += (value13?.length ?? 0) * 8;
    List<Uint8List?>? bytesList13;
    if (value13 != null) {
      bytesList13 = [];
      for (var str in value13) {
        final bytes = _utf8Encoder.convert(str);
        bytesList13.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _conflicts = bytesList13;
    final size = dynamicSize + 107;

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
    final writer = BinaryWriter(buffer, 107);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _tableId);
    writer.writeBytes(offsets[3], _geometry);
    writer.writeBytes(offsets[4], _data);
    writer.writeBytes(offsets[5], _clientRevAt);
    writer.writeBytes(offsets[6], _clientRevBy);
    writer.writeBytes(offsets[7], _serverRevAt);
    writer.writeBool(offsets[8], _deleted);
    writer.writeBytes(offsets[9], _rev);
    writer.writeBytes(offsets[10], _parentRev);
    writer.writeStringList(offsets[11], _revisions);
    writer.writeLong(offsets[12], _depth);
    writer.writeStringList(offsets[13], _conflicts);
    return bufferSize;
  }

  @override
  Crow deserialize(IsarCollectionImpl<Crow> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Crow();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.tableId = reader.readStringOrNull(offsets[2]);
    object.geometry = reader.readStringOrNull(offsets[3]);
    object.data = reader.readStringOrNull(offsets[4]);
    object.clientRevAt = reader.readStringOrNull(offsets[5]);
    object.clientRevBy = reader.readStringOrNull(offsets[6]);
    object.serverRevAt = reader.readStringOrNull(offsets[7]);
    object.deleted = reader.readBool(offsets[8]);
    object.rev = reader.readStringOrNull(offsets[9]);
    object.parentRev = reader.readStringOrNull(offsets[10]);
    object.revisions = reader.readStringList(offsets[11]);
    object.depth = reader.readLongOrNull(offsets[12]);
    object.conflicts = reader.readStringList(offsets[13]);
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
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringList(offset)) as P;
      case 12:
        return (reader.readLongOrNull(offset)) as P;
      case 13:
        return (reader.readStringList(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _CtableAdapter extends TypeAdapter<Ctable> {
  @override
  int serialize(IsarCollectionImpl<Ctable> collection, RawObject rawObj,
      Ctable object, List<int> offsets,
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
    final value4 = object.labelFields;
    dynamicSize += (value4?.length ?? 0) * 8;
    List<Uint8List?>? bytesList4;
    if (value4 != null) {
      bytesList4 = [];
      for (var str in value4) {
        final bytes = _utf8Encoder.convert(str);
        bytesList4.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _labelFields = bytesList4;
    final value5 = object.labelFieldsSeparator;
    Uint8List? _labelFieldsSeparator;
    if (value5 != null) {
      _labelFieldsSeparator = _utf8Encoder.convert(value5);
    }
    dynamicSize += _labelFieldsSeparator?.length ?? 0;
    final value6 = object.relType;
    Uint8List? _relType;
    if (value6 != null) {
      _relType = _utf8Encoder.convert(value6);
    }
    dynamicSize += _relType?.length ?? 0;
    final value7 = object.isOptions;
    final _isOptions = value7;
    final value8 = object.optionType;
    final _optionType = value8;
    final value9 = object.projectId;
    Uint8List? _projectId;
    if (value9 != null) {
      _projectId = _utf8Encoder.convert(value9);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value10 = object.parentId;
    Uint8List? _parentId;
    if (value10 != null) {
      _parentId = _utf8Encoder.convert(value10);
    }
    dynamicSize += _parentId?.length ?? 0;
    final value11 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value11 != null) {
      _clientRevAt = _utf8Encoder.convert(value11);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value12 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value12 != null) {
      _clientRevBy = _utf8Encoder.convert(value12);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value13 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value13 != null) {
      _serverRevAt = _utf8Encoder.convert(value13);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value14 = object.deleted;
    final _deleted = value14;
    final size = dynamicSize + 101;

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
    final writer = BinaryWriter(buffer, 101);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _label);
    writer.writeStringList(offsets[4], _labelFields);
    writer.writeBytes(offsets[5], _labelFieldsSeparator);
    writer.writeBytes(offsets[6], _relType);
    writer.writeBool(offsets[7], _isOptions);
    writer.writeBool(offsets[8], _optionType);
    writer.writeBytes(offsets[9], _projectId);
    writer.writeBytes(offsets[10], _parentId);
    writer.writeBytes(offsets[11], _clientRevAt);
    writer.writeBytes(offsets[12], _clientRevBy);
    writer.writeBytes(offsets[13], _serverRevAt);
    writer.writeBool(offsets[14], _deleted);
    if (!(object.project as IsarLinkImpl).attached) {
      (object.project as IsarLinkImpl).attach(
        collection,
        collection.isar.projects as IsarCollectionImpl<Project>,
        object,
        0,
        false,
      );
    }
    if (!(object.parent as IsarLinkImpl).attached) {
      (object.parent as IsarLinkImpl).attach(
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
  Ctable deserialize(IsarCollectionImpl<Ctable> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Ctable();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.name = reader.readStringOrNull(offsets[2]);
    object.label = reader.readStringOrNull(offsets[3]);
    object.labelFields = reader.readStringList(offsets[4]);
    object.labelFieldsSeparator = reader.readStringOrNull(offsets[5]);
    object.relType = reader.readStringOrNull(offsets[6]);
    object.isOptions = reader.readBoolOrNull(offsets[7]);
    object.optionType = reader.readBoolOrNull(offsets[8]);
    object.projectId = reader.readStringOrNull(offsets[9]);
    object.parentId = reader.readStringOrNull(offsets[10]);
    object.clientRevAt = reader.readStringOrNull(offsets[11]);
    object.clientRevBy = reader.readStringOrNull(offsets[12]);
    object.serverRevAt = reader.readStringOrNull(offsets[13]);
    object.deleted = reader.readBool(offsets[14]);
    object.project = IsarLinkImpl()
      ..attach(
        collection,
        collection.isar.projects as IsarCollectionImpl<Project>,
        object,
        0,
        false,
      );
    object.parent = IsarLinkImpl()
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
        return (reader.readStringList(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readBoolOrNull(offset)) as P;
      case 8:
        return (reader.readBoolOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _CUserAdapter extends TypeAdapter<CUser> {
  @override
  int serialize(IsarCollectionImpl<CUser> collection, RawObject rawObj,
      CUser object, List<int> offsets,
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
    final value3 = object.email;
    Uint8List? _email;
    if (value3 != null) {
      _email = _utf8Encoder.convert(value3);
    }
    dynamicSize += _email?.length ?? 0;
    final value4 = object.accountId;
    Uint8List? _accountId;
    if (value4 != null) {
      _accountId = _utf8Encoder.convert(value4);
    }
    dynamicSize += _accountId?.length ?? 0;
    final value5 = object.authId;
    Uint8List? _authId;
    if (value5 != null) {
      _authId = _utf8Encoder.convert(value5);
    }
    dynamicSize += _authId?.length ?? 0;
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
    writer.writeBytes(offsets[3], _email);
    writer.writeBytes(offsets[4], _accountId);
    writer.writeBytes(offsets[5], _authId);
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
    if (!(object.projectUsers as IsarLinksImpl).attached) {
      (object.projectUsers as IsarLinksImpl).attach(
        collection,
        collection.isar.projectUsers as IsarCollectionImpl<ProjectUser>,
        object,
        0,
        true,
      );
    }
    return bufferSize;
  }

  @override
  CUser deserialize(IsarCollectionImpl<CUser> collection, BinaryReader reader,
      List<int> offsets) {
    final object = CUser();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.name = reader.readStringOrNull(offsets[2]);
    object.email = reader.readStringOrNull(offsets[3]);
    object.accountId = reader.readStringOrNull(offsets[4]);
    object.authId = reader.readStringOrNull(offsets[5]);
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
    object.projectUsers = IsarLinksImpl()
      ..attach(
        collection,
        collection.isar.projectUsers as IsarCollectionImpl<ProjectUser>,
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
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _WidgetsForFieldAdapter extends TypeAdapter<WidgetsForField> {
  @override
  int serialize(IsarCollectionImpl<WidgetsForField> collection,
      RawObject rawObj, WidgetsForField object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.fieldValue;
    Uint8List? _fieldValue;
    if (value1 != null) {
      _fieldValue = _utf8Encoder.convert(value1);
    }
    dynamicSize += _fieldValue?.length ?? 0;
    final value2 = object.widgetValue;
    Uint8List? _widgetValue;
    if (value2 != null) {
      _widgetValue = _utf8Encoder.convert(value2);
    }
    dynamicSize += _widgetValue?.length ?? 0;
    final value3 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value3 != null) {
      _serverRevAt = _utf8Encoder.convert(value3);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value4 = object.deleted;
    final _deleted = value4;
    final size = dynamicSize + 35;

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
    final writer = BinaryWriter(buffer, 35);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _fieldValue);
    writer.writeBytes(offsets[2], _widgetValue);
    writer.writeBytes(offsets[3], _serverRevAt);
    writer.writeBool(offsets[4], _deleted);
    return bufferSize;
  }

  @override
  WidgetsForField deserialize(IsarCollectionImpl<WidgetsForField> collection,
      BinaryReader reader, List<int> offsets) {
    final object = WidgetsForField();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.fieldValue = reader.readStringOrNull(offsets[1]);
    object.widgetValue = reader.readStringOrNull(offsets[2]);
    object.serverRevAt = reader.readStringOrNull(offsets[3]);
    object.deleted = reader.readBool(offsets[4]);
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
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _WidgetTypeAdapter extends TypeAdapter<WidgetType> {
  @override
  int serialize(IsarCollectionImpl<WidgetType> collection, RawObject rawObj,
      WidgetType object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.value;
    Uint8List? _value;
    if (value1 != null) {
      _value = _utf8Encoder.convert(value1);
    }
    dynamicSize += _value?.length ?? 0;
    final value2 = object.needsList;
    final _needsList = value2;
    final value3 = object.sort;
    final _sort = value3;
    final value4 = object.comment;
    Uint8List? _comment;
    if (value4 != null) {
      _comment = _utf8Encoder.convert(value4);
    }
    dynamicSize += _comment?.length ?? 0;
    final value5 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value5 != null) {
      _serverRevAt = _utf8Encoder.convert(value5);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value6 = object.deleted;
    final _deleted = value6;
    final size = dynamicSize + 44;

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
    final writer = BinaryWriter(buffer, 44);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _value);
    writer.writeBool(offsets[2], _needsList);
    writer.writeLong(offsets[3], _sort);
    writer.writeBytes(offsets[4], _comment);
    writer.writeBytes(offsets[5], _serverRevAt);
    writer.writeBool(offsets[6], _deleted);
    return bufferSize;
  }

  @override
  WidgetType deserialize(IsarCollectionImpl<WidgetType> collection,
      BinaryReader reader, List<int> offsets) {
    final object = WidgetType();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.value = reader.readStringOrNull(offsets[1]);
    object.needsList = reader.readBoolOrNull(offsets[2]);
    object.sort = reader.readLongOrNull(offsets[3]);
    object.comment = reader.readStringOrNull(offsets[4]);
    object.serverRevAt = reader.readStringOrNull(offsets[5]);
    object.deleted = reader.readBool(offsets[6]);
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
        return (reader.readBoolOrNull(offset)) as P;
      case 3:
        return (reader.readLongOrNull(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
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

  IsarCollection<Field> get fields {
    return getCollection('Field');
  }

  IsarCollection<FieldType> get fieldTypes {
    return getCollection('FieldType');
  }

  IsarCollection<Operation> get operations {
    return getCollection('Operation');
  }

  IsarCollection<OptionType> get optionTypes {
    return getCollection('OptionType');
  }

  IsarCollection<Project> get projects {
    return getCollection('Project');
  }

  IsarCollection<ProjectUser> get projectUsers {
    return getCollection('ProjectUser');
  }

  IsarCollection<RelType> get relTypes {
    return getCollection('RelType');
  }

  IsarCollection<Crow> get crows {
    return getCollection('Crow');
  }

  IsarCollection<Ctable> get ctables {
    return getCollection('Ctable');
  }

  IsarCollection<CUser> get cUsers {
    return getCollection('CUser');
  }

  IsarCollection<WidgetsForField> get widgetsForFields {
    return getCollection('WidgetsForField');
  }

  IsarCollection<WidgetType> get widgetTypes {
    return getCollection('WidgetType');
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
  QueryBuilder<Account, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Account, QAfterWhereClause> idNotEqualTo(String id) {
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

extension FieldQueryWhereSort on QueryBuilder<Field, QWhere> {
  QueryBuilder<Field, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Field, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension FieldQueryWhere on QueryBuilder<Field, QWhereClause> {
  QueryBuilder<Field, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Field, QAfterWhereClause> tableIdEqualTo(String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [tableId],
      includeUpper: true,
      lower: [tableId],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> tableIdNotEqualTo(String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [tableId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [tableId],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> tableIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> tableIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> nameNotEqualTo(String? name) {
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

  QueryBuilder<Field, QAfterWhereClause> nameIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> nameIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> nameTableIdEqualTo(
      String? name, String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name, tableId],
      includeUpper: true,
      lower: [name, tableId],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> nameTableIdNotEqualTo(
      String? name, String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name, tableId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'name',
      lower: [name, tableId],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Field, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension FieldTypeQueryWhereSort on QueryBuilder<FieldType, QWhere> {
  QueryBuilder<FieldType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<FieldType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<FieldType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension FieldTypeQueryWhere on QueryBuilder<FieldType, QWhereClause> {
  QueryBuilder<FieldType, QAfterWhereClause> valueEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: true,
      lower: [value],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> valueNotEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: true,
      lower: [sort],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortNotEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortBetween(int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<FieldType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<FieldType, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension OptionTypeQueryWhereSort on QueryBuilder<OptionType, QWhere> {
  QueryBuilder<OptionType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<OptionType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<OptionType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension OptionTypeQueryWhere on QueryBuilder<OptionType, QWhereClause> {
  QueryBuilder<OptionType, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<OptionType, QAfterWhereClause> valueEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: true,
      lower: [value],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> valueNotEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: true,
      lower: [sort],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortNotEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortBetween(
      int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<OptionType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<OptionType, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension ProjectUserQueryWhereSort on QueryBuilder<ProjectUser, QWhere> {
  QueryBuilder<ProjectUser, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<ProjectUser, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension ProjectUserQueryWhere on QueryBuilder<ProjectUser, QWhereClause> {
  QueryBuilder<ProjectUser, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<ProjectUser, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId],
      includeUpper: true,
      lower: [projectId],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> projectIdNotEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [projectId],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> projectIdUserEmailEqualTo(
      String? projectId, String? userEmail) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId, userEmail],
      includeUpper: true,
      lower: [projectId, userEmail],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> projectIdUserEmailNotEqualTo(
      String? projectId, String? userEmail) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId, userEmail],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [projectId, userEmail],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<ProjectUser, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectUser, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension RelTypeQueryWhereSort on QueryBuilder<RelType, QWhere> {
  QueryBuilder<RelType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<RelType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<RelType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension RelTypeQueryWhere on QueryBuilder<RelType, QWhereClause> {
  QueryBuilder<RelType, QAfterWhereClause> valueEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: true,
      lower: [value],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> valueNotEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: true,
      lower: [sort],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortNotEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortBetween(int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<RelType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<RelType, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension CrowQueryWhereSort on QueryBuilder<Crow, QWhere> {
  QueryBuilder<Crow, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Crow, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CrowQueryWhere on QueryBuilder<Crow, QWhereClause> {
  QueryBuilder<Crow, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Crow, QAfterWhereClause> tableIdEqualTo(String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [tableId],
      includeUpper: true,
      lower: [tableId],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> tableIdNotEqualTo(String? tableId) {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [tableId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [tableId],
      includeLower: false,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> tableIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> tableIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'tableId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Crow, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Crow, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension CtableQueryWhereSort on QueryBuilder<Ctable, QWhere> {
  QueryBuilder<Ctable, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Ctable, QAfterWhere> anyIsOptions() {
    return addWhereClause(WhereClause(indexName: 'isOptions'));
  }

  QueryBuilder<Ctable, QAfterWhere> anyOptionType() {
    return addWhereClause(WhereClause(indexName: 'optionType'));
  }

  QueryBuilder<Ctable, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CtableQueryWhere on QueryBuilder<Ctable, QWhereClause> {
  QueryBuilder<Ctable, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Ctable, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> nameNotEqualTo(String? name) {
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

  QueryBuilder<Ctable, QAfterWhereClause> nameIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> nameIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> nameProjectIdEqualTo(
      String? name, String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name, projectId],
      includeUpper: true,
      lower: [name, projectId],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> nameProjectIdNotEqualTo(
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

  QueryBuilder<Ctable, QAfterWhereClause> isOptionsEqualTo(bool? isOptions) {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      upper: [isOptions],
      includeUpper: true,
      lower: [isOptions],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> isOptionsNotEqualTo(bool? isOptions) {
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

  QueryBuilder<Ctable, QAfterWhereClause> isOptionsIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> isOptionsIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'isOptions',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> optionTypeEqualTo(bool? optionType) {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      upper: [optionType],
      includeUpper: true,
      lower: [optionType],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> optionTypeNotEqualTo(
      bool? optionType) {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      upper: [optionType],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'optionType',
      lower: [optionType],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> optionTypeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> optionTypeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> projectIdEqualTo(String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId],
      includeUpper: true,
      lower: [projectId],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> projectIdNotEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [projectId],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Ctable, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension CUserQueryWhereSort on QueryBuilder<CUser, QWhere> {
  QueryBuilder<CUser, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<CUser, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CUserQueryWhere on QueryBuilder<CUser, QWhereClause> {
  QueryBuilder<CUser, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<CUser, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [name],
      includeUpper: true,
      lower: [name],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> nameNotEqualTo(String? name) {
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

  QueryBuilder<CUser, QAfterWhereClause> nameIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> nameIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'name',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> emailEqualTo(String? email) {
    return addWhereClause(WhereClause(
      indexName: 'email',
      upper: [email],
      includeUpper: true,
      lower: [email],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> emailNotEqualTo(String? email) {
    return addWhereClause(WhereClause(
      indexName: 'email',
      upper: [email],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'email',
      lower: [email],
      includeLower: false,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> emailIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'email',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> emailIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'email',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<CUser, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<CUser, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension WidgetsForFieldQueryWhereSort
    on QueryBuilder<WidgetsForField, QWhere> {
  QueryBuilder<WidgetsForField, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<WidgetsForField, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension WidgetsForFieldQueryWhere
    on QueryBuilder<WidgetsForField, QWhereClause> {
  QueryBuilder<WidgetsForField, QAfterWhereClause> fieldValueEqualTo(
      String? fieldValue) {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      upper: [fieldValue],
      includeUpper: true,
      lower: [fieldValue],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> fieldValueNotEqualTo(
      String? fieldValue) {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      upper: [fieldValue],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'fieldValue',
      lower: [fieldValue],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> fieldValueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> fieldValueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldValue',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> widgetValueEqualTo(
      String? widgetValue) {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      upper: [widgetValue],
      includeUpper: true,
      lower: [widgetValue],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> widgetValueNotEqualTo(
      String? widgetValue) {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      upper: [widgetValue],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'widgetValue',
      lower: [widgetValue],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> widgetValueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> widgetValueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'widgetValue',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<WidgetsForField, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterWhereClause> deletedNotEqualTo(
      bool deleted) {
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

extension WidgetTypeQueryWhereSort on QueryBuilder<WidgetType, QWhere> {
  QueryBuilder<WidgetType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<WidgetType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<WidgetType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension WidgetTypeQueryWhere on QueryBuilder<WidgetType, QWhereClause> {
  QueryBuilder<WidgetType, QAfterWhereClause> valueEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: true,
      lower: [value],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> valueNotEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'value',
      lower: [value],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: true,
      lower: [sort],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortNotEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [sort],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortBetween(
      int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<WidgetType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<WidgetType, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

  QueryBuilder<Account, QAfterFilterCondition> managerIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'managerId',
      value: null,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'managerId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerIdStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'managerId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'managerId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'managerId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Account, QAfterFilterCondition> managerIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'managerId',
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

extension FieldQueryFilter on QueryBuilder<Field, QFilterCondition> {
  QueryBuilder<Field, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> tableIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'tableId',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> tableIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> tableIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'tableId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> tableIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'tableId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> tableIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'tableId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> tableIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'tableId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> nameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> nameStartsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> nameEndsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> nameContains(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> labelEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> labelStartsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> labelEndsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> labelContains(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> isInternalIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isInternalId',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> isInternalIdEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isInternalId',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> fieldTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fieldType',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> fieldTypeEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> fieldTypeStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'fieldType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> fieldTypeEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'fieldType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> fieldTypeContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fieldType',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> fieldTypeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fieldType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> widgetTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'widgetType',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> widgetTypeEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> widgetTypeStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'widgetType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> widgetTypeEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'widgetType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> widgetTypeContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'widgetType',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> widgetTypeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'widgetType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> optionsTableIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'optionsTable',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> optionsTableEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> optionsTableStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'optionsTable',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> optionsTableEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'optionsTable',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> optionsTableContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'optionsTable',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> optionsTableMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'optionsTable',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<Field, QAfterFilterCondition> clientRevAtEndsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> clientRevAtContains(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> clientRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Field, QAfterFilterCondition> clientRevByEndsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> clientRevByContains(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> clientRevByMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<Field, QAfterFilterCondition> serverRevAtEndsWith(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> serverRevAtContains(String? value,
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

  QueryBuilder<Field, QAfterFilterCondition> serverRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension FieldTypeQueryFilter on QueryBuilder<FieldType, QFilterCondition> {
  QueryBuilder<FieldType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> valueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> valueStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> valueEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> valueContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> valueMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> sortEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> sortGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> sortLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> sortBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> commentEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> commentStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> commentEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> commentContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> commentMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<FieldType, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<FieldType, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<FieldType, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FieldType, QAfterFilterCondition> deletedEqualTo(bool value) {
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

extension OptionTypeQueryFilter on QueryBuilder<OptionType, QFilterCondition> {
  QueryBuilder<OptionType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> isarIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> valueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> valueStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> valueEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> valueContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> valueMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> saveIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'saveId',
      value: null,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> saveIdEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'saveId',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> sortEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> sortGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> sortLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> sortBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> commentEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> commentStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> commentEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> commentContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> commentMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<OptionType, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<OptionType, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<OptionType, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<OptionType, QAfterFilterCondition> deletedEqualTo(bool value) {
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

extension ProjectUserQueryFilter
    on QueryBuilder<ProjectUser, QFilterCondition> {
  QueryBuilder<ProjectUser, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> isarIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> projectIdEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> projectIdStartsWith(
      String? value,
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> projectIdEndsWith(
      String? value,
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> projectIdContains(
      String? value,
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> userEmailIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'userEmail',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> userEmailEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'userEmail',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> userEmailStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'userEmail',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> userEmailEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'userEmail',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> userEmailContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'userEmail',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> userEmailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'userEmail',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> roleIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'role',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> roleEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'role',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> roleStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'role',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> roleEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'role',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> roleContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'role',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> roleMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'role',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevAtEndsWith(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevAtContains(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevByEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevByContains(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<ProjectUser, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectUser, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension RelTypeQueryFilter on QueryBuilder<RelType, QFilterCondition> {
  QueryBuilder<RelType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> valueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> valueStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> valueEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> valueContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> valueMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> sortEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> sortGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> sortLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> sortBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> commentEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> commentStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> commentEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> commentContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> commentMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<RelType, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<RelType, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<RelType, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RelType, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension CrowQueryFilter on QueryBuilder<Crow, QFilterCondition> {
  QueryBuilder<Crow, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> tableIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'tableId',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> tableIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> tableIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'tableId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> tableIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'tableId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> tableIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'tableId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> tableIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'tableId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'geometry',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'geometry',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'geometry',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'geometry',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'geometry',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'geometry',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> dataIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'data',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> dataEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> dataStartsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> dataEndsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> dataContains(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> dataMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'data',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> clientRevAtStartsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> clientRevAtEndsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> clientRevAtContains(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> clientRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> clientRevByStartsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> clientRevByEndsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> clientRevByContains(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> clientRevByMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> serverRevAtStartsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> serverRevAtEndsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> serverRevAtContains(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> serverRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> revIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'rev',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> revEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> revStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'rev',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> revEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'rev',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> revContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'rev',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> revMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'rev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentRevIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentRev',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentRevEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentRevStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'parentRev',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentRevEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'parentRev',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentRevContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentRev',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentRevMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentRev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> depthIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'depth',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> depthEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> depthGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> depthLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> depthBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'depth',
      lower: lower,
      upper: upper,
    ));
  }
}

extension CtableQueryFilter on QueryBuilder<Ctable, QFilterCondition> {
  QueryBuilder<Ctable, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> nameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> nameStartsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> nameEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> nameContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelStartsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> labelEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> labelContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelFieldsSeparatorIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'labelFieldsSeparator',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelFieldsSeparatorEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelFieldsSeparatorStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'labelFieldsSeparator',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelFieldsSeparatorEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'labelFieldsSeparator',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelFieldsSeparatorContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'labelFieldsSeparator',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> labelFieldsSeparatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'labelFieldsSeparator',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> relTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'relType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> relTypeEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> relTypeStartsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> relTypeEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> relTypeContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> relTypeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'relType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> isOptionsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isOptions',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> isOptionsEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isOptions',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'optionType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'optionType',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> projectIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> projectIdStartsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> projectIdEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> projectIdContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> projectIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> parentIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> parentIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> parentIdStartsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> parentIdEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> parentIdContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> parentIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevAtEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevAtContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevByEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevByContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> clientRevByMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<Ctable, QAfterFilterCondition> serverRevAtEndsWith(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> serverRevAtContains(String? value,
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

  QueryBuilder<Ctable, QAfterFilterCondition> serverRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension CUserQueryFilter on QueryBuilder<CUser, QFilterCondition> {
  QueryBuilder<CUser, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> nameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> nameStartsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> nameEndsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> nameContains(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> emailIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'email',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> emailEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> emailStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'email',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> emailEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'email',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> emailContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'email',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> emailMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'email',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> accountIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'accountId',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> accountIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'accountId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> accountIdStartsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> accountIdEndsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> accountIdContains(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> accountIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'accountId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> authIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'authId',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> authIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'authId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> authIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'authId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> authIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'authId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> authIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'authId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> authIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'authId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<CUser, QAfterFilterCondition> clientRevAtEndsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> clientRevAtContains(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> clientRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<CUser, QAfterFilterCondition> clientRevByEndsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> clientRevByContains(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> clientRevByMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<CUser, QAfterFilterCondition> serverRevAtEndsWith(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> serverRevAtContains(String? value,
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

  QueryBuilder<CUser, QAfterFilterCondition> serverRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CUser, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension WidgetsForFieldQueryFilter
    on QueryBuilder<WidgetsForField, QFilterCondition> {
  QueryBuilder<WidgetsForField, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> isarIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> isarIdLessThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> fieldValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fieldValue',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> fieldValueEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fieldValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> fieldValueStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'fieldValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> fieldValueEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'fieldValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> fieldValueContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fieldValue',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> fieldValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fieldValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> widgetValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'widgetValue',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> widgetValueEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'widgetValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> widgetValueStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'widgetValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> widgetValueEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'widgetValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> widgetValueContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'widgetValue',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> widgetValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'widgetValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<WidgetsForField, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<WidgetsForField, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<WidgetsForField, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetsForField, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension WidgetTypeQueryFilter on QueryBuilder<WidgetType, QFilterCondition> {
  QueryBuilder<WidgetType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> isarIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> valueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> valueStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> valueEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'value',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> valueContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> valueMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> needsListIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'needsList',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> needsListEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'needsList',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> sortEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> sortGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> sortLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> sortBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> commentEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> commentStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> commentEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'comment',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> commentContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> commentMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<WidgetType, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<WidgetType, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<WidgetType, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<WidgetType, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension AccountQueryLinks on QueryBuilder<Account, QFilterCondition> {
  QueryBuilder<Account, QAfterFilterCondition> manager(FilterQuery<CUser> q) {
    return linkInternal(
      isar.cUsers,
      q,
      'manager',
    );
  }

  QueryBuilder<Account, QAfterFilterCondition> projects(
      FilterQuery<Project> q) {
    return linkInternal(
      isar.projects,
      q,
      'projects',
    );
  }
}

extension FieldQueryLinks on QueryBuilder<Field, QFilterCondition> {}

extension FieldTypeQueryLinks on QueryBuilder<FieldType, QFilterCondition> {}

extension OperationQueryLinks on QueryBuilder<Operation, QFilterCondition> {}

extension OptionTypeQueryLinks on QueryBuilder<OptionType, QFilterCondition> {}

extension ProjectQueryLinks on QueryBuilder<Project, QFilterCondition> {
  QueryBuilder<Project, QAfterFilterCondition> account(FilterQuery<Account> q) {
    return linkInternal(
      isar.accounts,
      q,
      'account',
    );
  }

  QueryBuilder<Project, QAfterFilterCondition> projectUsers(
      FilterQuery<ProjectUser> q) {
    return linkInternal(
      isar.projectUsers,
      q,
      'projectUsers',
    );
  }
}

extension ProjectUserQueryLinks on QueryBuilder<ProjectUser, QFilterCondition> {
  QueryBuilder<ProjectUser, QAfterFilterCondition> project(
      FilterQuery<Project> q) {
    return linkInternal(
      isar.projects,
      q,
      'project',
    );
  }
}

extension RelTypeQueryLinks on QueryBuilder<RelType, QFilterCondition> {}

extension CrowQueryLinks on QueryBuilder<Crow, QFilterCondition> {}

extension CtableQueryLinks on QueryBuilder<Ctable, QFilterCondition> {
  QueryBuilder<Ctable, QAfterFilterCondition> project(FilterQuery<Project> q) {
    return linkInternal(
      isar.projects,
      q,
      'project',
    );
  }

  QueryBuilder<Ctable, QAfterFilterCondition> parent(FilterQuery<Ctable> q) {
    return linkInternal(
      isar.ctables,
      q,
      'parent',
    );
  }
}

extension CUserQueryLinks on QueryBuilder<CUser, QFilterCondition> {
  QueryBuilder<CUser, QAfterFilterCondition> account(FilterQuery<Account> q) {
    return linkInternal(
      isar.accounts,
      q,
      'account',
    );
  }

  QueryBuilder<CUser, QAfterFilterCondition> projectUsers(
      FilterQuery<ProjectUser> q) {
    return linkInternal(
      isar.projectUsers,
      q,
      'projectUsers',
    );
  }
}

extension WidgetsForFieldQueryLinks
    on QueryBuilder<WidgetsForField, QFilterCondition> {}

extension WidgetTypeQueryLinks on QueryBuilder<WidgetType, QFilterCondition> {}

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

  QueryBuilder<Account, QAfterSortBy> sortByServiceId() {
    return addSortByInternal('serviceId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByServiceIdDesc() {
    return addSortByInternal('serviceId', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByManagerId() {
    return addSortByInternal('managerId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> sortByManagerIdDesc() {
    return addSortByInternal('managerId', Sort.Desc);
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

  QueryBuilder<Account, QAfterSortBy> thenByServiceId() {
    return addSortByInternal('serviceId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByServiceIdDesc() {
    return addSortByInternal('serviceId', Sort.Desc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByManagerId() {
    return addSortByInternal('managerId', Sort.Asc);
  }

  QueryBuilder<Account, QAfterSortBy> thenByManagerIdDesc() {
    return addSortByInternal('managerId', Sort.Desc);
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

extension FieldQueryWhereSortBy on QueryBuilder<Field, QSortBy> {
  QueryBuilder<Field, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByTableId() {
    return addSortByInternal('tableId', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByTableIdDesc() {
    return addSortByInternal('tableId', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByFieldType() {
    return addSortByInternal('fieldType', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByWidgetType() {
    return addSortByInternal('widgetType', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension FieldQueryWhereSortThenBy on QueryBuilder<Field, QSortThenBy> {
  QueryBuilder<Field, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByTableId() {
    return addSortByInternal('tableId', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByTableIdDesc() {
    return addSortByInternal('tableId', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByFieldType() {
    return addSortByInternal('fieldType', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByWidgetType() {
    return addSortByInternal('widgetType', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension FieldTypeQueryWhereSortBy on QueryBuilder<FieldType, QSortBy> {
  QueryBuilder<FieldType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension FieldTypeQueryWhereSortThenBy
    on QueryBuilder<FieldType, QSortThenBy> {
  QueryBuilder<FieldType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<FieldType, QAfterSortBy> thenByDeletedDesc() {
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

extension OptionTypeQueryWhereSortBy on QueryBuilder<OptionType, QSortBy> {
  QueryBuilder<OptionType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortBySaveId() {
    return addSortByInternal('saveId', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortBySaveIdDesc() {
    return addSortByInternal('saveId', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension OptionTypeQueryWhereSortThenBy
    on QueryBuilder<OptionType, QSortThenBy> {
  QueryBuilder<OptionType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenBySaveId() {
    return addSortByInternal('saveId', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenBySaveIdDesc() {
    return addSortByInternal('saveId', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<OptionType, QAfterSortBy> thenByDeletedDesc() {
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

extension ProjectUserQueryWhereSortBy on QueryBuilder<ProjectUser, QSortBy> {
  QueryBuilder<ProjectUser, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByUserEmail() {
    return addSortByInternal('userEmail', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByUserEmailDesc() {
    return addSortByInternal('userEmail', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByRole() {
    return addSortByInternal('role', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByRoleDesc() {
    return addSortByInternal('role', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension ProjectUserQueryWhereSortThenBy
    on QueryBuilder<ProjectUser, QSortThenBy> {
  QueryBuilder<ProjectUser, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByUserEmail() {
    return addSortByInternal('userEmail', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByUserEmailDesc() {
    return addSortByInternal('userEmail', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByRole() {
    return addSortByInternal('role', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByRoleDesc() {
    return addSortByInternal('role', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<ProjectUser, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension RelTypeQueryWhereSortBy on QueryBuilder<RelType, QSortBy> {
  QueryBuilder<RelType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension RelTypeQueryWhereSortThenBy on QueryBuilder<RelType, QSortThenBy> {
  QueryBuilder<RelType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<RelType, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension CrowQueryWhereSortBy on QueryBuilder<Crow, QSortBy> {
  QueryBuilder<Crow, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByTableId() {
    return addSortByInternal('tableId', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByTableIdDesc() {
    return addSortByInternal('tableId', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometry() {
    return addSortByInternal('geometry', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryDesc() {
    return addSortByInternal('geometry', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByData() {
    return addSortByInternal('data', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByDataDesc() {
    return addSortByInternal('data', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByRev() {
    return addSortByInternal('rev', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByRevDesc() {
    return addSortByInternal('rev', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByParentRev() {
    return addSortByInternal('parentRev', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByDepth() {
    return addSortByInternal('depth', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByDepthDesc() {
    return addSortByInternal('depth', Sort.Desc);
  }
}

extension CrowQueryWhereSortThenBy on QueryBuilder<Crow, QSortThenBy> {
  QueryBuilder<Crow, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByTableId() {
    return addSortByInternal('tableId', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByTableIdDesc() {
    return addSortByInternal('tableId', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometry() {
    return addSortByInternal('geometry', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryDesc() {
    return addSortByInternal('geometry', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByData() {
    return addSortByInternal('data', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByDataDesc() {
    return addSortByInternal('data', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByRev() {
    return addSortByInternal('rev', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByRevDesc() {
    return addSortByInternal('rev', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByParentRev() {
    return addSortByInternal('parentRev', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByDepth() {
    return addSortByInternal('depth', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByDepthDesc() {
    return addSortByInternal('depth', Sort.Desc);
  }
}

extension CtableQueryWhereSortBy on QueryBuilder<Ctable, QSortBy> {
  QueryBuilder<Ctable, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByLabelFieldsSeparator() {
    return addSortByInternal('labelFieldsSeparator', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByLabelFieldsSeparatorDesc() {
    return addSortByInternal('labelFieldsSeparator', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByRelType() {
    return addSortByInternal('relType', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByRelTypeDesc() {
    return addSortByInternal('relType', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByIsOptions() {
    return addSortByInternal('isOptions', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByIsOptionsDesc() {
    return addSortByInternal('isOptions', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByOptionType() {
    return addSortByInternal('optionType', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByOptionTypeDesc() {
    return addSortByInternal('optionType', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByParentId() {
    return addSortByInternal('parentId', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByParentIdDesc() {
    return addSortByInternal('parentId', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension CtableQueryWhereSortThenBy on QueryBuilder<Ctable, QSortThenBy> {
  QueryBuilder<Ctable, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByLabelFieldsSeparator() {
    return addSortByInternal('labelFieldsSeparator', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByLabelFieldsSeparatorDesc() {
    return addSortByInternal('labelFieldsSeparator', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByRelType() {
    return addSortByInternal('relType', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByRelTypeDesc() {
    return addSortByInternal('relType', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByIsOptions() {
    return addSortByInternal('isOptions', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByIsOptionsDesc() {
    return addSortByInternal('isOptions', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByOptionType() {
    return addSortByInternal('optionType', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByOptionTypeDesc() {
    return addSortByInternal('optionType', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByParentId() {
    return addSortByInternal('parentId', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByParentIdDesc() {
    return addSortByInternal('parentId', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension CUserQueryWhereSortBy on QueryBuilder<CUser, QSortBy> {
  QueryBuilder<CUser, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByEmail() {
    return addSortByInternal('email', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByEmailDesc() {
    return addSortByInternal('email', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByAccountId() {
    return addSortByInternal('accountId', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByAuthId() {
    return addSortByInternal('authId', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByAuthIdDesc() {
    return addSortByInternal('authId', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension CUserQueryWhereSortThenBy on QueryBuilder<CUser, QSortThenBy> {
  QueryBuilder<CUser, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByEmail() {
    return addSortByInternal('email', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByEmailDesc() {
    return addSortByInternal('email', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByAccountId() {
    return addSortByInternal('accountId', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByAccountIdDesc() {
    return addSortByInternal('accountId', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByAuthId() {
    return addSortByInternal('authId', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByAuthIdDesc() {
    return addSortByInternal('authId', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<CUser, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension WidgetsForFieldQueryWhereSortBy
    on QueryBuilder<WidgetsForField, QSortBy> {
  QueryBuilder<WidgetsForField, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByFieldValue() {
    return addSortByInternal('fieldValue', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByFieldValueDesc() {
    return addSortByInternal('fieldValue', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByWidgetValue() {
    return addSortByInternal('widgetValue', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByWidgetValueDesc() {
    return addSortByInternal('widgetValue', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension WidgetsForFieldQueryWhereSortThenBy
    on QueryBuilder<WidgetsForField, QSortThenBy> {
  QueryBuilder<WidgetsForField, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByFieldValue() {
    return addSortByInternal('fieldValue', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByFieldValueDesc() {
    return addSortByInternal('fieldValue', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByWidgetValue() {
    return addSortByInternal('widgetValue', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByWidgetValueDesc() {
    return addSortByInternal('widgetValue', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<WidgetsForField, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension WidgetTypeQueryWhereSortBy on QueryBuilder<WidgetType, QSortBy> {
  QueryBuilder<WidgetType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByNeedsList() {
    return addSortByInternal('needsList', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByNeedsListDesc() {
    return addSortByInternal('needsList', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension WidgetTypeQueryWhereSortThenBy
    on QueryBuilder<WidgetType, QSortThenBy> {
  QueryBuilder<WidgetType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByNeedsList() {
    return addSortByInternal('needsList', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByNeedsListDesc() {
    return addSortByInternal('needsList', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<WidgetType, QAfterSortBy> thenByDeletedDesc() {
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

  QueryBuilder<Account, QDistinct> distinctByServiceId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serviceId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Account, QDistinct> distinctByManagerId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('managerId', caseSensitive: caseSensitive);
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

extension FieldQueryWhereDistinct on QueryBuilder<Field, QDistinct> {
  QueryBuilder<Field, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Field, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByTableId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tableId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByLabel({bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByIsInternalId() {
    return addDistinctByInternal('isInternalId');
  }

  QueryBuilder<Field, QDistinct> distinctByFieldType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByWidgetType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('widgetType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByOptionsTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionsTable', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension FieldTypeQueryWhereDistinct on QueryBuilder<FieldType, QDistinct> {
  QueryBuilder<FieldType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<FieldType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<FieldType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<FieldType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<FieldType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<FieldType, QDistinct> distinctByDeleted() {
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

extension OptionTypeQueryWhereDistinct on QueryBuilder<OptionType, QDistinct> {
  QueryBuilder<OptionType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<OptionType, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, QDistinct> distinctBySaveId() {
    return addDistinctByInternal('saveId');
  }

  QueryBuilder<OptionType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<OptionType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<OptionType, QDistinct> distinctByDeleted() {
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

extension ProjectUserQueryWhereDistinct
    on QueryBuilder<ProjectUser, QDistinct> {
  QueryBuilder<ProjectUser, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ProjectUser, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByUserEmail(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('userEmail', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByRole(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('role', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectUser, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension RelTypeQueryWhereDistinct on QueryBuilder<RelType, QDistinct> {
  QueryBuilder<RelType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<RelType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<RelType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<RelType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<RelType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<RelType, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension CrowQueryWhereDistinct on QueryBuilder<Crow, QDistinct> {
  QueryBuilder<Crow, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Crow, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByTableId({bool caseSensitive = true}) {
    return addDistinctByInternal('tableId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByGeometry(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('geometry', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByData({bool caseSensitive = true}) {
    return addDistinctByInternal('data', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Crow, QDistinct> distinctByRev({bool caseSensitive = true}) {
    return addDistinctByInternal('rev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByParentRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentRev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByDepth() {
    return addDistinctByInternal('depth');
  }
}

extension CtableQueryWhereDistinct on QueryBuilder<Ctable, QDistinct> {
  QueryBuilder<Ctable, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Ctable, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByLabel({bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByLabelFieldsSeparator(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('labelFieldsSeparator',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByRelType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('relType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByIsOptions() {
    return addDistinctByInternal('isOptions');
  }

  QueryBuilder<Ctable, QDistinct> distinctByOptionType() {
    return addDistinctByInternal('optionType');
  }

  QueryBuilder<Ctable, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension CUserQueryWhereDistinct on QueryBuilder<CUser, QDistinct> {
  QueryBuilder<CUser, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<CUser, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByEmail({bool caseSensitive = true}) {
    return addDistinctByInternal('email', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByAccountId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('accountId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByAuthId({bool caseSensitive = true}) {
    return addDistinctByInternal('authId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<CUser, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension WidgetsForFieldQueryWhereDistinct
    on QueryBuilder<WidgetsForField, QDistinct> {
  QueryBuilder<WidgetsForField, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<WidgetsForField, QDistinct> distinctByFieldValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, QDistinct> distinctByWidgetValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('widgetValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetsForField, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension WidgetTypeQueryWhereDistinct on QueryBuilder<WidgetType, QDistinct> {
  QueryBuilder<WidgetType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<WidgetType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetType, QDistinct> distinctByNeedsList() {
    return addDistinctByInternal('needsList');
  }

  QueryBuilder<WidgetType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<WidgetType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<WidgetType, QDistinct> distinctByDeleted() {
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

  QueryBuilder<String?, QQueryOperations> serviceIdProperty() {
    return addPropertyName('serviceId');
  }

  QueryBuilder<String?, QQueryOperations> managerIdProperty() {
    return addPropertyName('managerId');
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

extension FieldQueryProperty on QueryBuilder<Field, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> tableIdProperty() {
    return addPropertyName('tableId');
  }

  QueryBuilder<String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<bool?, QQueryOperations> isInternalIdProperty() {
    return addPropertyName('isInternalId');
  }

  QueryBuilder<String?, QQueryOperations> fieldTypeProperty() {
    return addPropertyName('fieldType');
  }

  QueryBuilder<String?, QQueryOperations> widgetTypeProperty() {
    return addPropertyName('widgetType');
  }

  QueryBuilder<String?, QQueryOperations> optionsTableProperty() {
    return addPropertyName('optionsTable');
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

extension FieldTypeQueryProperty on QueryBuilder<FieldType, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }

  QueryBuilder<int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
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

extension OptionTypeQueryProperty on QueryBuilder<OptionType, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }

  QueryBuilder<bool?, QQueryOperations> saveIdProperty() {
    return addPropertyName('saveId');
  }

  QueryBuilder<int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
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

extension ProjectUserQueryProperty
    on QueryBuilder<ProjectUser, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<String?, QQueryOperations> userEmailProperty() {
    return addPropertyName('userEmail');
  }

  QueryBuilder<String?, QQueryOperations> roleProperty() {
    return addPropertyName('role');
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

extension RelTypeQueryProperty on QueryBuilder<RelType, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }

  QueryBuilder<int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}

extension CrowQueryProperty on QueryBuilder<Crow, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> tableIdProperty() {
    return addPropertyName('tableId');
  }

  QueryBuilder<String?, QQueryOperations> geometryProperty() {
    return addPropertyName('geometry');
  }

  QueryBuilder<String?, QQueryOperations> dataProperty() {
    return addPropertyName('data');
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

  QueryBuilder<String?, QQueryOperations> revProperty() {
    return addPropertyName('rev');
  }

  QueryBuilder<String?, QQueryOperations> parentRevProperty() {
    return addPropertyName('parentRev');
  }

  QueryBuilder<List<String>?, QQueryOperations> revisionsProperty() {
    return addPropertyName('revisions');
  }

  QueryBuilder<int?, QQueryOperations> depthProperty() {
    return addPropertyName('depth');
  }

  QueryBuilder<List<String>?, QQueryOperations> conflictsProperty() {
    return addPropertyName('conflicts');
  }
}

extension CtableQueryProperty on QueryBuilder<Ctable, QQueryProperty> {
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

  QueryBuilder<List<String>?, QQueryOperations> labelFieldsProperty() {
    return addPropertyName('labelFields');
  }

  QueryBuilder<String?, QQueryOperations> labelFieldsSeparatorProperty() {
    return addPropertyName('labelFieldsSeparator');
  }

  QueryBuilder<String?, QQueryOperations> relTypeProperty() {
    return addPropertyName('relType');
  }

  QueryBuilder<bool?, QQueryOperations> isOptionsProperty() {
    return addPropertyName('isOptions');
  }

  QueryBuilder<bool?, QQueryOperations> optionTypeProperty() {
    return addPropertyName('optionType');
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

extension CUserQueryProperty on QueryBuilder<CUser, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String?, QQueryOperations> emailProperty() {
    return addPropertyName('email');
  }

  QueryBuilder<String?, QQueryOperations> accountIdProperty() {
    return addPropertyName('accountId');
  }

  QueryBuilder<String?, QQueryOperations> authIdProperty() {
    return addPropertyName('authId');
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

extension WidgetsForFieldQueryProperty
    on QueryBuilder<WidgetsForField, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String?, QQueryOperations> fieldValueProperty() {
    return addPropertyName('fieldValue');
  }

  QueryBuilder<String?, QQueryOperations> widgetValueProperty() {
    return addPropertyName('widgetValue');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}

extension WidgetTypeQueryProperty on QueryBuilder<WidgetType, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String?, QQueryOperations> valueProperty() {
    return addPropertyName('value');
  }

  QueryBuilder<bool?, QQueryOperations> needsListProperty() {
    return addPropertyName('needsList');
  }

  QueryBuilder<int?, QQueryOperations> sortProperty() {
    return addPropertyName('sort');
  }

  QueryBuilder<String?, QQueryOperations> commentProperty() {
    return addPropertyName('comment');
  }

  QueryBuilder<String?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
