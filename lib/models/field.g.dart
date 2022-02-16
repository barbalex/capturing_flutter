// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetFieldCollection on Isar {
  IsarCollection<Field> get fields {
    return getCollection('Field');
  }
}

final FieldSchema = CollectionSchema(
  name: 'Field',
  schema:
      '{"name":"Field","idName":"isarId","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Bool"},{"name":"fieldType","type":"String"},{"name":"id","type":"String"},{"name":"isInternalId","type":"Bool"},{"name":"label","type":"String"},{"name":"lastValue","type":"String"},{"name":"name","type":"String"},{"name":"optionsTable","type":"String"},{"name":"ord","type":"Long"},{"name":"serverRevAt","type":"Long"},{"name":"standardValue","type":"String"},{"name":"tableId","type":"String"},{"name":"widgetType","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"name_tableId","unique":false,"properties":[{"name":"name","type":"Hash","caseSensitive":true},{"name":"tableId","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"tableId","unique":false,"properties":[{"name":"tableId","type":"Hash","caseSensitive":true}]}],"links":[]}',
  nativeAdapter: const _FieldNativeAdapter(),
  webAdapter: const _FieldWebAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'deleted': 2,
    'fieldType': 3,
    'id': 4,
    'isInternalId': 5,
    'label': 6,
    'lastValue': 7,
    'name': 8,
    'optionsTable': 9,
    'ord': 10,
    'serverRevAt': 11,
    'standardValue': 12,
    'tableId': 13,
    'widgetType': 14
  },
  listProperties: {},
  indexIds: {
    'deleted': 0,
    'id': 1,
    'name_tableId': 2,
    'ord': 3,
    'serverRevAt': 4,
    'tableId': 5
  },
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'name_tableId': [
      NativeIndexType.stringHash,
      NativeIndexType.stringHash,
    ],
    'ord': [
      NativeIndexType.long,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ],
    'tableId': [
      NativeIndexType.stringHash,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.isarId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.isarId;
    }
  },
  setId: (obj, id) => obj.isarId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _FieldWebAdapter extends IsarWebTypeAdapter<Field> {
  const _FieldWebAdapter();

  @override
  Object serialize(IsarCollection<Field> collection, Field object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'clientRevAt',
        object.clientRevAt?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'clientRevBy', object.clientRevBy);
    IsarNative.jsObjectSet(jsObj, 'deleted', object.deleted);
    IsarNative.jsObjectSet(jsObj, 'fieldType', object.fieldType);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'isInternalId', object.isInternalId);
    IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
    IsarNative.jsObjectSet(jsObj, 'label', object.label);
    IsarNative.jsObjectSet(jsObj, 'lastValue', object.lastValue);
    IsarNative.jsObjectSet(jsObj, 'name', object.name);
    IsarNative.jsObjectSet(jsObj, 'optionsTable', object.optionsTable);
    IsarNative.jsObjectSet(jsObj, 'ord', object.ord);
    IsarNative.jsObjectSet(jsObj, 'serverRevAt',
        object.serverRevAt.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'standardValue', object.standardValue);
    IsarNative.jsObjectSet(jsObj, 'tableId', object.tableId);
    IsarNative.jsObjectSet(jsObj, 'widgetType', object.widgetType);
    return jsObj;
  }

  @override
  Field deserialize(IsarCollection<Field> collection, dynamic jsObj) {
    final object = Field(
      clientRevAt: IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                  isUtc: true)
              .toLocal()
          : null,
      clientRevBy: IsarNative.jsObjectGet(jsObj, 'clientRevBy'),
      fieldType: IsarNative.jsObjectGet(jsObj, 'fieldType'),
      isInternalId: IsarNative.jsObjectGet(jsObj, 'isInternalId'),
      label: IsarNative.jsObjectGet(jsObj, 'label'),
      lastValue: IsarNative.jsObjectGet(jsObj, 'lastValue'),
      name: IsarNative.jsObjectGet(jsObj, 'name'),
      optionsTable: IsarNative.jsObjectGet(jsObj, 'optionsTable'),
      ord: IsarNative.jsObjectGet(jsObj, 'ord'),
      standardValue: IsarNative.jsObjectGet(jsObj, 'standardValue'),
      tableId: IsarNative.jsObjectGet(jsObj, 'tableId'),
      widgetType: IsarNative.jsObjectGet(jsObj, 'widgetType'),
    );
    object.deleted = IsarNative.jsObjectGet(jsObj, 'deleted') ?? false;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? '';
    object.isarId = IsarNative.jsObjectGet(jsObj, 'isarId');
    object.serverRevAt = IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'clientRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                    isUtc: true)
                .toLocal()
            : null) as P;
      case 'clientRevBy':
        return (IsarNative.jsObjectGet(jsObj, 'clientRevBy')) as P;
      case 'deleted':
        return (IsarNative.jsObjectGet(jsObj, 'deleted') ?? false) as P;
      case 'fieldType':
        return (IsarNative.jsObjectGet(jsObj, 'fieldType')) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
      case 'isInternalId':
        return (IsarNative.jsObjectGet(jsObj, 'isInternalId')) as P;
      case 'isarId':
        return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
      case 'label':
        return (IsarNative.jsObjectGet(jsObj, 'label')) as P;
      case 'lastValue':
        return (IsarNative.jsObjectGet(jsObj, 'lastValue')) as P;
      case 'name':
        return (IsarNative.jsObjectGet(jsObj, 'name')) as P;
      case 'optionsTable':
        return (IsarNative.jsObjectGet(jsObj, 'optionsTable')) as P;
      case 'ord':
        return (IsarNative.jsObjectGet(jsObj, 'ord')) as P;
      case 'serverRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'standardValue':
        return (IsarNative.jsObjectGet(jsObj, 'standardValue')) as P;
      case 'tableId':
        return (IsarNative.jsObjectGet(jsObj, 'tableId')) as P;
      case 'widgetType':
        return (IsarNative.jsObjectGet(jsObj, 'widgetType')) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Field object) {}
}

