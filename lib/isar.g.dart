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
import 'models/dbOperation.dart';
import 'models/field.dart';
import 'models/fieldType.dart';
import 'models/file.dart';
import 'models/fileOperation.dart';
import 'models/optionType.dart';
import 'models/project.dart';
import 'models/projectTileLayer.dart';
import 'models/projectUser.dart';
import 'models/relType.dart';
import 'models/roleType.dart';
import 'models/row.dart';
import 'models/store.dart';
import 'models/table.dart';
import 'models/tileLayer.dart';
import 'models/user.dart';
import 'models/widgetsForField.dart';
import 'models/widgetType.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"Account","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"serviceId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"DbOperation","idProperty":"id","properties":[{"name":"id","type":3},{"name":"time","type":3},{"name":"table","type":5},{"name":"data","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"time","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Field","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"tableId","type":5},{"name":"name","type":5},{"name":"label","type":5},{"name":"ord","type":3},{"name":"isInternalId","type":0},{"name":"fieldType","type":5},{"name":"widgetType","type":5},{"name":"optionsTable","type":5},{"name":"standardValue","type":5},{"name":"lastValue","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"tableId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true},{"name":"tableId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"ord","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"FieldType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Cfile","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"rowId","type":5},{"name":"fieldId","type":5},{"name":"filename","type":5},{"name":"localPath","type":5},{"name":"url","type":5},{"name":"version","type":3},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0},{"name":"rev","type":5},{"name":"parentRev","type":5},{"name":"revisions","type":11},{"name":"depth","type":3},{"name":"conflicts","type":11}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"rowId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"fieldId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"FileOperation","idProperty":"id","properties":[{"name":"id","type":3},{"name":"time","type":3},{"name":"localPath","type":5},{"name":"fileId","type":5}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"time","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"OptionType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"value","type":5},{"name":"saveId","type":0},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Project","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"accountId","type":5},{"name":"label","type":5},{"name":"crs","type":3},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"accountId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"label","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"ProjectTileLayer","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"label","type":5},{"name":"ord","type":3},{"name":"active","type":0},{"name":"projectId","type":5},{"name":"urlTemplate","type":5},{"name":"subdomains","type":11},{"name":"maxZoom","type":4},{"name":"minZoom","type":4},{"name":"opacity","type":4},{"name":"wmsBaseUrl","type":5},{"name":"wmsFormat","type":5},{"name":"wmsLayers","type":11},{"name":"wmsParameters","type":5},{"name":"wmsRequest","type":5},{"name":"wmsService","type":5},{"name":"wmsStyles","type":11},{"name":"wmsTransparent","type":0},{"name":"wmsVersion","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"label","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"ord","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"active","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"ProjectUser","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"projectId","type":5},{"name":"userEmail","type":5},{"name":"role","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"RelType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"RoleType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Crow","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"tableId","type":5},{"name":"parentId","type":5},{"name":"geometry","type":5},{"name":"geometryN","type":4},{"name":"geometryE","type":4},{"name":"geometryS","type":4},{"name":"geometryW","type":4},{"name":"data","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0},{"name":"rev","type":5},{"name":"parentRev","type":5},{"name":"revisions","type":11},{"name":"depth","type":3},{"name":"conflicts","type":11}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"tableId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"Store","idProperty":"id","properties":[{"name":"id","type":3},{"name":"url","type":11},{"name":"editingProject","type":5},{"name":"largeLayoutTreeColumnSize","type":3}],"indexes":[],"links":[]},{"name":"Ctable","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"label","type":5},{"name":"singleLabel","type":5},{"name":"ord","type":3},{"name":"labelFields","type":11},{"name":"labelFieldsSeparator","type":5},{"name":"relType","type":5},{"name":"optionType","type":5},{"name":"projectId","type":5},{"name":"parentId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true},{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"ord","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"optionType","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"CtileLayer","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"label","type":5},{"name":"projectId","type":5},{"name":"urlTemplate","type":5},{"name":"subdomains","type":11},{"name":"maxZoom","type":4},{"name":"minZoom","type":4},{"name":"opacity","type":4},{"name":"wmsBaseUrl","type":5},{"name":"wmsFormat","type":5},{"name":"wmsLayers","type":11},{"name":"wmsParameters","type":5},{"name":"wmsRequest","type":5},{"name":"wmsService","type":5},{"name":"wmsStyles","type":11},{"name":"wmsTransparent","type":0},{"name":"wmsVersion","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"label","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"projectId","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"CUser","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"id","type":5},{"name":"name","type":5},{"name":"email","type":5},{"name":"accountId","type":5},{"name":"authId","type":5},{"name":"clientRevAt","type":5},{"name":"clientRevBy","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"id","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"name","indexType":1,"caseSensitive":true}]},{"unique":true,"replace":false,"properties":[{"name":"email","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"WidgetsForField","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"fieldValue","type":5},{"name":"widgetValue","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"fieldValue","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"widgetValue","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]},{"name":"WidgetType","idProperty":"isarId","properties":[{"name":"isarId","type":3},{"name":"value","type":5},{"name":"needsList","type":0},{"name":"sort","type":3},{"name":"comment","type":5},{"name":"serverRevAt","type":5},{"name":"deleted","type":0}],"indexes":[{"unique":false,"replace":false,"properties":[{"name":"value","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"sort","indexType":0,"caseSensitive":null}]},{"unique":false,"replace":false,"properties":[{"name":"serverRevAt","indexType":1,"caseSensitive":true}]},{"unique":false,"replace":false,"properties":[{"name":"deleted","indexType":0,"caseSensitive":null}]}],"links":[]}]';

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
        final propertyOffsetsPtr = malloc<Uint32>(24);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(24);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Account'] = IsarCollectionImpl<Account>(
          isar: isar,
          adapter: _AccountAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 7),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'serviceId': 2,
            'clientRevAt': 3,
            'clientRevBy': 4,
            'serverRevAt': 5,
            'deleted': 6
          },
          indexIds: {'id': 0, 'deleted': 1},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 1));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['DbOperation'] = IsarCollectionImpl<DbOperation>(
          isar: isar,
          adapter: _DbOperationAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 4),
          propertyIds: {'id': 0, 'time': 1, 'table': 2, 'data': 3},
          indexIds: {'time': 0},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.id,
          setId: (obj, id) => obj.id = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 2));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Field'] = IsarCollectionImpl<Field>(
          isar: isar,
          adapter: _FieldAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 16),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'tableId': 2,
            'name': 3,
            'label': 4,
            'ord': 5,
            'isInternalId': 6,
            'fieldType': 7,
            'widgetType': 8,
            'optionsTable': 9,
            'standardValue': 10,
            'lastValue': 11,
            'clientRevAt': 12,
            'clientRevBy': 13,
            'serverRevAt': 14,
            'deleted': 15
          },
          indexIds: {
            'id': 0,
            'tableId': 1,
            'name': 2,
            'ord': 3,
            'serverRevAt': 4,
            'deleted': 5
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 3));
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
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 4));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Cfile'] = IsarCollectionImpl<Cfile>(
          isar: isar,
          adapter: _CfileAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 17),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'rowId': 2,
            'fieldId': 3,
            'filename': 4,
            'localPath': 5,
            'url': 6,
            'version': 7,
            'clientRevAt': 8,
            'clientRevBy': 9,
            'serverRevAt': 10,
            'deleted': 11,
            'rev': 12,
            'parentRev': 13,
            'revisions': 14,
            'depth': 15,
            'conflicts': 16
          },
          indexIds: {
            'id': 0,
            'rowId': 1,
            'fieldId': 2,
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
        collections['FileOperation'] = IsarCollectionImpl<FileOperation>(
          isar: isar,
          adapter: _FileOperationAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 4),
          propertyIds: {'id': 0, 'time': 1, 'localPath': 2, 'fileId': 3},
          indexIds: {'time': 0},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.id,
          setId: (obj, id) => obj.id = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 6));
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
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 7));
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
            'crs': 5,
            'clientRevAt': 6,
            'clientRevBy': 7,
            'serverRevAt': 8,
            'deleted': 9
          },
          indexIds: {
            'id': 0,
            'accountId': 1,
            'label': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 8));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['ProjectTileLayer'] = IsarCollectionImpl<ProjectTileLayer>(
          isar: isar,
          adapter: _ProjectTileLayerAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 24),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'label': 2,
            'ord': 3,
            'active': 4,
            'projectId': 5,
            'urlTemplate': 6,
            'subdomains': 7,
            'maxZoom': 8,
            'minZoom': 9,
            'opacity': 10,
            'wmsBaseUrl': 11,
            'wmsFormat': 12,
            'wmsLayers': 13,
            'wmsParameters': 14,
            'wmsRequest': 15,
            'wmsService': 16,
            'wmsStyles': 17,
            'wmsTransparent': 18,
            'wmsVersion': 19,
            'clientRevAt': 20,
            'clientRevBy': 21,
            'serverRevAt': 22,
            'deleted': 23
          },
          indexIds: {
            'id': 0,
            'label': 1,
            'ord': 2,
            'active': 3,
            'projectId': 4,
            'serverRevAt': 5,
            'deleted': 6
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 9));
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
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 10));
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
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 11));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['RoleType'] = IsarCollectionImpl<RoleType>(
          isar: isar,
          adapter: _RoleTypeAdapter(),
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
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 12));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Crow'] = IsarCollectionImpl<Crow>(
          isar: isar,
          adapter: _CrowAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 19),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'tableId': 2,
            'parentId': 3,
            'geometry': 4,
            'geometryN': 5,
            'geometryE': 6,
            'geometryS': 7,
            'geometryW': 8,
            'data': 9,
            'clientRevAt': 10,
            'clientRevBy': 11,
            'serverRevAt': 12,
            'deleted': 13,
            'rev': 14,
            'parentRev': 15,
            'revisions': 16,
            'depth': 17,
            'conflicts': 18
          },
          indexIds: {'id': 0, 'tableId': 1, 'serverRevAt': 2, 'deleted': 3},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 13));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Store'] = IsarCollectionImpl<Store>(
          isar: isar,
          adapter: _StoreAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 4),
          propertyIds: {
            'id': 0,
            'url': 1,
            'editingProject': 2,
            'largeLayoutTreeColumnSize': 3
          },
          indexIds: {},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.id,
          setId: (obj, id) => obj.id = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 14));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['Ctable'] = IsarCollectionImpl<Ctable>(
          isar: isar,
          adapter: _CtableAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 16),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'name': 2,
            'label': 3,
            'singleLabel': 4,
            'ord': 5,
            'labelFields': 6,
            'labelFieldsSeparator': 7,
            'relType': 8,
            'optionType': 9,
            'projectId': 10,
            'parentId': 11,
            'clientRevAt': 12,
            'clientRevBy': 13,
            'serverRevAt': 14,
            'deleted': 15
          },
          indexIds: {
            'id': 0,
            'name': 1,
            'ord': 2,
            'optionType': 3,
            'projectId': 4,
            'serverRevAt': 5,
            'deleted': 6
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 15));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['CtileLayer'] = IsarCollectionImpl<CtileLayer>(
          isar: isar,
          adapter: _CtileLayerAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 22),
          propertyIds: {
            'isarId': 0,
            'id': 1,
            'label': 2,
            'projectId': 3,
            'urlTemplate': 4,
            'subdomains': 5,
            'maxZoom': 6,
            'minZoom': 7,
            'opacity': 8,
            'wmsBaseUrl': 9,
            'wmsFormat': 10,
            'wmsLayers': 11,
            'wmsParameters': 12,
            'wmsRequest': 13,
            'wmsService': 14,
            'wmsStyles': 15,
            'wmsTransparent': 16,
            'wmsVersion': 17,
            'clientRevAt': 18,
            'clientRevBy': 19,
            'serverRevAt': 20,
            'deleted': 21
          },
          indexIds: {
            'id': 0,
            'label': 1,
            'projectId': 2,
            'serverRevAt': 3,
            'deleted': 4
          },
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 16));
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
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.isarId,
          setId: (obj, id) => obj.isarId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 17));
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
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 18));
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
    final value3 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value3 != null) {
      _clientRevAt = _utf8Encoder.convert(value3);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value4 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value4 != null) {
      _clientRevBy = _utf8Encoder.convert(value4);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value5 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value5 != null) {
      _serverRevAt = _utf8Encoder.convert(value5);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value6 = object.deleted;
    final _deleted = value6;
    final size = dynamicSize + 51;

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
    final writer = BinaryWriter(buffer, 51);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _serviceId);
    writer.writeBytes(offsets[3], _clientRevAt);
    writer.writeBytes(offsets[4], _clientRevBy);
    writer.writeBytes(offsets[5], _serverRevAt);
    writer.writeBool(offsets[6], _deleted);
    return bufferSize;
  }

  @override
  Account deserialize(IsarCollectionImpl<Account> collection,
      BinaryReader reader, List<int> offsets) {
    final object = Account();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.serviceId = reader.readStringOrNull(offsets[2]);
    object.clientRevAt = reader.readStringOrNull(offsets[3]);
    object.clientRevBy = reader.readStringOrNull(offsets[4]);
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
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _DbOperationAdapter extends TypeAdapter<DbOperation> {
  @override
  int serialize(IsarCollectionImpl<DbOperation> collection, RawObject rawObj,
      DbOperation object, List<int> offsets,
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
  DbOperation deserialize(IsarCollectionImpl<DbOperation> collection,
      BinaryReader reader, List<int> offsets) {
    final object = DbOperation();
    object.id = reader.readLongOrNull(offsets[0]);
    object.time = reader.readDateTimeOrNull(offsets[1]);
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
        return (reader.readDateTimeOrNull(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
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
    final value5 = object.ord;
    final _ord = value5;
    final value6 = object.isInternalId;
    final _isInternalId = value6;
    final value7 = object.fieldType;
    Uint8List? _fieldType;
    if (value7 != null) {
      _fieldType = _utf8Encoder.convert(value7);
    }
    dynamicSize += _fieldType?.length ?? 0;
    final value8 = object.widgetType;
    Uint8List? _widgetType;
    if (value8 != null) {
      _widgetType = _utf8Encoder.convert(value8);
    }
    dynamicSize += _widgetType?.length ?? 0;
    final value9 = object.optionsTable;
    Uint8List? _optionsTable;
    if (value9 != null) {
      _optionsTable = _utf8Encoder.convert(value9);
    }
    dynamicSize += _optionsTable?.length ?? 0;
    final value10 = object.standardValue;
    Uint8List? _standardValue;
    if (value10 != null) {
      _standardValue = _utf8Encoder.convert(value10);
    }
    dynamicSize += _standardValue?.length ?? 0;
    final value11 = object.lastValue;
    Uint8List? _lastValue;
    if (value11 != null) {
      _lastValue = _utf8Encoder.convert(value11);
    }
    dynamicSize += _lastValue?.length ?? 0;
    final value12 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value12 != null) {
      _clientRevAt = _utf8Encoder.convert(value12);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value13 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value13 != null) {
      _clientRevBy = _utf8Encoder.convert(value13);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value14 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value14 != null) {
      _serverRevAt = _utf8Encoder.convert(value14);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value15 = object.deleted;
    final _deleted = value15;
    final size = dynamicSize + 116;

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
    final writer = BinaryWriter(buffer, 116);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _tableId);
    writer.writeBytes(offsets[3], _name);
    writer.writeBytes(offsets[4], _label);
    writer.writeLong(offsets[5], _ord);
    writer.writeBool(offsets[6], _isInternalId);
    writer.writeBytes(offsets[7], _fieldType);
    writer.writeBytes(offsets[8], _widgetType);
    writer.writeBytes(offsets[9], _optionsTable);
    writer.writeBytes(offsets[10], _standardValue);
    writer.writeBytes(offsets[11], _lastValue);
    writer.writeBytes(offsets[12], _clientRevAt);
    writer.writeBytes(offsets[13], _clientRevBy);
    writer.writeBytes(offsets[14], _serverRevAt);
    writer.writeBool(offsets[15], _deleted);
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
    object.ord = reader.readLongOrNull(offsets[5]);
    object.isInternalId = reader.readBoolOrNull(offsets[6]);
    object.fieldType = reader.readStringOrNull(offsets[7]);
    object.widgetType = reader.readStringOrNull(offsets[8]);
    object.optionsTable = reader.readStringOrNull(offsets[9]);
    object.standardValue = reader.readStringOrNull(offsets[10]);
    object.lastValue = reader.readStringOrNull(offsets[11]);
    object.clientRevAt = reader.readStringOrNull(offsets[12]);
    object.clientRevBy = reader.readStringOrNull(offsets[13]);
    object.serverRevAt = reader.readStringOrNull(offsets[14]);
    object.deleted = reader.readBool(offsets[15]);
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
        return (reader.readBoolOrNull(offset)) as P;
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
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
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

class _CfileAdapter extends TypeAdapter<Cfile> {
  @override
  int serialize(IsarCollectionImpl<Cfile> collection, RawObject rawObj,
      Cfile object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.rowId;
    Uint8List? _rowId;
    if (value2 != null) {
      _rowId = _utf8Encoder.convert(value2);
    }
    dynamicSize += _rowId?.length ?? 0;
    final value3 = object.fieldId;
    Uint8List? _fieldId;
    if (value3 != null) {
      _fieldId = _utf8Encoder.convert(value3);
    }
    dynamicSize += _fieldId?.length ?? 0;
    final value4 = object.filename;
    Uint8List? _filename;
    if (value4 != null) {
      _filename = _utf8Encoder.convert(value4);
    }
    dynamicSize += _filename?.length ?? 0;
    final value5 = object.localPath;
    Uint8List? _localPath;
    if (value5 != null) {
      _localPath = _utf8Encoder.convert(value5);
    }
    dynamicSize += _localPath?.length ?? 0;
    final value6 = object.url;
    Uint8List? _url;
    if (value6 != null) {
      _url = _utf8Encoder.convert(value6);
    }
    dynamicSize += _url?.length ?? 0;
    final value7 = object.version;
    final _version = value7;
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
    final value12 = object.rev;
    Uint8List? _rev;
    if (value12 != null) {
      _rev = _utf8Encoder.convert(value12);
    }
    dynamicSize += _rev?.length ?? 0;
    final value13 = object.parentRev;
    Uint8List? _parentRev;
    if (value13 != null) {
      _parentRev = _utf8Encoder.convert(value13);
    }
    dynamicSize += _parentRev?.length ?? 0;
    final value14 = object.revisions;
    dynamicSize += (value14?.length ?? 0) * 8;
    List<Uint8List?>? bytesList14;
    if (value14 != null) {
      bytesList14 = [];
      for (var str in value14) {
        final bytes = _utf8Encoder.convert(str);
        bytesList14.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _revisions = bytesList14;
    final value15 = object.depth;
    final _depth = value15;
    final value16 = object.conflicts;
    dynamicSize += (value16?.length ?? 0) * 8;
    List<Uint8List?>? bytesList16;
    if (value16 != null) {
      bytesList16 = [];
      for (var str in value16) {
        final bytes = _utf8Encoder.convert(str);
        bytesList16.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _conflicts = bytesList16;
    final size = dynamicSize + 131;

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
    final writer = BinaryWriter(buffer, 131);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _rowId);
    writer.writeBytes(offsets[3], _fieldId);
    writer.writeBytes(offsets[4], _filename);
    writer.writeBytes(offsets[5], _localPath);
    writer.writeBytes(offsets[6], _url);
    writer.writeLong(offsets[7], _version);
    writer.writeBytes(offsets[8], _clientRevAt);
    writer.writeBytes(offsets[9], _clientRevBy);
    writer.writeBytes(offsets[10], _serverRevAt);
    writer.writeBool(offsets[11], _deleted);
    writer.writeBytes(offsets[12], _rev);
    writer.writeBytes(offsets[13], _parentRev);
    writer.writeStringList(offsets[14], _revisions);
    writer.writeLong(offsets[15], _depth);
    writer.writeStringList(offsets[16], _conflicts);
    return bufferSize;
  }

  @override
  Cfile deserialize(IsarCollectionImpl<Cfile> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Cfile();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.rowId = reader.readStringOrNull(offsets[2]);
    object.fieldId = reader.readStringOrNull(offsets[3]);
    object.filename = reader.readStringOrNull(offsets[4]);
    object.localPath = reader.readStringOrNull(offsets[5]);
    object.url = reader.readStringOrNull(offsets[6]);
    object.version = reader.readLongOrNull(offsets[7]);
    object.clientRevAt = reader.readStringOrNull(offsets[8]);
    object.clientRevBy = reader.readStringOrNull(offsets[9]);
    object.serverRevAt = reader.readStringOrNull(offsets[10]);
    object.deleted = reader.readBool(offsets[11]);
    object.rev = reader.readStringOrNull(offsets[12]);
    object.parentRev = reader.readStringOrNull(offsets[13]);
    object.revisions = reader.readStringList(offsets[14]);
    object.depth = reader.readLongOrNull(offsets[15]);
    object.conflicts = reader.readStringList(offsets[16]);
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
        return (reader.readLongOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readBool(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringList(offset)) as P;
      case 15:
        return (reader.readLongOrNull(offset)) as P;
      case 16:
        return (reader.readStringList(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _FileOperationAdapter extends TypeAdapter<FileOperation> {
  @override
  int serialize(IsarCollectionImpl<FileOperation> collection, RawObject rawObj,
      FileOperation object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = value0;
    final value1 = object.time;
    final _time = value1;
    final value2 = object.localPath;
    Uint8List? _localPath;
    if (value2 != null) {
      _localPath = _utf8Encoder.convert(value2);
    }
    dynamicSize += _localPath?.length ?? 0;
    final value3 = object.fileId;
    Uint8List? _fileId;
    if (value3 != null) {
      _fileId = _utf8Encoder.convert(value3);
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
    writer.writeLong(offsets[0], _id);
    writer.writeDateTime(offsets[1], _time);
    writer.writeBytes(offsets[2], _localPath);
    writer.writeBytes(offsets[3], _fileId);
    return bufferSize;
  }

  @override
  FileOperation deserialize(IsarCollectionImpl<FileOperation> collection,
      BinaryReader reader, List<int> offsets) {
    final object = FileOperation();
    object.id = reader.readLongOrNull(offsets[0]);
    object.time = reader.readDateTimeOrNull(offsets[1]);
    object.localPath = reader.readStringOrNull(offsets[2]);
    object.fileId = reader.readStringOrNull(offsets[3]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readDateTimeOrNull(offset)) as P;
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
    final value5 = object.crs;
    final _crs = value5;
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
    writer.writeLong(offsets[5], _crs);
    writer.writeBytes(offsets[6], _clientRevAt);
    writer.writeBytes(offsets[7], _clientRevBy);
    writer.writeBytes(offsets[8], _serverRevAt);
    writer.writeBool(offsets[9], _deleted);
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
    object.crs = reader.readLongOrNull(offsets[5]);
    object.clientRevAt = reader.readStringOrNull(offsets[6]);
    object.clientRevBy = reader.readStringOrNull(offsets[7]);
    object.serverRevAt = reader.readStringOrNull(offsets[8]);
    object.deleted = reader.readBool(offsets[9]);
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

class _ProjectTileLayerAdapter extends TypeAdapter<ProjectTileLayer> {
  @override
  int serialize(IsarCollectionImpl<ProjectTileLayer> collection,
      RawObject rawObj, ProjectTileLayer object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.label;
    Uint8List? _label;
    if (value2 != null) {
      _label = _utf8Encoder.convert(value2);
    }
    dynamicSize += _label?.length ?? 0;
    final value3 = object.ord;
    final _ord = value3;
    final value4 = object.active;
    final _active = value4;
    final value5 = object.projectId;
    Uint8List? _projectId;
    if (value5 != null) {
      _projectId = _utf8Encoder.convert(value5);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value6 = object.urlTemplate;
    Uint8List? _urlTemplate;
    if (value6 != null) {
      _urlTemplate = _utf8Encoder.convert(value6);
    }
    dynamicSize += _urlTemplate?.length ?? 0;
    final value7 = object.subdomains;
    dynamicSize += (value7?.length ?? 0) * 8;
    List<Uint8List?>? bytesList7;
    if (value7 != null) {
      bytesList7 = [];
      for (var str in value7) {
        final bytes = _utf8Encoder.convert(str);
        bytesList7.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _subdomains = bytesList7;
    final value8 = object.maxZoom;
    final _maxZoom = value8;
    final value9 = object.minZoom;
    final _minZoom = value9;
    final value10 = object.opacity;
    final _opacity = value10;
    final value11 = object.wmsBaseUrl;
    Uint8List? _wmsBaseUrl;
    if (value11 != null) {
      _wmsBaseUrl = _utf8Encoder.convert(value11);
    }
    dynamicSize += _wmsBaseUrl?.length ?? 0;
    final value12 = object.wmsFormat;
    Uint8List? _wmsFormat;
    if (value12 != null) {
      _wmsFormat = _utf8Encoder.convert(value12);
    }
    dynamicSize += _wmsFormat?.length ?? 0;
    final value13 = object.wmsLayers;
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
    final _wmsLayers = bytesList13;
    final value14 = object.wmsParameters;
    Uint8List? _wmsParameters;
    if (value14 != null) {
      _wmsParameters = _utf8Encoder.convert(value14);
    }
    dynamicSize += _wmsParameters?.length ?? 0;
    final value15 = object.wmsRequest;
    Uint8List? _wmsRequest;
    if (value15 != null) {
      _wmsRequest = _utf8Encoder.convert(value15);
    }
    dynamicSize += _wmsRequest?.length ?? 0;
    final value16 = object.wmsService;
    Uint8List? _wmsService;
    if (value16 != null) {
      _wmsService = _utf8Encoder.convert(value16);
    }
    dynamicSize += _wmsService?.length ?? 0;
    final value17 = object.wmsStyles;
    dynamicSize += (value17?.length ?? 0) * 8;
    List<Uint8List?>? bytesList17;
    if (value17 != null) {
      bytesList17 = [];
      for (var str in value17) {
        final bytes = _utf8Encoder.convert(str);
        bytesList17.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsStyles = bytesList17;
    final value18 = object.wmsTransparent;
    final _wmsTransparent = value18;
    final value19 = object.wmsVersion;
    Uint8List? _wmsVersion;
    if (value19 != null) {
      _wmsVersion = _utf8Encoder.convert(value19);
    }
    dynamicSize += _wmsVersion?.length ?? 0;
    final value20 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value20 != null) {
      _clientRevAt = _utf8Encoder.convert(value20);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value21 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value21 != null) {
      _clientRevBy = _utf8Encoder.convert(value21);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value22 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value22 != null) {
      _serverRevAt = _utf8Encoder.convert(value22);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value23 = object.deleted;
    final _deleted = value23;
    final size = dynamicSize + 173;

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
    final writer = BinaryWriter(buffer, 173);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _label);
    writer.writeLong(offsets[3], _ord);
    writer.writeBool(offsets[4], _active);
    writer.writeBytes(offsets[5], _projectId);
    writer.writeBytes(offsets[6], _urlTemplate);
    writer.writeStringList(offsets[7], _subdomains);
    writer.writeDouble(offsets[8], _maxZoom);
    writer.writeDouble(offsets[9], _minZoom);
    writer.writeDouble(offsets[10], _opacity);
    writer.writeBytes(offsets[11], _wmsBaseUrl);
    writer.writeBytes(offsets[12], _wmsFormat);
    writer.writeStringList(offsets[13], _wmsLayers);
    writer.writeBytes(offsets[14], _wmsParameters);
    writer.writeBytes(offsets[15], _wmsRequest);
    writer.writeBytes(offsets[16], _wmsService);
    writer.writeStringList(offsets[17], _wmsStyles);
    writer.writeBool(offsets[18], _wmsTransparent);
    writer.writeBytes(offsets[19], _wmsVersion);
    writer.writeBytes(offsets[20], _clientRevAt);
    writer.writeBytes(offsets[21], _clientRevBy);
    writer.writeBytes(offsets[22], _serverRevAt);
    writer.writeBool(offsets[23], _deleted);
    return bufferSize;
  }

  @override
  ProjectTileLayer deserialize(IsarCollectionImpl<ProjectTileLayer> collection,
      BinaryReader reader, List<int> offsets) {
    final object = ProjectTileLayer();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.label = reader.readStringOrNull(offsets[2]);
    object.ord = reader.readLongOrNull(offsets[3]);
    object.active = reader.readBoolOrNull(offsets[4]);
    object.projectId = reader.readStringOrNull(offsets[5]);
    object.urlTemplate = reader.readStringOrNull(offsets[6]);
    object.subdomains = reader.readStringList(offsets[7]);
    object.maxZoom = reader.readDoubleOrNull(offsets[8]);
    object.minZoom = reader.readDoubleOrNull(offsets[9]);
    object.opacity = reader.readDoubleOrNull(offsets[10]);
    object.wmsBaseUrl = reader.readStringOrNull(offsets[11]);
    object.wmsFormat = reader.readStringOrNull(offsets[12]);
    object.wmsLayers = reader.readStringList(offsets[13]);
    object.wmsParameters = reader.readStringOrNull(offsets[14]);
    object.wmsRequest = reader.readStringOrNull(offsets[15]);
    object.wmsService = reader.readStringOrNull(offsets[16]);
    object.wmsStyles = reader.readStringList(offsets[17]);
    object.wmsTransparent = reader.readBoolOrNull(offsets[18]);
    object.wmsVersion = reader.readStringOrNull(offsets[19]);
    object.clientRevAt = reader.readStringOrNull(offsets[20]);
    object.clientRevBy = reader.readStringOrNull(offsets[21]);
    object.serverRevAt = reader.readStringOrNull(offsets[22]);
    object.deleted = reader.readBool(offsets[23]);
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
        return (reader.readLongOrNull(offset)) as P;
      case 4:
        return (reader.readBoolOrNull(offset)) as P;
      case 5:
        return (reader.readStringOrNull(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringList(offset)) as P;
      case 8:
        return (reader.readDoubleOrNull(offset)) as P;
      case 9:
        return (reader.readDoubleOrNull(offset)) as P;
      case 10:
        return (reader.readDoubleOrNull(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringList(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readStringOrNull(offset)) as P;
      case 16:
        return (reader.readStringOrNull(offset)) as P;
      case 17:
        return (reader.readStringList(offset)) as P;
      case 18:
        return (reader.readBoolOrNull(offset)) as P;
      case 19:
        return (reader.readStringOrNull(offset)) as P;
      case 20:
        return (reader.readStringOrNull(offset)) as P;
      case 21:
        return (reader.readStringOrNull(offset)) as P;
      case 22:
        return (reader.readStringOrNull(offset)) as P;
      case 23:
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

class _RoleTypeAdapter extends TypeAdapter<RoleType> {
  @override
  int serialize(IsarCollectionImpl<RoleType> collection, RawObject rawObj,
      RoleType object, List<int> offsets,
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
  RoleType deserialize(IsarCollectionImpl<RoleType> collection,
      BinaryReader reader, List<int> offsets) {
    final object = RoleType();
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
    final value3 = object.parentId;
    Uint8List? _parentId;
    if (value3 != null) {
      _parentId = _utf8Encoder.convert(value3);
    }
    dynamicSize += _parentId?.length ?? 0;
    final value4 = object.geometry;
    Uint8List? _geometry;
    if (value4 != null) {
      _geometry = _utf8Encoder.convert(value4);
    }
    dynamicSize += _geometry?.length ?? 0;
    final value5 = object.geometryN;
    final _geometryN = value5;
    final value6 = object.geometryE;
    final _geometryE = value6;
    final value7 = object.geometryS;
    final _geometryS = value7;
    final value8 = object.geometryW;
    final _geometryW = value8;
    final value9 = object.data;
    Uint8List? _data;
    if (value9 != null) {
      _data = _utf8Encoder.convert(value9);
    }
    dynamicSize += _data?.length ?? 0;
    final value10 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value10 != null) {
      _clientRevAt = _utf8Encoder.convert(value10);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value11 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value11 != null) {
      _clientRevBy = _utf8Encoder.convert(value11);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value12 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value12 != null) {
      _serverRevAt = _utf8Encoder.convert(value12);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value13 = object.deleted;
    final _deleted = value13;
    final value14 = object.rev;
    Uint8List? _rev;
    if (value14 != null) {
      _rev = _utf8Encoder.convert(value14);
    }
    dynamicSize += _rev?.length ?? 0;
    final value15 = object.parentRev;
    Uint8List? _parentRev;
    if (value15 != null) {
      _parentRev = _utf8Encoder.convert(value15);
    }
    dynamicSize += _parentRev?.length ?? 0;
    final value16 = object.revisions;
    dynamicSize += (value16?.length ?? 0) * 8;
    List<Uint8List?>? bytesList16;
    if (value16 != null) {
      bytesList16 = [];
      for (var str in value16) {
        final bytes = _utf8Encoder.convert(str);
        bytesList16.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _revisions = bytesList16;
    final value17 = object.depth;
    final _depth = value17;
    final value18 = object.conflicts;
    dynamicSize += (value18?.length ?? 0) * 8;
    List<Uint8List?>? bytesList18;
    if (value18 != null) {
      bytesList18 = [];
      for (var str in value18) {
        final bytes = _utf8Encoder.convert(str);
        bytesList18.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _conflicts = bytesList18;
    final size = dynamicSize + 147;

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
    final writer = BinaryWriter(buffer, 147);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _tableId);
    writer.writeBytes(offsets[3], _parentId);
    writer.writeBytes(offsets[4], _geometry);
    writer.writeDouble(offsets[5], _geometryN);
    writer.writeDouble(offsets[6], _geometryE);
    writer.writeDouble(offsets[7], _geometryS);
    writer.writeDouble(offsets[8], _geometryW);
    writer.writeBytes(offsets[9], _data);
    writer.writeBytes(offsets[10], _clientRevAt);
    writer.writeBytes(offsets[11], _clientRevBy);
    writer.writeBytes(offsets[12], _serverRevAt);
    writer.writeBool(offsets[13], _deleted);
    writer.writeBytes(offsets[14], _rev);
    writer.writeBytes(offsets[15], _parentRev);
    writer.writeStringList(offsets[16], _revisions);
    writer.writeLong(offsets[17], _depth);
    writer.writeStringList(offsets[18], _conflicts);
    return bufferSize;
  }

  @override
  Crow deserialize(IsarCollectionImpl<Crow> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Crow();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.tableId = reader.readStringOrNull(offsets[2]);
    object.parentId = reader.readStringOrNull(offsets[3]);
    object.geometry = reader.readStringOrNull(offsets[4]);
    object.geometryN = reader.readDoubleOrNull(offsets[5]);
    object.geometryE = reader.readDoubleOrNull(offsets[6]);
    object.geometryS = reader.readDoubleOrNull(offsets[7]);
    object.geometryW = reader.readDoubleOrNull(offsets[8]);
    object.data = reader.readStringOrNull(offsets[9]);
    object.clientRevAt = reader.readStringOrNull(offsets[10]);
    object.clientRevBy = reader.readStringOrNull(offsets[11]);
    object.serverRevAt = reader.readStringOrNull(offsets[12]);
    object.deleted = reader.readBool(offsets[13]);
    object.rev = reader.readStringOrNull(offsets[14]);
    object.parentRev = reader.readStringOrNull(offsets[15]);
    object.revisions = reader.readStringList(offsets[16]);
    object.depth = reader.readLongOrNull(offsets[17]);
    object.conflicts = reader.readStringList(offsets[18]);
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
        return (reader.readDoubleOrNull(offset)) as P;
      case 6:
        return (reader.readDoubleOrNull(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readDoubleOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readBool(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readStringOrNull(offset)) as P;
      case 16:
        return (reader.readStringList(offset)) as P;
      case 17:
        return (reader.readLongOrNull(offset)) as P;
      case 18:
        return (reader.readStringList(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _StoreAdapter extends TypeAdapter<Store> {
  @override
  int serialize(IsarCollectionImpl<Store> collection, RawObject rawObj,
      Store object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = value0;
    final value1 = object.url;
    dynamicSize += (value1?.length ?? 0) * 8;
    List<Uint8List?>? bytesList1;
    if (value1 != null) {
      bytesList1 = [];
      for (var str in value1) {
        final bytes = _utf8Encoder.convert(str);
        bytesList1.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _url = bytesList1;
    final value2 = object.editingProject;
    Uint8List? _editingProject;
    if (value2 != null) {
      _editingProject = _utf8Encoder.convert(value2);
    }
    dynamicSize += _editingProject?.length ?? 0;
    final value3 = object.largeLayoutTreeColumnSize;
    final _largeLayoutTreeColumnSize = value3;
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
    writer.writeStringList(offsets[1], _url);
    writer.writeBytes(offsets[2], _editingProject);
    writer.writeLong(offsets[3], _largeLayoutTreeColumnSize);
    return bufferSize;
  }

  @override
  Store deserialize(IsarCollectionImpl<Store> collection, BinaryReader reader,
      List<int> offsets) {
    final object = Store();
    object.id = reader.readLongOrNull(offsets[0]);
    object.url = reader.readStringList(offsets[1]);
    object.editingProject = reader.readStringOrNull(offsets[2]);
    object.largeLayoutTreeColumnSize = reader.readLongOrNull(offsets[3]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readStringList(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readLongOrNull(offset)) as P;
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
    final value4 = object.singleLabel;
    Uint8List? _singleLabel;
    if (value4 != null) {
      _singleLabel = _utf8Encoder.convert(value4);
    }
    dynamicSize += _singleLabel?.length ?? 0;
    final value5 = object.ord;
    final _ord = value5;
    final value6 = object.labelFields;
    dynamicSize += (value6?.length ?? 0) * 8;
    List<Uint8List?>? bytesList6;
    if (value6 != null) {
      bytesList6 = [];
      for (var str in value6) {
        final bytes = _utf8Encoder.convert(str);
        bytesList6.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _labelFields = bytesList6;
    final value7 = object.labelFieldsSeparator;
    Uint8List? _labelFieldsSeparator;
    if (value7 != null) {
      _labelFieldsSeparator = _utf8Encoder.convert(value7);
    }
    dynamicSize += _labelFieldsSeparator?.length ?? 0;
    final value8 = object.relType;
    Uint8List? _relType;
    if (value8 != null) {
      _relType = _utf8Encoder.convert(value8);
    }
    dynamicSize += _relType?.length ?? 0;
    final value9 = object.optionType;
    Uint8List? _optionType;
    if (value9 != null) {
      _optionType = _utf8Encoder.convert(value9);
    }
    dynamicSize += _optionType?.length ?? 0;
    final value10 = object.projectId;
    Uint8List? _projectId;
    if (value10 != null) {
      _projectId = _utf8Encoder.convert(value10);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value11 = object.parentId;
    Uint8List? _parentId;
    if (value11 != null) {
      _parentId = _utf8Encoder.convert(value11);
    }
    dynamicSize += _parentId?.length ?? 0;
    final value12 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value12 != null) {
      _clientRevAt = _utf8Encoder.convert(value12);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value13 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value13 != null) {
      _clientRevBy = _utf8Encoder.convert(value13);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value14 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value14 != null) {
      _serverRevAt = _utf8Encoder.convert(value14);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value15 = object.deleted;
    final _deleted = value15;
    final size = dynamicSize + 123;

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
    final writer = BinaryWriter(buffer, 123);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _name);
    writer.writeBytes(offsets[3], _label);
    writer.writeBytes(offsets[4], _singleLabel);
    writer.writeLong(offsets[5], _ord);
    writer.writeStringList(offsets[6], _labelFields);
    writer.writeBytes(offsets[7], _labelFieldsSeparator);
    writer.writeBytes(offsets[8], _relType);
    writer.writeBytes(offsets[9], _optionType);
    writer.writeBytes(offsets[10], _projectId);
    writer.writeBytes(offsets[11], _parentId);
    writer.writeBytes(offsets[12], _clientRevAt);
    writer.writeBytes(offsets[13], _clientRevBy);
    writer.writeBytes(offsets[14], _serverRevAt);
    writer.writeBool(offsets[15], _deleted);
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
    object.singleLabel = reader.readStringOrNull(offsets[4]);
    object.ord = reader.readLongOrNull(offsets[5]);
    object.labelFields = reader.readStringList(offsets[6]);
    object.labelFieldsSeparator = reader.readStringOrNull(offsets[7]);
    object.relType = reader.readStringOrNull(offsets[8]);
    object.optionType = reader.readStringOrNull(offsets[9]);
    object.projectId = reader.readStringOrNull(offsets[10]);
    object.parentId = reader.readStringOrNull(offsets[11]);
    object.clientRevAt = reader.readStringOrNull(offsets[12]);
    object.clientRevBy = reader.readStringOrNull(offsets[13]);
    object.serverRevAt = reader.readStringOrNull(offsets[14]);
    object.deleted = reader.readBool(offsets[15]);
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
        return (reader.readStringList(offset)) as P;
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
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _CtileLayerAdapter extends TypeAdapter<CtileLayer> {
  @override
  int serialize(IsarCollectionImpl<CtileLayer> collection, RawObject rawObj,
      CtileLayer object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.isarId;
    final _isarId = value0;
    final value1 = object.id;
    final _id = _utf8Encoder.convert(value1);
    dynamicSize += _id.length;
    final value2 = object.label;
    Uint8List? _label;
    if (value2 != null) {
      _label = _utf8Encoder.convert(value2);
    }
    dynamicSize += _label?.length ?? 0;
    final value3 = object.projectId;
    Uint8List? _projectId;
    if (value3 != null) {
      _projectId = _utf8Encoder.convert(value3);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value4 = object.urlTemplate;
    Uint8List? _urlTemplate;
    if (value4 != null) {
      _urlTemplate = _utf8Encoder.convert(value4);
    }
    dynamicSize += _urlTemplate?.length ?? 0;
    final value5 = object.subdomains;
    dynamicSize += (value5?.length ?? 0) * 8;
    List<Uint8List?>? bytesList5;
    if (value5 != null) {
      bytesList5 = [];
      for (var str in value5) {
        final bytes = _utf8Encoder.convert(str);
        bytesList5.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _subdomains = bytesList5;
    final value6 = object.maxZoom;
    final _maxZoom = value6;
    final value7 = object.minZoom;
    final _minZoom = value7;
    final value8 = object.opacity;
    final _opacity = value8;
    final value9 = object.wmsBaseUrl;
    Uint8List? _wmsBaseUrl;
    if (value9 != null) {
      _wmsBaseUrl = _utf8Encoder.convert(value9);
    }
    dynamicSize += _wmsBaseUrl?.length ?? 0;
    final value10 = object.wmsFormat;
    Uint8List? _wmsFormat;
    if (value10 != null) {
      _wmsFormat = _utf8Encoder.convert(value10);
    }
    dynamicSize += _wmsFormat?.length ?? 0;
    final value11 = object.wmsLayers;
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
    final _wmsLayers = bytesList11;
    final value12 = object.wmsParameters;
    Uint8List? _wmsParameters;
    if (value12 != null) {
      _wmsParameters = _utf8Encoder.convert(value12);
    }
    dynamicSize += _wmsParameters?.length ?? 0;
    final value13 = object.wmsRequest;
    Uint8List? _wmsRequest;
    if (value13 != null) {
      _wmsRequest = _utf8Encoder.convert(value13);
    }
    dynamicSize += _wmsRequest?.length ?? 0;
    final value14 = object.wmsService;
    Uint8List? _wmsService;
    if (value14 != null) {
      _wmsService = _utf8Encoder.convert(value14);
    }
    dynamicSize += _wmsService?.length ?? 0;
    final value15 = object.wmsStyles;
    dynamicSize += (value15?.length ?? 0) * 8;
    List<Uint8List?>? bytesList15;
    if (value15 != null) {
      bytesList15 = [];
      for (var str in value15) {
        final bytes = _utf8Encoder.convert(str);
        bytesList15.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _wmsStyles = bytesList15;
    final value16 = object.wmsTransparent;
    final _wmsTransparent = value16;
    final value17 = object.wmsVersion;
    Uint8List? _wmsVersion;
    if (value17 != null) {
      _wmsVersion = _utf8Encoder.convert(value17);
    }
    dynamicSize += _wmsVersion?.length ?? 0;
    final value18 = object.clientRevAt;
    Uint8List? _clientRevAt;
    if (value18 != null) {
      _clientRevAt = _utf8Encoder.convert(value18);
    }
    dynamicSize += _clientRevAt?.length ?? 0;
    final value19 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value19 != null) {
      _clientRevBy = _utf8Encoder.convert(value19);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value20 = object.serverRevAt;
    Uint8List? _serverRevAt;
    if (value20 != null) {
      _serverRevAt = _utf8Encoder.convert(value20);
    }
    dynamicSize += _serverRevAt?.length ?? 0;
    final value21 = object.deleted;
    final _deleted = value21;
    final size = dynamicSize + 164;

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
    final writer = BinaryWriter(buffer, 164);
    writer.writeLong(offsets[0], _isarId);
    writer.writeBytes(offsets[1], _id);
    writer.writeBytes(offsets[2], _label);
    writer.writeBytes(offsets[3], _projectId);
    writer.writeBytes(offsets[4], _urlTemplate);
    writer.writeStringList(offsets[5], _subdomains);
    writer.writeDouble(offsets[6], _maxZoom);
    writer.writeDouble(offsets[7], _minZoom);
    writer.writeDouble(offsets[8], _opacity);
    writer.writeBytes(offsets[9], _wmsBaseUrl);
    writer.writeBytes(offsets[10], _wmsFormat);
    writer.writeStringList(offsets[11], _wmsLayers);
    writer.writeBytes(offsets[12], _wmsParameters);
    writer.writeBytes(offsets[13], _wmsRequest);
    writer.writeBytes(offsets[14], _wmsService);
    writer.writeStringList(offsets[15], _wmsStyles);
    writer.writeBool(offsets[16], _wmsTransparent);
    writer.writeBytes(offsets[17], _wmsVersion);
    writer.writeBytes(offsets[18], _clientRevAt);
    writer.writeBytes(offsets[19], _clientRevBy);
    writer.writeBytes(offsets[20], _serverRevAt);
    writer.writeBool(offsets[21], _deleted);
    return bufferSize;
  }

  @override
  CtileLayer deserialize(IsarCollectionImpl<CtileLayer> collection,
      BinaryReader reader, List<int> offsets) {
    final object = CtileLayer();
    object.isarId = reader.readLongOrNull(offsets[0]);
    object.id = reader.readString(offsets[1]);
    object.label = reader.readStringOrNull(offsets[2]);
    object.projectId = reader.readStringOrNull(offsets[3]);
    object.urlTemplate = reader.readStringOrNull(offsets[4]);
    object.subdomains = reader.readStringList(offsets[5]);
    object.maxZoom = reader.readDoubleOrNull(offsets[6]);
    object.minZoom = reader.readDoubleOrNull(offsets[7]);
    object.opacity = reader.readDoubleOrNull(offsets[8]);
    object.wmsBaseUrl = reader.readStringOrNull(offsets[9]);
    object.wmsFormat = reader.readStringOrNull(offsets[10]);
    object.wmsLayers = reader.readStringList(offsets[11]);
    object.wmsParameters = reader.readStringOrNull(offsets[12]);
    object.wmsRequest = reader.readStringOrNull(offsets[13]);
    object.wmsService = reader.readStringOrNull(offsets[14]);
    object.wmsStyles = reader.readStringList(offsets[15]);
    object.wmsTransparent = reader.readBoolOrNull(offsets[16]);
    object.wmsVersion = reader.readStringOrNull(offsets[17]);
    object.clientRevAt = reader.readStringOrNull(offsets[18]);
    object.clientRevBy = reader.readStringOrNull(offsets[19]);
    object.serverRevAt = reader.readStringOrNull(offsets[20]);
    object.deleted = reader.readBool(offsets[21]);
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
        return (reader.readStringList(offset)) as P;
      case 6:
        return (reader.readDoubleOrNull(offset)) as P;
      case 7:
        return (reader.readDoubleOrNull(offset)) as P;
      case 8:
        return (reader.readDoubleOrNull(offset)) as P;
      case 9:
        return (reader.readStringOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringList(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      case 15:
        return (reader.readStringList(offset)) as P;
      case 16:
        return (reader.readBoolOrNull(offset)) as P;
      case 17:
        return (reader.readStringOrNull(offset)) as P;
      case 18:
        return (reader.readStringOrNull(offset)) as P;
      case 19:
        return (reader.readStringOrNull(offset)) as P;
      case 20:
        return (reader.readStringOrNull(offset)) as P;
      case 21:
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

  IsarCollection<DbOperation> get dbOperations {
    return getCollection('DbOperation');
  }

  IsarCollection<Field> get fields {
    return getCollection('Field');
  }

  IsarCollection<FieldType> get fieldTypes {
    return getCollection('FieldType');
  }

  IsarCollection<Cfile> get cfiles {
    return getCollection('Cfile');
  }

  IsarCollection<FileOperation> get fileOperations {
    return getCollection('FileOperation');
  }

  IsarCollection<OptionType> get optionTypes {
    return getCollection('OptionType');
  }

  IsarCollection<Project> get projects {
    return getCollection('Project');
  }

  IsarCollection<ProjectTileLayer> get projectTileLayers {
    return getCollection('ProjectTileLayer');
  }

  IsarCollection<ProjectUser> get projectUsers {
    return getCollection('ProjectUser');
  }

  IsarCollection<RelType> get relTypes {
    return getCollection('RelType');
  }

  IsarCollection<RoleType> get roleTypes {
    return getCollection('RoleType');
  }

  IsarCollection<Crow> get crows {
    return getCollection('Crow');
  }

  IsarCollection<Store> get stores {
    return getCollection('Store');
  }

  IsarCollection<Ctable> get ctables {
    return getCollection('Ctable');
  }

  IsarCollection<CtileLayer> get ctileLayers {
    return getCollection('CtileLayer');
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

extension DbOperationQueryWhereSort on QueryBuilder<DbOperation, QWhere> {
  QueryBuilder<DbOperation, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<DbOperation, QAfterWhere> anyTime() {
    return addWhereClause(WhereClause(indexName: 'time'));
  }
}

extension DbOperationQueryWhere on QueryBuilder<DbOperation, QWhereClause> {
  QueryBuilder<DbOperation, QAfterWhereClause> timeEqualTo(DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: true,
      lower: [time],
      includeLower: true,
    ));
  }

  QueryBuilder<DbOperation, QAfterWhereClause> timeNotEqualTo(DateTime? time) {
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

  QueryBuilder<DbOperation, QAfterWhereClause> timeBetween(
      DateTime? lower, DateTime? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<DbOperation, QAfterWhereClause> timeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<DbOperation, QAfterWhereClause> timeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension FieldQueryWhereSort on QueryBuilder<Field, QWhere> {
  QueryBuilder<Field, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Field, QAfterWhere> anyOrd() {
    return addWhereClause(WhereClause(indexName: 'ord'));
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

  QueryBuilder<Field, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: true,
      lower: [ord],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> ordNotEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> ordBetween(int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> ordGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> ordLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> ordIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, QAfterWhereClause> ordIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [null],
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

extension CfileQueryWhereSort on QueryBuilder<Cfile, QWhere> {
  QueryBuilder<Cfile, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Cfile, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CfileQueryWhere on QueryBuilder<Cfile, QWhereClause> {
  QueryBuilder<Cfile, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Cfile, QAfterWhereClause> rowIdEqualTo(String? rowId) {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      upper: [rowId],
      includeUpper: true,
      lower: [rowId],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> rowIdNotEqualTo(String? rowId) {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      upper: [rowId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'rowId',
      lower: [rowId],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> rowIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> rowIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'rowId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> fieldIdEqualTo(String? fieldId) {
    return addWhereClause(WhereClause(
      indexName: 'fieldId',
      upper: [fieldId],
      includeUpper: true,
      lower: [fieldId],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> fieldIdNotEqualTo(String? fieldId) {
    return addWhereClause(WhereClause(
      indexName: 'fieldId',
      upper: [fieldId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'fieldId',
      lower: [fieldId],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> fieldIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> fieldIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'fieldId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Cfile, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<Cfile, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension FileOperationQueryWhereSort on QueryBuilder<FileOperation, QWhere> {
  QueryBuilder<FileOperation, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<FileOperation, QAfterWhere> anyTime() {
    return addWhereClause(WhereClause(indexName: 'time'));
  }
}

extension FileOperationQueryWhere on QueryBuilder<FileOperation, QWhereClause> {
  QueryBuilder<FileOperation, QAfterWhereClause> timeEqualTo(DateTime? time) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [time],
      includeUpper: true,
      lower: [time],
      includeLower: true,
    ));
  }

  QueryBuilder<FileOperation, QAfterWhereClause> timeNotEqualTo(
      DateTime? time) {
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

  QueryBuilder<FileOperation, QAfterWhereClause> timeBetween(
      DateTime? lower, DateTime? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<FileOperation, QAfterWhereClause> timeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<FileOperation, QAfterWhereClause> timeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'time',
      lower: [null],
      includeLower: false,
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

  QueryBuilder<Project, QAfterWhereClause> accountIdEqualTo(String? accountId) {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      upper: [accountId],
      includeUpper: true,
      lower: [accountId],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> accountIdNotEqualTo(
      String? accountId) {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      upper: [accountId],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'accountId',
      lower: [accountId],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> accountIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> accountIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'accountId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> labelEqualTo(String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [label],
      includeUpper: true,
      lower: [label],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> labelNotEqualTo(String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [label],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'label',
      lower: [label],
      includeLower: false,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> labelIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Project, QAfterWhereClause> labelIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
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

extension ProjectTileLayerQueryWhereSort
    on QueryBuilder<ProjectTileLayer, QWhere> {
  QueryBuilder<ProjectTileLayer, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhere> anyOrd() {
    return addWhereClause(WhereClause(indexName: 'ord'));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhere> anyActive() {
    return addWhereClause(WhereClause(indexName: 'active'));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension ProjectTileLayerQueryWhere
    on QueryBuilder<ProjectTileLayer, QWhereClause> {
  QueryBuilder<ProjectTileLayer, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> labelEqualTo(
      String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [label],
      includeUpper: true,
      lower: [label],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> labelNotEqualTo(
      String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [label],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'label',
      lower: [label],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> labelIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> labelIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: true,
      lower: [ord],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordNotEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordBetween(
      int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> ordIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> activeEqualTo(
      bool? active) {
    return addWhereClause(WhereClause(
      indexName: 'active',
      upper: [active],
      includeUpper: true,
      lower: [active],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> activeNotEqualTo(
      bool? active) {
    return addWhereClause(WhereClause(
      indexName: 'active',
      upper: [active],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'active',
      lower: [active],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> activeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'active',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> activeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'active',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId],
      includeUpper: true,
      lower: [projectId],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> projectIdNotEqualTo(
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

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> deletedEqualTo(
      bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterWhereClause> deletedNotEqualTo(
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

extension RoleTypeQueryWhereSort on QueryBuilder<RoleType, QWhere> {
  QueryBuilder<RoleType, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<RoleType, QAfterWhere> anySort() {
    return addWhereClause(WhereClause(indexName: 'sort'));
  }

  QueryBuilder<RoleType, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension RoleTypeQueryWhere on QueryBuilder<RoleType, QWhereClause> {
  QueryBuilder<RoleType, QAfterWhereClause> valueEqualTo(String? value) {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [value],
      includeUpper: true,
      lower: [value],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> valueNotEqualTo(String? value) {
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

  QueryBuilder<RoleType, QAfterWhereClause> valueIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> valueIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'value',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> sortEqualTo(int? sort) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [sort],
      includeUpper: true,
      lower: [sort],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> sortNotEqualTo(int? sort) {
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

  QueryBuilder<RoleType, QAfterWhereClause> sortBetween(int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> sortGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> sortLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> sortIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> sortIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'sort',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<RoleType, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<RoleType, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension StoreQueryWhereSort on QueryBuilder<Store, QWhere> {
  QueryBuilder<Store, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension StoreQueryWhere on QueryBuilder<Store, QWhereClause> {}

extension CtableQueryWhereSort on QueryBuilder<Ctable, QWhere> {
  QueryBuilder<Ctable, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<Ctable, QAfterWhere> anyOrd() {
    return addWhereClause(WhereClause(indexName: 'ord'));
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

  QueryBuilder<Ctable, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: true,
      lower: [ord],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> ordNotEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> ordBetween(int? lower, int? upper,
      {bool includeLower = true, bool includeUpper = true}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [upper],
      includeUpper: includeUpper,
      lower: [lower],
      includeLower: includeLower,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> ordGreaterThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [value],
      includeLower: include,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> ordLessThan(int? value,
      {bool include = false}) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [value],
      includeUpper: include,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> ordIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> ordIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> optionTypeEqualTo(
      String? optionType) {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      upper: [optionType],
      includeUpper: true,
      lower: [optionType],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, QAfterWhereClause> optionTypeNotEqualTo(
      String? optionType) {
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

extension CtileLayerQueryWhereSort on QueryBuilder<CtileLayer, QWhere> {
  QueryBuilder<CtileLayer, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: 'isarId'));
  }

  QueryBuilder<CtileLayer, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CtileLayerQueryWhere on QueryBuilder<CtileLayer, QWhereClause> {
  QueryBuilder<CtileLayer, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      upper: [id],
      includeUpper: true,
      lower: [id],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<CtileLayer, QAfterWhereClause> labelEqualTo(String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [label],
      includeUpper: true,
      lower: [label],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> labelNotEqualTo(String? label) {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [label],
      includeUpper: false,
    )).addWhereClause(WhereClause(
      indexName: 'label',
      lower: [label],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> labelIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> labelIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'label',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [projectId],
      includeUpper: true,
      lower: [projectId],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> projectIdNotEqualTo(
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

  QueryBuilder<CtileLayer, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> serverRevAtEqualTo(
      String? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: true,
      lower: [serverRevAt],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<CtileLayer, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
      indexName: 'deleted',
      upper: [deleted],
      includeUpper: true,
      lower: [deleted],
      includeLower: true,
    ));
  }

  QueryBuilder<CtileLayer, QAfterWhereClause> deletedNotEqualTo(bool deleted) {
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

extension DbOperationQueryFilter
    on QueryBuilder<DbOperation, QFilterCondition> {
  QueryBuilder<DbOperation, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> idBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> timeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> timeEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> timeGreaterThan(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> timeLessThan(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> timeBetween(
      DateTime? lower, DateTime? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'time',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> tableIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'table',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> tableEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'table',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> tableStartsWith(
      String? value,
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

  QueryBuilder<DbOperation, QAfterFilterCondition> tableEndsWith(String? value,
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

  QueryBuilder<DbOperation, QAfterFilterCondition> tableContains(String? value,
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

  QueryBuilder<DbOperation, QAfterFilterCondition> tableMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'table',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> dataIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'data',
      value: null,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> dataEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'data',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DbOperation, QAfterFilterCondition> dataStartsWith(String? value,
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

  QueryBuilder<DbOperation, QAfterFilterCondition> dataEndsWith(String? value,
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

  QueryBuilder<DbOperation, QAfterFilterCondition> dataContains(String? value,
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

  QueryBuilder<DbOperation, QAfterFilterCondition> dataMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'data',
      value: pattern,
      caseSensitive: caseSensitive,
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

  QueryBuilder<Field, QAfterFilterCondition> ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> ordEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> ordGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> ordLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> ordBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      upper: upper,
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

  QueryBuilder<Field, QAfterFilterCondition> standardValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'standardValue',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> standardValueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> standardValueStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'standardValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> standardValueEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'standardValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> standardValueContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'standardValue',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> standardValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'standardValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> lastValueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'lastValue',
      value: null,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> lastValueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> lastValueStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'lastValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> lastValueEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'lastValue',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> lastValueContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'lastValue',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, QAfterFilterCondition> lastValueMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'lastValue',
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

extension CfileQueryFilter on QueryBuilder<Cfile, QFilterCondition> {
  QueryBuilder<Cfile, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> rowIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'rowId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> rowIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'rowId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> rowIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'rowId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> rowIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'rowId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> rowIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'rowId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> rowIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'rowId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> fieldIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fieldId',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> fieldIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fieldId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> fieldIdStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'fieldId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> fieldIdEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'fieldId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> fieldIdContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fieldId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> fieldIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fieldId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> filenameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'filename',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> filenameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'filename',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> filenameStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'filename',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> filenameEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'filename',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> filenameContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'filename',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> filenameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'filename',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> localPathIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'localPath',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> localPathEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> localPathStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'localPath',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> localPathEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'localPath',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> localPathContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'localPath',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> localPathMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'localPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> urlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> urlEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> urlStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'url',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> urlEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'url',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> urlContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'url',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> urlMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'url',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> versionIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'version',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> versionEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> versionGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> versionLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> versionBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'version',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevAtEndsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevAtContains(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevByEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevByEndsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevByContains(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> clientRevByMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> serverRevAtEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<Cfile, QAfterFilterCondition> serverRevAtEndsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> serverRevAtContains(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> serverRevAtMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> revIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'rev',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> revEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'rev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> revStartsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> revEndsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> revContains(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> revMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'rev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> parentRevIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentRev',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> parentRevEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentRev',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> parentRevStartsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> parentRevEndsWith(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> parentRevContains(String? value,
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

  QueryBuilder<Cfile, QAfterFilterCondition> parentRevMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentRev',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> depthIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'depth',
      value: null,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> depthEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> depthGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> depthLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Cfile, QAfterFilterCondition> depthBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'depth',
      lower: lower,
      upper: upper,
    ));
  }
}

extension FileOperationQueryFilter
    on QueryBuilder<FileOperation, QFilterCondition> {
  QueryBuilder<FileOperation, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> idBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> timeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'time',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> timeEqualTo(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> timeGreaterThan(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> timeLessThan(
      DateTime? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'time',
      value: value,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> timeBetween(
      DateTime? lower, DateTime? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'time',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> localPathIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'localPath',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> localPathEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'localPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> localPathStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'localPath',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> localPathEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'localPath',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> localPathContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'localPath',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> localPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'localPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> fileIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fileId',
      value: null,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> fileIdEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'fileId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> fileIdStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'fileId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> fileIdEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'fileId',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> fileIdContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fileId',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FileOperation, QAfterFilterCondition> fileIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'fileId',
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

  QueryBuilder<Project, QAfterFilterCondition> crsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'crs',
      value: null,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> crsEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'crs',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> crsGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'crs',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> crsLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'crs',
      value: value,
    ));
  }

  QueryBuilder<Project, QAfterFilterCondition> crsBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'crs',
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

extension ProjectTileLayerQueryFilter
    on QueryBuilder<ProjectTileLayer, QFilterCondition> {
  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> isarIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> isarIdLessThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> idStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> labelEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> labelStartsWith(
      String? value,
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> labelEndsWith(
      String? value,
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> labelContains(
      String? value,
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> ordEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> ordGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> ordLessThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> ordBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> activeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'active',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> activeEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'active',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> projectIdEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> projectIdStartsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> projectIdEndsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> projectIdContains(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> urlTemplateIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'urlTemplate',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> urlTemplateEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> urlTemplateStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'urlTemplate',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> urlTemplateEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'urlTemplate',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> urlTemplateContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'urlTemplate',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> urlTemplateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'urlTemplate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> maxZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'maxZoom',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> maxZoomGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> maxZoomLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> maxZoomBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'maxZoom',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> minZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'minZoom',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> minZoomGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> minZoomLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> minZoomBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'minZoom',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> opacityIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'opacity',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> opacityGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> opacityLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> opacityBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'opacity',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsBaseUrlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsBaseUrl',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsBaseUrlEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsBaseUrlStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsBaseUrl',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsBaseUrlEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsBaseUrl',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsBaseUrlContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsBaseUrl',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsBaseUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsBaseUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsFormatIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsFormat',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsFormatEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsFormatStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsFormat',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsFormatEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsFormat',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsFormatContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsFormat',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsFormatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsFormat',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsParametersIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsParameters',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsParametersEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsParametersStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsParameters',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsParametersEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsParameters',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsParametersContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsParameters',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsParametersMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsParameters',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsRequestIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsRequest',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsRequestEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsRequestStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsRequest',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsRequestEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsRequest',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsRequestContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsRequest',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsRequestMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsRequest',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsServiceIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsService',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsServiceEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsServiceStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsService',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsServiceEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsService',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsServiceContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsService',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsServiceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsService',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsTransparentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsTransparent',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsTransparentEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsTransparent',
      value: value,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsVersionIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsVersion',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsVersionEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsVersionStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsVersion',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsVersionEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsVersion',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsVersionContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsVersion',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> wmsVersionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsVersion',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevAtEndsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevAtContains(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevByEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevByContains(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ProjectTileLayer, QAfterFilterCondition> deletedEqualTo(
      bool value) {
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

extension RoleTypeQueryFilter on QueryBuilder<RoleType, QFilterCondition> {
  QueryBuilder<RoleType, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> isarIdGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> valueIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: null,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> valueEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'value',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> valueStartsWith(String? value,
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

  QueryBuilder<RoleType, QAfterFilterCondition> valueEndsWith(String? value,
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

  QueryBuilder<RoleType, QAfterFilterCondition> valueContains(String? value,
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

  QueryBuilder<RoleType, QAfterFilterCondition> valueMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'value',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> sortIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: null,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> sortEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> sortGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> sortLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'sort',
      value: value,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> sortBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'sort',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> commentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: null,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> commentEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> commentStartsWith(String? value,
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

  QueryBuilder<RoleType, QAfterFilterCondition> commentEndsWith(String? value,
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

  QueryBuilder<RoleType, QAfterFilterCondition> commentContains(String? value,
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

  QueryBuilder<RoleType, QAfterFilterCondition> commentMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<RoleType, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<RoleType, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<RoleType, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RoleType, QAfterFilterCondition> deletedEqualTo(bool value) {
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

  QueryBuilder<Crow, QAfterFilterCondition> parentIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentId',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentIdEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> parentIdStartsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> parentIdEndsWith(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> parentIdContains(String? value,
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

  QueryBuilder<Crow, QAfterFilterCondition> parentIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'parentId',
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

  QueryBuilder<Crow, QAfterFilterCondition> geometryNIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'geometryN',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryNGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'geometryN',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryNLessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'geometryN',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryNBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryN',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryEIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'geometryE',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryEGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'geometryE',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryELessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'geometryE',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryEBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryE',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometrySIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'geometryS',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometrySGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'geometryS',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometrySLessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'geometryS',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometrySBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryS',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryWIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'geometryW',
      value: null,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryWGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'geometryW',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryWLessThan(double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'geometryW',
      value: value,
    ));
  }

  QueryBuilder<Crow, QAfterFilterCondition> geometryWBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'geometryW',
      lower: lower,
      upper: upper,
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

extension StoreQueryFilter on QueryBuilder<Store, QFilterCondition> {
  QueryBuilder<Store, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> idBetween(int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> editingProjectIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'editingProject',
      value: null,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> editingProjectEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> editingProjectStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'editingProject',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> editingProjectEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'editingProject',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> editingProjectContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'editingProject',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> editingProjectMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'editingProject',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> largeLayoutTreeColumnSizeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'largeLayoutTreeColumnSize',
      value: null,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> largeLayoutTreeColumnSizeEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> largeLayoutTreeColumnSizeLessThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, QAfterFilterCondition> largeLayoutTreeColumnSizeBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'largeLayoutTreeColumnSize',
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

  QueryBuilder<Ctable, QAfterFilterCondition> singleLabelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'singleLabel',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> singleLabelEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> singleLabelStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'singleLabel',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> singleLabelEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'singleLabel',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> singleLabelContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'singleLabel',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> singleLabelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'singleLabel',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> ordEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> ordGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> ordLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> ordBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      upper: upper,
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

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'optionType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'optionType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'optionType',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'optionType',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, QAfterFilterCondition> optionTypeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'optionType',
      value: pattern,
      caseSensitive: caseSensitive,
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

extension CtileLayerQueryFilter on QueryBuilder<CtileLayer, QFilterCondition> {
  QueryBuilder<CtileLayer, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> isarIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> isarIdLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> isarIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> idEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'id',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> labelEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> labelStartsWith(String? value,
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> labelEndsWith(String? value,
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> labelContains(String? value,
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> projectIdEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> projectIdStartsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> projectIdEndsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> projectIdContains(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> urlTemplateIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'urlTemplate',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> urlTemplateEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'urlTemplate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> urlTemplateStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'urlTemplate',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> urlTemplateEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'urlTemplate',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> urlTemplateContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'urlTemplate',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> urlTemplateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'urlTemplate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> maxZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'maxZoom',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> maxZoomGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> maxZoomLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'maxZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> maxZoomBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'maxZoom',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> minZoomIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'minZoom',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> minZoomGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> minZoomLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'minZoom',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> minZoomBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'minZoom',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> opacityIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'opacity',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> opacityGreaterThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> opacityLessThan(
      double? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'opacity',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> opacityBetween(
      double? lower, double? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'opacity',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsBaseUrlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsBaseUrl',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsBaseUrlEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsBaseUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsBaseUrlStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsBaseUrl',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsBaseUrlEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsBaseUrl',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsBaseUrlContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsBaseUrl',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsBaseUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsBaseUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsFormatIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsFormat',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsFormatEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsFormat',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsFormatStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsFormat',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsFormatEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsFormat',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsFormatContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsFormat',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsFormatMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsFormat',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsParametersIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsParameters',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsParametersEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsParameters',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsParametersStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsParameters',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsParametersEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsParameters',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsParametersContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsParameters',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsParametersMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsParameters',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsRequestIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsRequest',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsRequestEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsRequest',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsRequestStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsRequest',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsRequestEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsRequest',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsRequestContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsRequest',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsRequestMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsRequest',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsServiceIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsService',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsServiceEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsService',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsServiceStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsService',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsServiceEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsService',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsServiceContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsService',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsServiceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsService',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsTransparentIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsTransparent',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsTransparentEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsTransparent',
      value: value,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsVersionIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsVersion',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsVersionEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'wmsVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsVersionStartsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'wmsVersion',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsVersionEndsWith(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'wmsVersion',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsVersionContains(
      String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsVersion',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> wmsVersionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'wmsVersion',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevAtStartsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevAtEndsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevAtContains(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevByEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevByContains(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> serverRevAtEqualTo(
      String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'serverRevAt',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> serverRevAtStartsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> serverRevAtEndsWith(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> serverRevAtContains(
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

  QueryBuilder<CtileLayer, QAfterFilterCondition> serverRevAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'serverRevAt',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CtileLayer, QAfterFilterCondition> deletedEqualTo(bool value) {
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

extension AccountQueryLinks on QueryBuilder<Account, QFilterCondition> {}

extension DbOperationQueryLinks on QueryBuilder<DbOperation, QFilterCondition> {
}

extension FieldQueryLinks on QueryBuilder<Field, QFilterCondition> {}

extension FieldTypeQueryLinks on QueryBuilder<FieldType, QFilterCondition> {}

extension CfileQueryLinks on QueryBuilder<Cfile, QFilterCondition> {}

extension FileOperationQueryLinks
    on QueryBuilder<FileOperation, QFilterCondition> {}

extension OptionTypeQueryLinks on QueryBuilder<OptionType, QFilterCondition> {}

extension ProjectQueryLinks on QueryBuilder<Project, QFilterCondition> {}

extension ProjectTileLayerQueryLinks
    on QueryBuilder<ProjectTileLayer, QFilterCondition> {}

extension ProjectUserQueryLinks on QueryBuilder<ProjectUser, QFilterCondition> {
}

extension RelTypeQueryLinks on QueryBuilder<RelType, QFilterCondition> {}

extension RoleTypeQueryLinks on QueryBuilder<RoleType, QFilterCondition> {}

extension CrowQueryLinks on QueryBuilder<Crow, QFilterCondition> {}

extension StoreQueryLinks on QueryBuilder<Store, QFilterCondition> {}

extension CtableQueryLinks on QueryBuilder<Ctable, QFilterCondition> {}

extension CtileLayerQueryLinks on QueryBuilder<CtileLayer, QFilterCondition> {}

extension CUserQueryLinks on QueryBuilder<CUser, QFilterCondition> {}

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

extension DbOperationQueryWhereSortBy on QueryBuilder<DbOperation, QSortBy> {
  QueryBuilder<DbOperation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.Desc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByTable() {
    return addSortByInternal('table', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByTableDesc() {
    return addSortByInternal('table', Sort.Desc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByData() {
    return addSortByInternal('data', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> sortByDataDesc() {
    return addSortByInternal('data', Sort.Desc);
  }
}

extension DbOperationQueryWhereSortThenBy
    on QueryBuilder<DbOperation, QSortThenBy> {
  QueryBuilder<DbOperation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.Desc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByTable() {
    return addSortByInternal('table', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByTableDesc() {
    return addSortByInternal('table', Sort.Desc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByData() {
    return addSortByInternal('data', Sort.Asc);
  }

  QueryBuilder<DbOperation, QAfterSortBy> thenByDataDesc() {
    return addSortByInternal('data', Sort.Desc);
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

  QueryBuilder<Field, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.Desc);
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

  QueryBuilder<Field, QAfterSortBy> sortByStandardValue() {
    return addSortByInternal('standardValue', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByLastValue() {
    return addSortByInternal('lastValue', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> sortByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.Desc);
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

  QueryBuilder<Field, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.Desc);
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

  QueryBuilder<Field, QAfterSortBy> thenByStandardValue() {
    return addSortByInternal('standardValue', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.Desc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByLastValue() {
    return addSortByInternal('lastValue', Sort.Asc);
  }

  QueryBuilder<Field, QAfterSortBy> thenByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.Desc);
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

extension CfileQueryWhereSortBy on QueryBuilder<Cfile, QSortBy> {
  QueryBuilder<Cfile, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByRowId() {
    return addSortByInternal('rowId', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByRowIdDesc() {
    return addSortByInternal('rowId', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByFieldId() {
    return addSortByInternal('fieldId', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByFieldIdDesc() {
    return addSortByInternal('fieldId', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByFilename() {
    return addSortByInternal('filename', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByFilenameDesc() {
    return addSortByInternal('filename', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByLocalPath() {
    return addSortByInternal('localPath', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByUrl() {
    return addSortByInternal('url', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByUrlDesc() {
    return addSortByInternal('url', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByVersion() {
    return addSortByInternal('version', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByVersionDesc() {
    return addSortByInternal('version', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByRev() {
    return addSortByInternal('rev', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByRevDesc() {
    return addSortByInternal('rev', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByParentRev() {
    return addSortByInternal('parentRev', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByDepth() {
    return addSortByInternal('depth', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> sortByDepthDesc() {
    return addSortByInternal('depth', Sort.Desc);
  }
}

extension CfileQueryWhereSortThenBy on QueryBuilder<Cfile, QSortThenBy> {
  QueryBuilder<Cfile, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByRowId() {
    return addSortByInternal('rowId', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByRowIdDesc() {
    return addSortByInternal('rowId', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByFieldId() {
    return addSortByInternal('fieldId', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByFieldIdDesc() {
    return addSortByInternal('fieldId', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByFilename() {
    return addSortByInternal('filename', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByFilenameDesc() {
    return addSortByInternal('filename', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByLocalPath() {
    return addSortByInternal('localPath', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByUrl() {
    return addSortByInternal('url', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByUrlDesc() {
    return addSortByInternal('url', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByVersion() {
    return addSortByInternal('version', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByVersionDesc() {
    return addSortByInternal('version', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByRev() {
    return addSortByInternal('rev', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByRevDesc() {
    return addSortByInternal('rev', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByParentRev() {
    return addSortByInternal('parentRev', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByParentRevDesc() {
    return addSortByInternal('parentRev', Sort.Desc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByDepth() {
    return addSortByInternal('depth', Sort.Asc);
  }

  QueryBuilder<Cfile, QAfterSortBy> thenByDepthDesc() {
    return addSortByInternal('depth', Sort.Desc);
  }
}

extension FileOperationQueryWhereSortBy
    on QueryBuilder<FileOperation, QSortBy> {
  QueryBuilder<FileOperation, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByTime() {
    return addSortByInternal('time', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByTimeDesc() {
    return addSortByInternal('time', Sort.Desc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByLocalPath() {
    return addSortByInternal('localPath', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.Desc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByFileId() {
    return addSortByInternal('fileId', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> sortByFileIdDesc() {
    return addSortByInternal('fileId', Sort.Desc);
  }
}

extension FileOperationQueryWhereSortThenBy
    on QueryBuilder<FileOperation, QSortThenBy> {
  QueryBuilder<FileOperation, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByTime() {
    return addSortByInternal('time', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByTimeDesc() {
    return addSortByInternal('time', Sort.Desc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByLocalPath() {
    return addSortByInternal('localPath', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByLocalPathDesc() {
    return addSortByInternal('localPath', Sort.Desc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByFileId() {
    return addSortByInternal('fileId', Sort.Asc);
  }

  QueryBuilder<FileOperation, QAfterSortBy> thenByFileIdDesc() {
    return addSortByInternal('fileId', Sort.Desc);
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

  QueryBuilder<Project, QAfterSortBy> sortByCrs() {
    return addSortByInternal('crs', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> sortByCrsDesc() {
    return addSortByInternal('crs', Sort.Desc);
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

  QueryBuilder<Project, QAfterSortBy> thenByCrs() {
    return addSortByInternal('crs', Sort.Asc);
  }

  QueryBuilder<Project, QAfterSortBy> thenByCrsDesc() {
    return addSortByInternal('crs', Sort.Desc);
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

extension ProjectTileLayerQueryWhereSortBy
    on QueryBuilder<ProjectTileLayer, QSortBy> {
  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByActive() {
    return addSortByInternal('active', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByActiveDesc() {
    return addSortByInternal('active', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByMinZoom() {
    return addSortByInternal('minZoom', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByOpacity() {
    return addSortByInternal('opacity', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByOpacityDesc() {
    return addSortByInternal('opacity', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsService() {
    return addSortByInternal('wmsService', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension ProjectTileLayerQueryWhereSortThenBy
    on QueryBuilder<ProjectTileLayer, QSortThenBy> {
  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByActive() {
    return addSortByInternal('active', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByActiveDesc() {
    return addSortByInternal('active', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByMinZoom() {
    return addSortByInternal('minZoom', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByOpacity() {
    return addSortByInternal('opacity', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByOpacityDesc() {
    return addSortByInternal('opacity', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsService() {
    return addSortByInternal('wmsService', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<ProjectTileLayer, QAfterSortBy> thenByDeletedDesc() {
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

extension RoleTypeQueryWhereSortBy on QueryBuilder<RoleType, QSortBy> {
  QueryBuilder<RoleType, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension RoleTypeQueryWhereSortThenBy on QueryBuilder<RoleType, QSortThenBy> {
  QueryBuilder<RoleType, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByValue() {
    return addSortByInternal('value', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByValueDesc() {
    return addSortByInternal('value', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenBySort() {
    return addSortByInternal('sort', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenBySortDesc() {
    return addSortByInternal('sort', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<RoleType, QAfterSortBy> thenByDeletedDesc() {
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

  QueryBuilder<Crow, QAfterSortBy> sortByParentId() {
    return addSortByInternal('parentId', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByParentIdDesc() {
    return addSortByInternal('parentId', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometry() {
    return addSortByInternal('geometry', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryDesc() {
    return addSortByInternal('geometry', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryN() {
    return addSortByInternal('geometryN', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryNDesc() {
    return addSortByInternal('geometryN', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryE() {
    return addSortByInternal('geometryE', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryEDesc() {
    return addSortByInternal('geometryE', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryS() {
    return addSortByInternal('geometryS', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometrySDesc() {
    return addSortByInternal('geometryS', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryW() {
    return addSortByInternal('geometryW', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> sortByGeometryWDesc() {
    return addSortByInternal('geometryW', Sort.Desc);
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

  QueryBuilder<Crow, QAfterSortBy> thenByParentId() {
    return addSortByInternal('parentId', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByParentIdDesc() {
    return addSortByInternal('parentId', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometry() {
    return addSortByInternal('geometry', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryDesc() {
    return addSortByInternal('geometry', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryN() {
    return addSortByInternal('geometryN', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryNDesc() {
    return addSortByInternal('geometryN', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryE() {
    return addSortByInternal('geometryE', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryEDesc() {
    return addSortByInternal('geometryE', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryS() {
    return addSortByInternal('geometryS', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometrySDesc() {
    return addSortByInternal('geometryS', Sort.Desc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryW() {
    return addSortByInternal('geometryW', Sort.Asc);
  }

  QueryBuilder<Crow, QAfterSortBy> thenByGeometryWDesc() {
    return addSortByInternal('geometryW', Sort.Desc);
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

extension StoreQueryWhereSortBy on QueryBuilder<Store, QSortBy> {
  QueryBuilder<Store, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Store, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Store, QAfterSortBy> sortByEditingProject() {
    return addSortByInternal('editingProject', Sort.Asc);
  }

  QueryBuilder<Store, QAfterSortBy> sortByEditingProjectDesc() {
    return addSortByInternal('editingProject', Sort.Desc);
  }

  QueryBuilder<Store, QAfterSortBy> sortByLargeLayoutTreeColumnSize() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.Asc);
  }

  QueryBuilder<Store, QAfterSortBy> sortByLargeLayoutTreeColumnSizeDesc() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.Desc);
  }
}

extension StoreQueryWhereSortThenBy on QueryBuilder<Store, QSortThenBy> {
  QueryBuilder<Store, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Store, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Store, QAfterSortBy> thenByEditingProject() {
    return addSortByInternal('editingProject', Sort.Asc);
  }

  QueryBuilder<Store, QAfterSortBy> thenByEditingProjectDesc() {
    return addSortByInternal('editingProject', Sort.Desc);
  }

  QueryBuilder<Store, QAfterSortBy> thenByLargeLayoutTreeColumnSize() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.Asc);
  }

  QueryBuilder<Store, QAfterSortBy> thenByLargeLayoutTreeColumnSizeDesc() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.Desc);
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

  QueryBuilder<Ctable, QAfterSortBy> sortBySingleLabel() {
    return addSortByInternal('singleLabel', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortBySingleLabelDesc() {
    return addSortByInternal('singleLabel', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.Desc);
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

  QueryBuilder<Ctable, QAfterSortBy> thenBySingleLabel() {
    return addSortByInternal('singleLabel', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenBySingleLabelDesc() {
    return addSortByInternal('singleLabel', Sort.Desc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.Asc);
  }

  QueryBuilder<Ctable, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.Desc);
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

extension CtileLayerQueryWhereSortBy on QueryBuilder<CtileLayer, QSortBy> {
  QueryBuilder<CtileLayer, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByMinZoom() {
    return addSortByInternal('minZoom', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByOpacity() {
    return addSortByInternal('opacity', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByOpacityDesc() {
    return addSortByInternal('opacity', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsService() {
    return addSortByInternal('wmsService', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.Desc);
  }
}

extension CtileLayerQueryWhereSortThenBy
    on QueryBuilder<CtileLayer, QSortThenBy> {
  QueryBuilder<CtileLayer, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByUrlTemplate() {
    return addSortByInternal('urlTemplate', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByUrlTemplateDesc() {
    return addSortByInternal('urlTemplate', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByMaxZoom() {
    return addSortByInternal('maxZoom', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByMaxZoomDesc() {
    return addSortByInternal('maxZoom', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByMinZoom() {
    return addSortByInternal('minZoom', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByMinZoomDesc() {
    return addSortByInternal('minZoom', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByOpacity() {
    return addSortByInternal('opacity', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByOpacityDesc() {
    return addSortByInternal('opacity', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsBaseUrl() {
    return addSortByInternal('wmsBaseUrl', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsBaseUrlDesc() {
    return addSortByInternal('wmsBaseUrl', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsFormat() {
    return addSortByInternal('wmsFormat', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsFormatDesc() {
    return addSortByInternal('wmsFormat', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsParameters() {
    return addSortByInternal('wmsParameters', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsParametersDesc() {
    return addSortByInternal('wmsParameters', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsRequest() {
    return addSortByInternal('wmsRequest', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsRequestDesc() {
    return addSortByInternal('wmsRequest', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsService() {
    return addSortByInternal('wmsService', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsServiceDesc() {
    return addSortByInternal('wmsService', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsTransparent() {
    return addSortByInternal('wmsTransparent', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsTransparentDesc() {
    return addSortByInternal('wmsTransparent', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsVersion() {
    return addSortByInternal('wmsVersion', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByWmsVersionDesc() {
    return addSortByInternal('wmsVersion', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.Desc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.Asc);
  }

  QueryBuilder<CtileLayer, QAfterSortBy> thenByDeletedDesc() {
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

extension DbOperationQueryWhereDistinct
    on QueryBuilder<DbOperation, QDistinct> {
  QueryBuilder<DbOperation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<DbOperation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }

  QueryBuilder<DbOperation, QDistinct> distinctByTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('table', caseSensitive: caseSensitive);
  }

  QueryBuilder<DbOperation, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('data', caseSensitive: caseSensitive);
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

  QueryBuilder<Field, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
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

  QueryBuilder<Field, QDistinct> distinctByStandardValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('standardValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, QDistinct> distinctByLastValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('lastValue', caseSensitive: caseSensitive);
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

extension CfileQueryWhereDistinct on QueryBuilder<Cfile, QDistinct> {
  QueryBuilder<Cfile, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Cfile, QDistinct> distinctById({bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByRowId({bool caseSensitive = true}) {
    return addDistinctByInternal('rowId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByFieldId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByFilename(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('filename', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('localPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByUrl({bool caseSensitive = true}) {
    return addDistinctByInternal('url', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByVersion() {
    return addDistinctByInternal('version');
  }

  QueryBuilder<Cfile, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Cfile, QDistinct> distinctByRev({bool caseSensitive = true}) {
    return addDistinctByInternal('rev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByParentRev(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentRev', caseSensitive: caseSensitive);
  }

  QueryBuilder<Cfile, QDistinct> distinctByDepth() {
    return addDistinctByInternal('depth');
  }
}

extension FileOperationQueryWhereDistinct
    on QueryBuilder<FileOperation, QDistinct> {
  QueryBuilder<FileOperation, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<FileOperation, QDistinct> distinctByTime() {
    return addDistinctByInternal('time');
  }

  QueryBuilder<FileOperation, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('localPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<FileOperation, QDistinct> distinctByFileId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fileId', caseSensitive: caseSensitive);
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

  QueryBuilder<Project, QDistinct> distinctByCrs() {
    return addDistinctByInternal('crs');
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

extension ProjectTileLayerQueryWhereDistinct
    on QueryBuilder<ProjectTileLayer, QDistinct> {
  QueryBuilder<ProjectTileLayer, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByActive() {
    return addDistinctByInternal('active');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByUrlTemplate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('urlTemplate', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByMaxZoom() {
    return addDistinctByInternal('maxZoom');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByMinZoom() {
    return addDistinctByInternal('minZoom');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByOpacity() {
    return addDistinctByInternal('opacity');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsBaseUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsBaseUrl', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsFormat(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsFormat', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsParameters(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsParameters', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsRequest(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsRequest', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsService(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsService', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsTransparent() {
    return addDistinctByInternal('wmsTransparent');
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByWmsVersion(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsVersion', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<ProjectTileLayer, QDistinct> distinctByDeleted() {
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

extension RoleTypeQueryWhereDistinct on QueryBuilder<RoleType, QDistinct> {
  QueryBuilder<RoleType, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<RoleType, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('value', caseSensitive: caseSensitive);
  }

  QueryBuilder<RoleType, QDistinct> distinctBySort() {
    return addDistinctByInternal('sort');
  }

  QueryBuilder<RoleType, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<RoleType, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<RoleType, QDistinct> distinctByDeleted() {
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

  QueryBuilder<Crow, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByGeometry(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('geometry', caseSensitive: caseSensitive);
  }

  QueryBuilder<Crow, QDistinct> distinctByGeometryN() {
    return addDistinctByInternal('geometryN');
  }

  QueryBuilder<Crow, QDistinct> distinctByGeometryE() {
    return addDistinctByInternal('geometryE');
  }

  QueryBuilder<Crow, QDistinct> distinctByGeometryS() {
    return addDistinctByInternal('geometryS');
  }

  QueryBuilder<Crow, QDistinct> distinctByGeometryW() {
    return addDistinctByInternal('geometryW');
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

extension StoreQueryWhereDistinct on QueryBuilder<Store, QDistinct> {
  QueryBuilder<Store, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Store, QDistinct> distinctByEditingProject(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('editingProject',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Store, QDistinct> distinctByLargeLayoutTreeColumnSize() {
    return addDistinctByInternal('largeLayoutTreeColumnSize');
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

  QueryBuilder<Ctable, QDistinct> distinctBySingleLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('singleLabel', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
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

  QueryBuilder<Ctable, QDistinct> distinctByOptionType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionType', caseSensitive: caseSensitive);
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

extension CtileLayerQueryWhereDistinct on QueryBuilder<CtileLayer, QDistinct> {
  QueryBuilder<CtileLayer, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<CtileLayer, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByUrlTemplate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('urlTemplate', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByMaxZoom() {
    return addDistinctByInternal('maxZoom');
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByMinZoom() {
    return addDistinctByInternal('minZoom');
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByOpacity() {
    return addDistinctByInternal('opacity');
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsBaseUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsBaseUrl', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsFormat(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsFormat', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsParameters(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsParameters', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsRequest(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsRequest', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsService(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsService', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsTransparent() {
    return addDistinctByInternal('wmsTransparent');
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByWmsVersion(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('wmsVersion', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByClientRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByServerRevAt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('serverRevAt', caseSensitive: caseSensitive);
  }

  QueryBuilder<CtileLayer, QDistinct> distinctByDeleted() {
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

extension DbOperationQueryProperty
    on QueryBuilder<DbOperation, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<DateTime?, QQueryOperations> timeProperty() {
    return addPropertyName('time');
  }

  QueryBuilder<String?, QQueryOperations> tableProperty() {
    return addPropertyName('table');
  }

  QueryBuilder<String?, QQueryOperations> dataProperty() {
    return addPropertyName('data');
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

  QueryBuilder<int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
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

  QueryBuilder<String?, QQueryOperations> standardValueProperty() {
    return addPropertyName('standardValue');
  }

  QueryBuilder<String?, QQueryOperations> lastValueProperty() {
    return addPropertyName('lastValue');
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

extension CfileQueryProperty on QueryBuilder<Cfile, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> rowIdProperty() {
    return addPropertyName('rowId');
  }

  QueryBuilder<String?, QQueryOperations> fieldIdProperty() {
    return addPropertyName('fieldId');
  }

  QueryBuilder<String?, QQueryOperations> filenameProperty() {
    return addPropertyName('filename');
  }

  QueryBuilder<String?, QQueryOperations> localPathProperty() {
    return addPropertyName('localPath');
  }

  QueryBuilder<String?, QQueryOperations> urlProperty() {
    return addPropertyName('url');
  }

  QueryBuilder<int?, QQueryOperations> versionProperty() {
    return addPropertyName('version');
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

extension FileOperationQueryProperty
    on QueryBuilder<FileOperation, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<DateTime?, QQueryOperations> timeProperty() {
    return addPropertyName('time');
  }

  QueryBuilder<String?, QQueryOperations> localPathProperty() {
    return addPropertyName('localPath');
  }

  QueryBuilder<String?, QQueryOperations> fileIdProperty() {
    return addPropertyName('fileId');
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

  QueryBuilder<int?, QQueryOperations> crsProperty() {
    return addPropertyName('crs');
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

extension ProjectTileLayerQueryProperty
    on QueryBuilder<ProjectTileLayer, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
  }

  QueryBuilder<bool?, QQueryOperations> activeProperty() {
    return addPropertyName('active');
  }

  QueryBuilder<String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<String?, QQueryOperations> urlTemplateProperty() {
    return addPropertyName('urlTemplate');
  }

  QueryBuilder<List<String>?, QQueryOperations> subdomainsProperty() {
    return addPropertyName('subdomains');
  }

  QueryBuilder<double?, QQueryOperations> maxZoomProperty() {
    return addPropertyName('maxZoom');
  }

  QueryBuilder<double?, QQueryOperations> minZoomProperty() {
    return addPropertyName('minZoom');
  }

  QueryBuilder<double?, QQueryOperations> opacityProperty() {
    return addPropertyName('opacity');
  }

  QueryBuilder<String?, QQueryOperations> wmsBaseUrlProperty() {
    return addPropertyName('wmsBaseUrl');
  }

  QueryBuilder<String?, QQueryOperations> wmsFormatProperty() {
    return addPropertyName('wmsFormat');
  }

  QueryBuilder<List<String>?, QQueryOperations> wmsLayersProperty() {
    return addPropertyName('wmsLayers');
  }

  QueryBuilder<String?, QQueryOperations> wmsParametersProperty() {
    return addPropertyName('wmsParameters');
  }

  QueryBuilder<String?, QQueryOperations> wmsRequestProperty() {
    return addPropertyName('wmsRequest');
  }

  QueryBuilder<String?, QQueryOperations> wmsServiceProperty() {
    return addPropertyName('wmsService');
  }

  QueryBuilder<List<String>?, QQueryOperations> wmsStylesProperty() {
    return addPropertyName('wmsStyles');
  }

  QueryBuilder<bool?, QQueryOperations> wmsTransparentProperty() {
    return addPropertyName('wmsTransparent');
  }

  QueryBuilder<String?, QQueryOperations> wmsVersionProperty() {
    return addPropertyName('wmsVersion');
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

extension RoleTypeQueryProperty on QueryBuilder<RoleType, QQueryProperty> {
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

  QueryBuilder<String?, QQueryOperations> parentIdProperty() {
    return addPropertyName('parentId');
  }

  QueryBuilder<String?, QQueryOperations> geometryProperty() {
    return addPropertyName('geometry');
  }

  QueryBuilder<double?, QQueryOperations> geometryNProperty() {
    return addPropertyName('geometryN');
  }

  QueryBuilder<double?, QQueryOperations> geometryEProperty() {
    return addPropertyName('geometryE');
  }

  QueryBuilder<double?, QQueryOperations> geometrySProperty() {
    return addPropertyName('geometryS');
  }

  QueryBuilder<double?, QQueryOperations> geometryWProperty() {
    return addPropertyName('geometryW');
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

extension StoreQueryProperty on QueryBuilder<Store, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<List<String>?, QQueryOperations> urlProperty() {
    return addPropertyName('url');
  }

  QueryBuilder<String?, QQueryOperations> editingProjectProperty() {
    return addPropertyName('editingProject');
  }

  QueryBuilder<int?, QQueryOperations> largeLayoutTreeColumnSizeProperty() {
    return addPropertyName('largeLayoutTreeColumnSize');
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

  QueryBuilder<String?, QQueryOperations> singleLabelProperty() {
    return addPropertyName('singleLabel');
  }

  QueryBuilder<int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
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

  QueryBuilder<String?, QQueryOperations> optionTypeProperty() {
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

extension CtileLayerQueryProperty on QueryBuilder<CtileLayer, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<String?, QQueryOperations> urlTemplateProperty() {
    return addPropertyName('urlTemplate');
  }

  QueryBuilder<List<String>?, QQueryOperations> subdomainsProperty() {
    return addPropertyName('subdomains');
  }

  QueryBuilder<double?, QQueryOperations> maxZoomProperty() {
    return addPropertyName('maxZoom');
  }

  QueryBuilder<double?, QQueryOperations> minZoomProperty() {
    return addPropertyName('minZoom');
  }

  QueryBuilder<double?, QQueryOperations> opacityProperty() {
    return addPropertyName('opacity');
  }

  QueryBuilder<String?, QQueryOperations> wmsBaseUrlProperty() {
    return addPropertyName('wmsBaseUrl');
  }

  QueryBuilder<String?, QQueryOperations> wmsFormatProperty() {
    return addPropertyName('wmsFormat');
  }

  QueryBuilder<List<String>?, QQueryOperations> wmsLayersProperty() {
    return addPropertyName('wmsLayers');
  }

  QueryBuilder<String?, QQueryOperations> wmsParametersProperty() {
    return addPropertyName('wmsParameters');
  }

  QueryBuilder<String?, QQueryOperations> wmsRequestProperty() {
    return addPropertyName('wmsRequest');
  }

  QueryBuilder<String?, QQueryOperations> wmsServiceProperty() {
    return addPropertyName('wmsService');
  }

  QueryBuilder<List<String>?, QQueryOperations> wmsStylesProperty() {
    return addPropertyName('wmsStyles');
  }

  QueryBuilder<bool?, QQueryOperations> wmsTransparentProperty() {
    return addPropertyName('wmsTransparent');
  }

  QueryBuilder<String?, QQueryOperations> wmsVersionProperty() {
    return addPropertyName('wmsVersion');
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
