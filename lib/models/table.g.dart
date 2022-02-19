// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetCtableCollection on Isar {
  IsarCollection<Ctable> get ctables {
    return getCollection('Ctable');
  }
}

final CtableSchema = CollectionSchema(
  name: 'Ctable',
  schema:
      '{"name":"Ctable","idName":"isarId","properties":[{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"deleted","type":"Bool"},{"name":"id","type":"String"},{"name":"label","type":"String"},{"name":"labelFields","type":"StringList"},{"name":"labelFieldsSeparator","type":"String"},{"name":"name","type":"String"},{"name":"optionType","type":"String"},{"name":"ord","type":"Long"},{"name":"parentId","type":"String"},{"name":"projectId","type":"String"},{"name":"relType","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"singleLabel","type":"String"}],"indexes":[{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]},{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"name_projectId","unique":false,"properties":[{"name":"name","type":"Hash","caseSensitive":true},{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"optionType","unique":false,"properties":[{"name":"optionType","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]}],"links":[]}',
  nativeAdapter: const _CtableNativeAdapter(),
  webAdapter: const _CtableWebAdapter(),
  idName: 'isarId',
  propertyIds: {
    'clientRevAt': 0,
    'clientRevBy': 1,
    'deleted': 2,
    'id': 3,
    'label': 4,
    'labelFields': 5,
    'labelFieldsSeparator': 6,
    'name': 7,
    'optionType': 8,
    'ord': 9,
    'parentId': 10,
    'projectId': 11,
    'relType': 12,
    'serverRevAt': 13,
    'singleLabel': 14
  },
  listProperties: {'labelFields'},
  indexIds: {
    'deleted': 0,
    'id': 1,
    'name_projectId': 2,
    'optionType': 3,
    'ord': 4,
    'projectId': 5,
    'serverRevAt': 6
  },
  indexTypes: {
    'deleted': [
      NativeIndexType.bool,
    ],
    'id': [
      NativeIndexType.stringHash,
    ],
    'name_projectId': [
      NativeIndexType.stringHash,
      NativeIndexType.stringHash,
    ],
    'optionType': [
      NativeIndexType.stringHash,
    ],
    'ord': [
      NativeIndexType.long,
    ],
    'projectId': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
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

class _CtableWebAdapter extends IsarWebTypeAdapter<Ctable> {
  const _CtableWebAdapter();

  @override
  Object serialize(IsarCollection<Ctable> collection, Ctable object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'clientRevAt',
        object.clientRevAt?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'clientRevBy', object.clientRevBy);
    IsarNative.jsObjectSet(jsObj, 'deleted', object.deleted);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
    IsarNative.jsObjectSet(jsObj, 'label', object.label);
    IsarNative.jsObjectSet(jsObj, 'labelFields', object.labelFields);
    IsarNative.jsObjectSet(
        jsObj, 'labelFieldsSeparator', object.labelFieldsSeparator);
    IsarNative.jsObjectSet(jsObj, 'name', object.name);
    IsarNative.jsObjectSet(jsObj, 'optionType', object.optionType);
    IsarNative.jsObjectSet(jsObj, 'ord', object.ord);
    IsarNative.jsObjectSet(jsObj, 'parentId', object.parentId);
    IsarNative.jsObjectSet(jsObj, 'projectId', object.projectId);
    IsarNative.jsObjectSet(jsObj, 'relType', object.relType);
    IsarNative.jsObjectSet(jsObj, 'serverRevAt',
        object.serverRevAt.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'singleLabel', object.singleLabel);
    return jsObj;
  }

  @override
  Ctable deserialize(IsarCollection<Ctable> collection, dynamic jsObj) {
    final object = Ctable(
      clientRevAt: IsarNative.jsObjectGet(jsObj, 'clientRevAt') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'clientRevAt'),
                  isUtc: true)
              .toLocal()
          : null,
      clientRevBy: IsarNative.jsObjectGet(jsObj, 'clientRevBy'),
      label: IsarNative.jsObjectGet(jsObj, 'label'),
      labelFields: (IsarNative.jsObjectGet(jsObj, 'labelFields') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>(),
      labelFieldsSeparator:
          IsarNative.jsObjectGet(jsObj, 'labelFieldsSeparator'),
      name: IsarNative.jsObjectGet(jsObj, 'name'),
      optionType: IsarNative.jsObjectGet(jsObj, 'optionType'),
      ord: IsarNative.jsObjectGet(jsObj, 'ord'),
      parentId: IsarNative.jsObjectGet(jsObj, 'parentId'),
      projectId: IsarNative.jsObjectGet(jsObj, 'projectId'),
      relType: IsarNative.jsObjectGet(jsObj, 'relType'),
      singleLabel: IsarNative.jsObjectGet(jsObj, 'singleLabel'),
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
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
      case 'isarId':
        return (IsarNative.jsObjectGet(jsObj, 'isarId')) as P;
      case 'label':
        return (IsarNative.jsObjectGet(jsObj, 'label')) as P;
      case 'labelFields':
        return ((IsarNative.jsObjectGet(jsObj, 'labelFields') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>()) as P;
      case 'labelFieldsSeparator':
        return (IsarNative.jsObjectGet(jsObj, 'labelFieldsSeparator')) as P;
      case 'name':
        return (IsarNative.jsObjectGet(jsObj, 'name')) as P;
      case 'optionType':
        return (IsarNative.jsObjectGet(jsObj, 'optionType')) as P;
      case 'ord':
        return (IsarNative.jsObjectGet(jsObj, 'ord')) as P;
      case 'parentId':
        return (IsarNative.jsObjectGet(jsObj, 'parentId')) as P;
      case 'projectId':
        return (IsarNative.jsObjectGet(jsObj, 'projectId')) as P;
      case 'relType':
        return (IsarNative.jsObjectGet(jsObj, 'relType')) as P;
      case 'serverRevAt':
        return (IsarNative.jsObjectGet(jsObj, 'serverRevAt') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'serverRevAt'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'singleLabel':
        return (IsarNative.jsObjectGet(jsObj, 'singleLabel')) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Ctable object) {}
}

class _CtableNativeAdapter extends IsarNativeTypeAdapter<Ctable> {
  const _CtableNativeAdapter();

  @override
  void serialize(IsarCollection<Ctable> collection, IsarRawObject rawObj,
      Ctable object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
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
    final value3 = object.id;
    final _id = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_id.length) as int;
    final value4 = object.label;
    IsarUint8List? _label;
    if (value4 != null) {
      _label = IsarBinaryWriter.utf8Encoder.convert(value4);
    }
    dynamicSize += (_label?.length ?? 0) as int;
    final value5 = object.labelFields;
    dynamicSize += (value5?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList5;
    if (value5 != null) {
      bytesList5 = [];
      for (var str in value5) {
        final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
        bytesList5.add(bytes);
        dynamicSize += bytes.length as int;
      }
    }
    final _labelFields = bytesList5;
    final value6 = object.labelFieldsSeparator;
    IsarUint8List? _labelFieldsSeparator;
    if (value6 != null) {
      _labelFieldsSeparator = IsarBinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += (_labelFieldsSeparator?.length ?? 0) as int;
    final value7 = object.name;
    IsarUint8List? _name;
    if (value7 != null) {
      _name = IsarBinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += (_name?.length ?? 0) as int;
    final value8 = object.optionType;
    IsarUint8List? _optionType;
    if (value8 != null) {
      _optionType = IsarBinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += (_optionType?.length ?? 0) as int;
    final value9 = object.ord;
    final _ord = value9;
    final value10 = object.parentId;
    IsarUint8List? _parentId;
    if (value10 != null) {
      _parentId = IsarBinaryWriter.utf8Encoder.convert(value10);
    }
    dynamicSize += (_parentId?.length ?? 0) as int;
    final value11 = object.projectId;
    IsarUint8List? _projectId;
    if (value11 != null) {
      _projectId = IsarBinaryWriter.utf8Encoder.convert(value11);
    }
    dynamicSize += (_projectId?.length ?? 0) as int;
    final value12 = object.relType;
    IsarUint8List? _relType;
    if (value12 != null) {
      _relType = IsarBinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += (_relType?.length ?? 0) as int;
    final value13 = object.serverRevAt;
    final _serverRevAt = value13;
    final value14 = object.singleLabel;
    IsarUint8List? _singleLabel;
    if (value14 != null) {
      _singleLabel = IsarBinaryWriter.utf8Encoder.convert(value14);
    }
    dynamicSize += (_singleLabel?.length ?? 0) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDateTime(offsets[0], _clientRevAt);
    writer.writeBytes(offsets[1], _clientRevBy);
    writer.writeBool(offsets[2], _deleted);
    writer.writeBytes(offsets[3], _id);
    writer.writeBytes(offsets[4], _label);
    writer.writeStringList(offsets[5], _labelFields);
    writer.writeBytes(offsets[6], _labelFieldsSeparator);
    writer.writeBytes(offsets[7], _name);
    writer.writeBytes(offsets[8], _optionType);
    writer.writeLong(offsets[9], _ord);
    writer.writeBytes(offsets[10], _parentId);
    writer.writeBytes(offsets[11], _projectId);
    writer.writeBytes(offsets[12], _relType);
    writer.writeDateTime(offsets[13], _serverRevAt);
    writer.writeBytes(offsets[14], _singleLabel);
  }

  @override
  Ctable deserialize(IsarCollection<Ctable> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Ctable(
      clientRevAt: reader.readDateTimeOrNull(offsets[0]),
      clientRevBy: reader.readStringOrNull(offsets[1]),
      label: reader.readStringOrNull(offsets[4]),
      labelFields: reader.readStringList(offsets[5]),
      labelFieldsSeparator: reader.readStringOrNull(offsets[6]),
      name: reader.readStringOrNull(offsets[7]),
      optionType: reader.readStringOrNull(offsets[8]),
      ord: reader.readLongOrNull(offsets[9]),
      parentId: reader.readStringOrNull(offsets[10]),
      projectId: reader.readStringOrNull(offsets[11]),
      relType: reader.readStringOrNull(offsets[12]),
      singleLabel: reader.readStringOrNull(offsets[14]),
    );
    object.deleted = reader.readBool(offsets[2]);
    object.id = reader.readString(offsets[3]);
    object.isarId = id;
    object.serverRevAt = reader.readDateTime(offsets[13]);
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
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readStringOrNull(offset)) as P;
      case 5:
        return (reader.readStringList(offset)) as P;
      case 6:
        return (reader.readStringOrNull(offset)) as P;
      case 7:
        return (reader.readStringOrNull(offset)) as P;
      case 8:
        return (reader.readStringOrNull(offset)) as P;
      case 9:
        return (reader.readLongOrNull(offset)) as P;
      case 10:
        return (reader.readStringOrNull(offset)) as P;
      case 11:
        return (reader.readStringOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readDateTime(offset)) as P;
      case 14:
        return (reader.readStringOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Ctable object) {}
}

extension CtableQueryWhereSort on QueryBuilder<Ctable, Ctable, QWhere> {
  QueryBuilder<Ctable, Ctable, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyDeleted() {
    return addWhereClauseInternal(const WhereClause(indexName: 'deleted'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'id'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyNameProjectId() {
    return addWhereClauseInternal(
        const WhereClause(indexName: 'name_projectId'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyOptionType() {
    return addWhereClauseInternal(const WhereClause(indexName: 'optionType'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyOrd() {
    return addWhereClauseInternal(const WhereClause(indexName: 'ord'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyProjectId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyServerRevAt() {
    return addWhereClauseInternal(const WhereClause(indexName: 'serverRevAt'));
  }
}

extension CtableQueryWhere on QueryBuilder<Ctable, Ctable, QWhereClause> {
  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdNotEqualTo(
      int? isarId) {
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdGreaterThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [isarId],
      includeLower: include,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdLessThan(
    int? isarId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [isarId],
      includeUpper: include,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'deleted',
      lower: [deleted],
      includeLower: true,
      upper: [deleted],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> deletedNotEqualTo(
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'name_projectId',
      lower: [name],
      includeLower: true,
      upper: [name],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameNotEqualTo(String? name) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        upper: [name],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        lower: [name],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        lower: [name],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        upper: [name],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameProjectIdEqualTo(
      String? name, String? projectId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'name_projectId',
      lower: [name, projectId],
      includeLower: true,
      upper: [name, projectId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameProjectIdNotEqualTo(
      String? name, String? projectId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        upper: [name, projectId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        lower: [name, projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        lower: [name, projectId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'name_projectId',
        upper: [name, projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeEqualTo(
      String? optionType) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'optionType',
      lower: [optionType],
      includeLower: true,
      upper: [optionType],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeNotEqualTo(
      String? optionType) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'optionType',
        upper: [optionType],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'optionType',
        lower: [optionType],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'optionType',
        lower: [optionType],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'optionType',
        upper: [optionType],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'optionType',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'optionType',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: true,
      upper: [ord],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordNotEqualTo(int? ord) {
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordGreaterThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: include,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordLessThan(
    int? ord, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: include,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'projectId',
      lower: [projectId],
      includeLower: true,
      upper: [projectId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdNotEqualTo(
      String? projectId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdIsNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClauseInternal(const WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtEqualTo(
      DateTime serverRevAt) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtNotEqualTo(
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

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtGreaterThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: include,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtLessThan(
    DateTime serverRevAt, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: include,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtBetween(
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
}

extension CtableQueryFilter on QueryBuilder<Ctable, Ctable, QFilterCondition> {
  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByEqualTo(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByStartsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByEndsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelEqualTo(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelStartsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelEndsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'labelFields',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'labelFields',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'labelFields',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'labelFields',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'labelFieldsSeparator',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'labelFieldsSeparator',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'labelFieldsSeparator',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'optionType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'optionType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'optionType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'parentId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'parentId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'projectId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'relType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'relType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'relType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtGreaterThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtLessThan(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtBetween(
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

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'singleLabel',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'singleLabel',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'singleLabel',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CtableQueryLinks on QueryBuilder<Ctable, Ctable, QFilterCondition> {}

extension CtableQueryWhereSortBy on QueryBuilder<Ctable, Ctable, QSortBy> {
  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabelFieldsSeparator() {
    return addSortByInternal('labelFieldsSeparator', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabelFieldsSeparatorDesc() {
    return addSortByInternal('labelFieldsSeparator', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOptionType() {
    return addSortByInternal('optionType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOptionTypeDesc() {
    return addSortByInternal('optionType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByParentId() {
    return addSortByInternal('parentId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByParentIdDesc() {
    return addSortByInternal('parentId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByRelType() {
    return addSortByInternal('relType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByRelTypeDesc() {
    return addSortByInternal('relType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortBySingleLabel() {
    return addSortByInternal('singleLabel', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortBySingleLabelDesc() {
    return addSortByInternal('singleLabel', Sort.desc);
  }
}

extension CtableQueryWhereSortThenBy
    on QueryBuilder<Ctable, Ctable, QSortThenBy> {
  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByClientRevAt() {
    return addSortByInternal('clientRevAt', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByClientRevAtDesc() {
    return addSortByInternal('clientRevAt', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByClientRevBy() {
    return addSortByInternal('clientRevBy', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByClientRevByDesc() {
    return addSortByInternal('clientRevBy', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabelFieldsSeparator() {
    return addSortByInternal('labelFieldsSeparator', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabelFieldsSeparatorDesc() {
    return addSortByInternal('labelFieldsSeparator', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOptionType() {
    return addSortByInternal('optionType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOptionTypeDesc() {
    return addSortByInternal('optionType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByParentId() {
    return addSortByInternal('parentId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByParentIdDesc() {
    return addSortByInternal('parentId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByRelType() {
    return addSortByInternal('relType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByRelTypeDesc() {
    return addSortByInternal('relType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenBySingleLabel() {
    return addSortByInternal('singleLabel', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenBySingleLabelDesc() {
    return addSortByInternal('singleLabel', Sort.desc);
  }
}

extension CtableQueryWhereDistinct on QueryBuilder<Ctable, Ctable, QDistinct> {
  QueryBuilder<Ctable, Ctable, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByLabelFieldsSeparator(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('labelFieldsSeparator',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByOptionType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByRelType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('relType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctBySingleLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('singleLabel', caseSensitive: caseSensitive);
  }
}

extension CtableQueryProperty on QueryBuilder<Ctable, Ctable, QQueryProperty> {
  QueryBuilder<Ctable, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyNameInternal('clientRevAt');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyNameInternal('clientRevBy');
  }

  QueryBuilder<Ctable, bool, QQueryOperations> deletedProperty() {
    return addPropertyNameInternal('deleted');
  }

  QueryBuilder<Ctable, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Ctable, int?, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> labelProperty() {
    return addPropertyNameInternal('label');
  }

  QueryBuilder<Ctable, List<String>?, QQueryOperations> labelFieldsProperty() {
    return addPropertyNameInternal('labelFields');
  }

  QueryBuilder<Ctable, String?, QQueryOperations>
      labelFieldsSeparatorProperty() {
    return addPropertyNameInternal('labelFieldsSeparator');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> optionTypeProperty() {
    return addPropertyNameInternal('optionType');
  }

  QueryBuilder<Ctable, int?, QQueryOperations> ordProperty() {
    return addPropertyNameInternal('ord');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> parentIdProperty() {
    return addPropertyNameInternal('parentId');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> projectIdProperty() {
    return addPropertyNameInternal('projectId');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> relTypeProperty() {
    return addPropertyNameInternal('relType');
  }

  QueryBuilder<Ctable, DateTime, QQueryOperations> serverRevAtProperty() {
    return addPropertyNameInternal('serverRevAt');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> singleLabelProperty() {
    return addPropertyNameInternal('singleLabel');
  }
}