class _FieldNativeAdapter extends IsarNativeTypeAdapter<Field> {
  const _FieldNativeAdapter();

  @override
  void serialize(IsarCollection<Field> collection, IsarRawObject rawObj,
      Field object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.clientRevAt;
    final _clientRevAt = value0;
    final value1 = object.clientRevBy;
    IsarUint8List? _clientRevBy;
    if (value1 != null) {
      _clientRevBy = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_clientRevBy?.length ?? 0) as int;
    final value2 = object.deleted;
    final _deleted = value2;
    final value3 = object.fieldType;
    IsarUint8List? _fieldType;
    if (value3 != null) {
      _fieldType = IsarBinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += (_fieldType?.length ?? 0) as int;
    final value4 = object.id;
    final _id = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_id.length) as int;
    final value5 = object.isInternalId;
    final _isInternalId = value5;
    final value6 = object.label;
    IsarUint8List? _label;
    if (value6 != null) {
      _label = IsarBinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += (_label?.length ?? 0) as int;
    final value7 = object.lastValue;
    IsarUint8List? _lastValue;
    if (value7 != null) {
      _lastValue = IsarBinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += (_lastValue?.length ?? 0) as int;
    final value8 = object.name;
    IsarUint8List? _name;
    if (value8 != null) {
      _name = IsarBinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += (_name?.length ?? 0) as int;
    final value9 = object.optionsTable;
    IsarUint8List? _optionsTable;
    if (value9 != null) {
      _optionsTable = IsarBinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += (_optionsTable?.length ?? 0) as int;
    final value10 = object.ord;
    final _ord = value10;
    final value11 = object.serverRevAt;
    final _serverRevAt = value11;
    final value12 = object.standardValue;
    IsarUint8List? _standardValue;
    if (value12 != null) {
      _standardValue = IsarBinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += (_standardValue?.length ?? 0) as int;
    final value13 = object.tableId;
    IsarUint8List? _tableId;
    if (value13 != null) {
      _tableId = IsarBinaryWriter.utf8Encoder.convert(value13);
    }
    dynamicSize += (_tableId?.length ?? 0) as int;
    final value14 = object.widgetType;
    IsarUint8List? _widgetType;
    if (value14 != null) {
      _widgetType = IsarBinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += (_widgetType?.length ?? 0) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeBool(offsets[2], _deleted);
    writer.writeBytes(offsets[3], _fieldType);
    writer.writeBytes(offsets[4], _id);
    writer.writeBool(offsets[5], _isInternalId);
    writer.writeBytes(offsets[6], _label);
    writer.writeBytes(offsets[7], _lastValue);
    writer.writeBytes(offsets[8], _name);
    writer.writeBytes(offsets[9], _optionsTable);
    writer.writeLong(offsets[10], _ord);
    writer.writeDateTime(offsets[11], _serverRevAt);
    writer.writeBytes(offsets[12], _standardValue);
    writer.writeBytes(offsets[13], _tableId);
    writer.writeBytes(offsets[14], _widgetType);
  }

  @override
  Field deserialize(IsarCollection<Field> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Field(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      fieldType: reader.readStringOrNull(offsets[3]),
      isInternalId: reader.readBoolOrNull(offsets[5]),
      label: reader.readStringOrNull(offsets[6]),
      lastValue: reader.readStringOrNull(offsets[7]),
      name: reader.readStringOrNull(offsets[8]),
      optionsTable: reader.readStringOrNull(offsets[9]),
      ord: reader.readLongOrNull(offsets[10]),
      standardValue: reader.readStringOrNull(offsets[12]),
      tableId: reader.readStringOrNull(offsets[13]),
      widgetType: reader.readStringOrNull(offsets[14]),
    );
    object.deleted = reader.readBool(offsets[2]);
    object.id = reader.readString(offsets[4]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[11]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readBool(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
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
        return (reader.readLongOrNull(offset)) as P;
      case 11:
        return (reader.readDateTime(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readStringOrNull(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Field object) {}
}

extension FieldQueryWhereSort on QueryBuilder<Field, Field, QWhere> {
  QueryBuilder<Field, Field, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyDeleted() {
    return addWhereClauseInternal(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyNameTableId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'name_tableId'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyOrd() {
    return addWhereClauseInternal(const WhereClause(indexName: 'ord'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyServerRevAt() {
    return addWhereClauseInternal(const WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Field, Field, QAfterWhere> anyTableId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'tableId'));
  }
}

extension FieldQueryWhere on QueryBuilder<Field, Field, QWhereClause> {
  QueryBuilder<Field, Field, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdNotEqualTo(int? isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [isarId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [isarId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> isarIdBetween(
    int? lowerIsarId,
    int? upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerIsarId],
      includeLower: includeLower,
      upper: [upperIsarId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> deletedNotEqualTo(
      bool deleted) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> idNotEqualTo(String id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'name_tableId',
      lower: [name],
      includeLower: true,
      upper: [name],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameNotEqualTo(String? name) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        upper: [name],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        lower: [name],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        lower: [name],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        upper: [name],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameTableIdEqualTo(
      String? name, String? tableId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'name_tableId',
      lower: [name, tableId],
      includeLower: true,
      upper: [name, tableId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> nameTableIdNotEqualTo(
      String? name, String? tableId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        upper: [name, tableId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        lower: [name, tableId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        lower: [name, tableId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_tableId',
        upper: [name, tableId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: true,
      upper: [ord],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordNotEqualTo(int? ord) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordGreaterThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordLessThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> ordBetween(
    int? lowerOrd,
    int? upperOrd, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      lower: [lowerOrd],
      includeLower: includeLower,
      upper: [upperOrd],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtEqualTo(
      DateTime serverRevAt) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtNotEqualTo(
      DateTime serverRevAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> serverRevAtBetween(
    DateTime lowerServerRevAt,
    DateTime upperServerRevAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [lowerServerRevAt],
      includeLower: includeLower,
      upper: [upperServerRevAt],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdEqualTo(
      String? tableId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'tableId',
      lower: [tableId],
      includeLower: true,
      upper: [tableId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdNotEqualTo(
      String? tableId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'tableId',
        upper: [tableId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'tableId',
        lower: [tableId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'tableId',
        lower: [tableId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'tableId',
        upper: [tableId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'tableId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Field, Field, QAfterWhereClause> tableIdIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'tableId',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension FieldQueryFilter on QueryBuilder<Field, Field, QFilterCondition> {
  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'clientRevBy',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> deletedEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'fieldType',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fieldType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fieldType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> fieldTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fieldType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isInternalIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isInternalId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isInternalIdEqualTo(
      bool? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isInternalId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'label',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'lastValue',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'lastValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'lastValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> lastValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'lastValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'optionsTable',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'optionsTable',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'optionsTable',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> optionsTableMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'optionsTable',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> ordBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'ord',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> serverRevAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'standardValue',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'standardValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'standardValue',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> standardValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'standardValue',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'tableId',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tableId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'tableId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> tableIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'tableId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'widgetType',
      value: null,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'widgetType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'widgetType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Field, Field, QAfterFilterCondition> widgetTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'widgetType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension FieldQueryWhereSortBy on QueryBuilder<Field, Field, QSortBy> {
  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByFieldType() {
    return addSortByInternal('fieldType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLastValue() {
    return addSortByInternal('lastValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByStandardValue() {
    return addSortByInternal('standardValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByWidgetType() {
    return addSortByInternal('widgetType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> sortByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.desc);
  }
}

extension FieldQueryWhereSortThenBy on QueryBuilder<Field, Field, QSortThenBy> {
  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByFieldType() {
    return addSortByInternal('fieldType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByFieldTypeDesc() {
    return addSortByInternal('fieldType', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsInternalId() {
    return addSortByInternal('isInternalId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsInternalIdDesc() {
    return addSortByInternal('isInternalId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLastValue() {
    return addSortByInternal('lastValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByLastValueDesc() {
    return addSortByInternal('lastValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOptionsTable() {
    return addSortByInternal('optionsTable', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOptionsTableDesc() {
    return addSortByInternal('optionsTable', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByStandardValue() {
    return addSortByInternal('standardValue', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByStandardValueDesc() {
    return addSortByInternal('standardValue', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByTableId() {
    return addSortByInternal('tableId', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByTableIdDesc() {
    return addSortByInternal('tableId', Sort.desc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByWidgetType() {
    return addSortByInternal('widgetType', Sort.asc);
  }

  QueryBuilder<Field, Field, QAfterSortBy> thenByWidgetTypeDesc() {
    return addSortByInternal('widgetType', Sort.desc);
  }
}

extension FieldQueryWhereDistinct on QueryBuilder<Field, Field, QDistinct> {
  QueryBuilder<Field, Field, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByFieldType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fieldType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByIsInternalId() {
    return addDistinctByInternal('isInternalId');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByLastValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('lastValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByOptionsTable(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionsTable', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Field, Field, QDistinct> distinctByStandardValue(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('standardValue', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByTableId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tableId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Field, Field, QDistinct> distinctByWidgetType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('widgetType', caseSensitive: caseSensitive);
  }
}

extension FieldQueryProperty on QueryBuilder<Field, Field, QQueryProperty> {
  QueryBuilder<Field, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyNameInternal('clientRevAt');
  }

  QueryBuilder<Field, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyNameInternal('clientRevBy');
  }

  QueryBuilder<Field, bool, QQueryOperations> deletedProperty() {
    return addPropertyNameInternal('deleted');
  }

  QueryBuilder<Field, String?, QQueryOperations> fieldTypeProperty() {
    return addPropertyNameInternal('fieldType');
  }

  QueryBuilder<Field, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Field, bool?, QQueryOperations> isInternalIdProperty() {
    return addPropertyNameInternal('isInternalId');
  }

  QueryBuilder<Field, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<Field, String?, QQueryOperations> labelProperty() {
    return addPropertyNameInternal('label');
  }

  QueryBuilder<Field, String?, QQueryOperations> lastValueProperty() {
    return addPropertyNameInternal('lastValue');
  }

  QueryBuilder<Field, String?, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<Field, String?, QQueryOperations> optionsTableProperty() {
    return addPropertyNameInternal('optionsTable');
  }

  QueryBuilder<Field, int?, QQueryOperations> ordProperty() {
    return addPropertyNameInternal('ord');
  }

  QueryBuilder<Field, DateTime, QQueryOperations> serverRevAtProperty() {
    return addPropertyNameInternal('serverRevAt');
  }

  QueryBuilder<Field, String?, QQueryOperations> standardValueProperty() {
    return addPropertyNameInternal('standardValue');
  }

  QueryBuilder<Field, String?, QQueryOperations> tableIdProperty() {
    return addPropertyNameInternal('tableId');
  }

  QueryBuilder<Field, String?, QQueryOperations> widgetTypeProperty() {
    return addPropertyNameInternal('widgetType');
  }
}
