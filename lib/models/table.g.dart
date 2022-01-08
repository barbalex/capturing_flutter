// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetCtableCollection on Isar {
  IsarCollection<Ctable> get ctables {
    return getCollection('Ctable');
  }
}

final CtableSchema = CollectionSchema(
  name: 'Ctable',
  schema:
      '{"name":"Ctable","properties":[{"name":"id","type":"String"},{"name":"name","type":"String"},{"name":"label","type":"String"},{"name":"singleLabel","type":"String"},{"name":"ord","type":"Long"},{"name":"labelFields","type":"StringList"},{"name":"labelFieldsSeparator","type":"String"},{"name":"relType","type":"String"},{"name":"optionType","type":"String"},{"name":"projectId","type":"String"},{"name":"parentId","type":"String"},{"name":"clientRevAt","type":"Long"},{"name":"clientRevBy","type":"String"},{"name":"serverRevAt","type":"Long"},{"name":"deleted","type":"Byte"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]},{"name":"name_projectId","unique":false,"properties":[{"name":"name","type":"Hash","caseSensitive":true},{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"ord","unique":false,"properties":[{"name":"ord","type":"Value","caseSensitive":false}]},{"name":"optionType","unique":false,"properties":[{"name":"optionType","type":"Hash","caseSensitive":true}]},{"name":"projectId","unique":false,"properties":[{"name":"projectId","type":"Hash","caseSensitive":true}]},{"name":"serverRevAt","unique":false,"properties":[{"name":"serverRevAt","type":"Value","caseSensitive":false}]},{"name":"deleted","unique":false,"properties":[{"name":"deleted","type":"Value","caseSensitive":false}]}],"links":[]}',
  adapter: const _CtableAdapter(),
  idName: 'isarId',
  propertyIds: {
    'id': 0,
    'name': 1,
    'label': 2,
    'singleLabel': 3,
    'ord': 4,
    'labelFields': 5,
    'labelFieldsSeparator': 6,
    'relType': 7,
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
    'ord': 2,
    'optionType': 3,
    'projectId': 4,
    'serverRevAt': 5,
    'deleted': 6
  },
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ],
    'name': [
      NativeIndexType.stringHash,
      NativeIndexType.stringHash,
    ],
    'ord': [
      NativeIndexType.long,
    ],
    'optionType': [
      NativeIndexType.stringHash,
    ],
    'projectId': [
      NativeIndexType.stringHash,
    ],
    'serverRevAt': [
      NativeIndexType.long,
    ],
    'deleted': [
      NativeIndexType.bool,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) => obj.isarId,
  version: 0,
);

class _CtableAdapter extends IsarTypeAdapter<Ctable> {
  const _CtableAdapter();

  @override
  int serialize(IsarCollection<Ctable> collection, RawObject rawObj,
      Ctable object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.isarId ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = BinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += _id.length;
    final value1 = object.name;
    Uint8List? _name;
    if (value1 != null) {
      _name = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _name?.length ?? 0;
    final value2 = object.label;
    Uint8List? _label;
    if (value2 != null) {
      _label = BinaryWriter.utf8Encoder.convert(value2);
    }
    dynamicSize += _label?.length ?? 0;
    final value3 = object.singleLabel;
    Uint8List? _singleLabel;
    if (value3 != null) {
      _singleLabel = BinaryWriter.utf8Encoder.convert(value3);
    }
    dynamicSize += _singleLabel?.length ?? 0;
    final value4 = object.ord;
    final _ord = value4;
    final value5 = object.labelFields;
    dynamicSize += (value5?.length ?? 0) * 8;
    List<Uint8List?>? bytesList5;
    if (value5 != null) {
      bytesList5 = [];
      for (var str in value5) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList5.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _labelFields = bytesList5;
    final value6 = object.labelFieldsSeparator;
    Uint8List? _labelFieldsSeparator;
    if (value6 != null) {
      _labelFieldsSeparator = BinaryWriter.utf8Encoder.convert(value6);
    }
    dynamicSize += _labelFieldsSeparator?.length ?? 0;
    final value7 = object.relType;
    Uint8List? _relType;
    if (value7 != null) {
      _relType = BinaryWriter.utf8Encoder.convert(value7);
    }
    dynamicSize += _relType?.length ?? 0;
    final value8 = object.optionType;
    Uint8List? _optionType;
    if (value8 != null) {
      _optionType = BinaryWriter.utf8Encoder.convert(value8);
    }
    dynamicSize += _optionType?.length ?? 0;
    final value9 = object.projectId;
    Uint8List? _projectId;
    if (value9 != null) {
      _projectId = BinaryWriter.utf8Encoder.convert(value9);
    }
    dynamicSize += _projectId?.length ?? 0;
    final value10 = object.parentId;
    Uint8List? _parentId;
    if (value10 != null) {
      _parentId = BinaryWriter.utf8Encoder.convert(value10);
    }
    dynamicSize += _parentId?.length ?? 0;
    final value11 = object.clientRevAt;
    final _clientRevAt = value11;
    final value12 = object.clientRevBy;
    Uint8List? _clientRevBy;
    if (value12 != null) {
      _clientRevBy = BinaryWriter.utf8Encoder.convert(value12);
    }
    dynamicSize += _clientRevBy?.length ?? 0;
    final value13 = object.serverRevAt;
    final _serverRevAt = value13;
    final value14 = object.deleted;
    final _deleted = value14;
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
    writer.writeBytes(offsets[0], _id);
    writer.writeBytes(offsets[1], _name);
    writer.writeBytes(offsets[2], _label);
    writer.writeBytes(offsets[3], _singleLabel);
    writer.writeLong(offsets[4], _ord);
    writer.writeStringList(offsets[5], _labelFields);
    writer.writeBytes(offsets[6], _labelFieldsSeparator);
    writer.writeBytes(offsets[7], _relType);
    writer.writeBytes(offsets[8], _optionType);
    writer.writeBytes(offsets[9], _projectId);
    writer.writeBytes(offsets[10], _parentId);
    writer.writeDateTime(offsets[11], _clientRevAt);
    writer.writeBytes(offsets[12], _clientRevBy);
    writer.writeDateTime(offsets[13], _serverRevAt);
    writer.writeBool(offsets[14], _deleted);
    return bufferSize;
  }

  @override
  Ctable deserialize(IsarCollection<Ctable> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Ctable(
      name: reader.readStringOrNull(offsets[1]),
      label: reader.readStringOrNull(offsets[2]),
      singleLabel: reader.readStringOrNull(offsets[3]),
      ord: reader.readLongOrNull(offsets[4]),
      labelFields: reader.readStringList(offsets[5]),
      labelFieldsSeparator: reader.readStringOrNull(offsets[6]),
      relType: reader.readStringOrNull(offsets[7]),
      optionType: reader.readStringOrNull(offsets[8]),
      projectId: reader.readStringOrNull(offsets[9]),
      parentId: reader.readStringOrNull(offsets[10]),
      clientRevAt: reader.readDateTimeOrNull(offsets[11]),
      clientRevBy: reader.readStringOrNull(offsets[12]),
      serverRevAt: reader.readDateTimeOrNull(offsets[13]),
    );
    object.isarId = id;
    object.id = reader.readString(offsets[0]);
    object.deleted = reader.readBool(offsets[14]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readStringOrNull(offset)) as P;
      case 3:
        return (reader.readStringOrNull(offset)) as P;
      case 4:
        return (reader.readLongOrNull(offset)) as P;
      case 5:
        return (reader.readStringList(offset)) as P;
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
        return (reader.readDateTimeOrNull(offset)) as P;
      case 12:
        return (reader.readStringOrNull(offset)) as P;
      case 13:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 14:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension CtableQueryWhereSort on QueryBuilder<Ctable, Ctable, QWhere> {
  QueryBuilder<Ctable, Ctable, QAfterWhere> anyIsarId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyNameProjectId() {
    return addWhereClause(WhereClause(indexName: 'name_projectId'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyOrd() {
    return addWhereClause(WhereClause(indexName: 'ord'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyOptionType() {
    return addWhereClause(WhereClause(indexName: 'optionType'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyProjectId() {
    return addWhereClause(WhereClause(indexName: 'projectId'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyServerRevAt() {
    return addWhereClause(WhereClause(indexName: 'serverRevAt'));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhere> anyDeleted() {
    return addWhereClause(WhereClause(indexName: 'deleted'));
  }
}

extension CtableQueryWhere on QueryBuilder<Ctable, Ctable, QWhereClause> {
  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdEqualTo(int? isarId) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [isarId],
      includeLower: true,
      upper: [isarId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdNotEqualTo(
      int? isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: '_id',
        upper: [isarId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        lower: [isarId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: '_id',
        lower: [isarId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        upper: [isarId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> isarIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClause(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> idNotEqualTo(String id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameEqualTo(String? name) {
    return addWhereClause(WhereClause(
      indexName: 'name_projectId',
      lower: [name],
      includeLower: true,
      upper: [name],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameNotEqualTo(String? name) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'name_projectId',
        upper: [name],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_projectId',
        lower: [name],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'name_projectId',
        lower: [name],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_projectId',
        upper: [name],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> nameProjectIdEqualTo(
      String? name, String? projectId) {
    return addWhereClause(WhereClause(
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
      return addWhereClause(WhereClause(
        indexName: 'name_projectId',
        upper: [name, projectId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_projectId',
        lower: [name, projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'name_projectId',
        lower: [name, projectId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'name_projectId',
        upper: [name, projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordEqualTo(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: true,
      upper: [ord],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordNotEqualTo(int? ord) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'ord',
        lower: [ord],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'ord',
        upper: [ord],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordGreaterThan(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [ord],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordLessThan(int? ord) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      upper: [ord],
      includeUpper: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> ordBetween(
      int? lowerOrd, int? upperOrd) {
    return addWhereClause(WhereClause(
      indexName: 'ord',
      lower: [lowerOrd],
      includeLower: true,
      upper: [upperOrd],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeEqualTo(
      String? optionType) {
    return addWhereClause(WhereClause(
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
      return addWhereClause(WhereClause(
        indexName: 'optionType',
        upper: [optionType],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'optionType',
        lower: [optionType],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'optionType',
        lower: [optionType],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'optionType',
        upper: [optionType],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> optionTypeIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'optionType',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdEqualTo(
      String? projectId) {
    return addWhereClause(WhereClause(
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
      return addWhereClause(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'projectId',
        lower: [projectId],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'projectId',
        upper: [projectId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> projectIdIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'projectId',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtEqualTo(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: true,
      upper: [serverRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtNotEqualTo(
      DateTime? serverRevAt) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        lower: [serverRevAt],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'serverRevAt',
        upper: [serverRevAt],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtIsNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [null],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtGreaterThan(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [serverRevAt],
      includeLower: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtLessThan(
      DateTime? serverRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      upper: [serverRevAt],
      includeUpper: false,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> serverRevAtBetween(
      DateTime? lowerServerRevAt, DateTime? upperServerRevAt) {
    return addWhereClause(WhereClause(
      indexName: 'serverRevAt',
      lower: [lowerServerRevAt],
      includeLower: true,
      upper: [upperServerRevAt],
      includeUpper: true,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterWhereClause> deletedEqualTo(bool deleted) {
    return addWhereClause(WhereClause(
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
      return addWhereClause(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: 'deleted',
        lower: [deleted],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: 'deleted',
        upper: [deleted],
        includeUpper: false,
      ));
    }
  }
}

extension CtableQueryFilter on QueryBuilder<Ctable, Ctable, QFilterCondition> {
  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'isarId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> isarIdBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idStartsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'name',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameEndsWith(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'label',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'label',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'label',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'label',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'singleLabel',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'singleLabel',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'singleLabel',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> singleLabelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'singleLabel',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'ord',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'ord',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> ordBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'ord',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'labelFields',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'labelFields',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'labelFields',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'labelFields',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'labelFields',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'labelFields',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'labelFields',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> labelFieldsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'labelFields',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorIsNull() {
    return addFilterCondition(FilterCondition(
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
    return addFilterCondition(FilterCondition(
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
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
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'labelFieldsSeparator',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorStartsWith(String value,
          {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorEndsWith(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorContains(String value, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'labelFieldsSeparator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition>
      labelFieldsSeparatorMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'labelFieldsSeparator',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'relType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'relType',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'relType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> relTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'relType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'optionType',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'optionType',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'optionType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> optionTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'optionType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'projectId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'projectId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'projectId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> projectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'projectId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentId',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'parentId',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'parentId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> parentIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'parentId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevAt',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtEqualTo(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtGreaterThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtLessThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'clientRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevAt',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'clientRevBy',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'clientRevBy',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByEndsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'clientRevBy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> clientRevByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'clientRevBy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'serverRevAt',
      value: null,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtEqualTo(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtGreaterThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtLessThan(
    DateTime? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'serverRevAt',
      value: value,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> serverRevAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'serverRevAt',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Ctable, Ctable, QAfterFilterCondition> deletedEqualTo(
    bool value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }
}

extension CtableQueryWhereSortBy on QueryBuilder<Ctable, Ctable, QSortBy> {
  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortBySingleLabel() {
    return addSortByInternal('singleLabel', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortBySingleLabelDesc() {
    return addSortByInternal('singleLabel', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabelFieldsSeparator() {
    return addSortByInternal('labelFieldsSeparator', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByLabelFieldsSeparatorDesc() {
    return addSortByInternal('labelFieldsSeparator', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByRelType() {
    return addSortByInternal('relType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByRelTypeDesc() {
    return addSortByInternal('relType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOptionType() {
    return addSortByInternal('optionType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByOptionTypeDesc() {
    return addSortByInternal('optionType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByParentId() {
    return addSortByInternal('parentId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByParentIdDesc() {
    return addSortByInternal('parentId', Sort.desc);
  }

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

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension CtableQueryWhereSortThenBy
    on QueryBuilder<Ctable, Ctable, QSortThenBy> {
  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabel() {
    return addSortByInternal('label', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabelDesc() {
    return addSortByInternal('label', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenBySingleLabel() {
    return addSortByInternal('singleLabel', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenBySingleLabelDesc() {
    return addSortByInternal('singleLabel', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOrd() {
    return addSortByInternal('ord', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOrdDesc() {
    return addSortByInternal('ord', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabelFieldsSeparator() {
    return addSortByInternal('labelFieldsSeparator', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByLabelFieldsSeparatorDesc() {
    return addSortByInternal('labelFieldsSeparator', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByRelType() {
    return addSortByInternal('relType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByRelTypeDesc() {
    return addSortByInternal('relType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOptionType() {
    return addSortByInternal('optionType', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByOptionTypeDesc() {
    return addSortByInternal('optionType', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByProjectId() {
    return addSortByInternal('projectId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByProjectIdDesc() {
    return addSortByInternal('projectId', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByParentId() {
    return addSortByInternal('parentId', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByParentIdDesc() {
    return addSortByInternal('parentId', Sort.desc);
  }

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

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByServerRevAt() {
    return addSortByInternal('serverRevAt', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByServerRevAtDesc() {
    return addSortByInternal('serverRevAt', Sort.desc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Ctable, Ctable, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }
}

extension CtableQueryWhereDistinct on QueryBuilder<Ctable, Ctable, QDistinct> {
  QueryBuilder<Ctable, Ctable, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('label', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctBySingleLabel(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('singleLabel', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByOrd() {
    return addDistinctByInternal('ord');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByLabelFieldsSeparator(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('labelFieldsSeparator',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByRelType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('relType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByOptionType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('optionType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('projectId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByParentId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByClientRevAt() {
    return addDistinctByInternal('clientRevAt');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByClientRevBy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('clientRevBy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByServerRevAt() {
    return addDistinctByInternal('serverRevAt');
  }

  QueryBuilder<Ctable, Ctable, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }
}

extension CtableQueryProperty on QueryBuilder<Ctable, Ctable, QQueryProperty> {
  QueryBuilder<Ctable, int?, QQueryOperations> isarIdProperty() {
    return addPropertyName('isarId');
  }

  QueryBuilder<Ctable, String, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> labelProperty() {
    return addPropertyName('label');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> singleLabelProperty() {
    return addPropertyName('singleLabel');
  }

  QueryBuilder<Ctable, int?, QQueryOperations> ordProperty() {
    return addPropertyName('ord');
  }

  QueryBuilder<Ctable, List<String>?, QQueryOperations> labelFieldsProperty() {
    return addPropertyName('labelFields');
  }

  QueryBuilder<Ctable, String?, QQueryOperations>
      labelFieldsSeparatorProperty() {
    return addPropertyName('labelFieldsSeparator');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> relTypeProperty() {
    return addPropertyName('relType');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> optionTypeProperty() {
    return addPropertyName('optionType');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> projectIdProperty() {
    return addPropertyName('projectId');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> parentIdProperty() {
    return addPropertyName('parentId');
  }

  QueryBuilder<Ctable, DateTime?, QQueryOperations> clientRevAtProperty() {
    return addPropertyName('clientRevAt');
  }

  QueryBuilder<Ctable, String?, QQueryOperations> clientRevByProperty() {
    return addPropertyName('clientRevBy');
  }

  QueryBuilder<Ctable, DateTime?, QQueryOperations> serverRevAtProperty() {
    return addPropertyName('serverRevAt');
  }

  QueryBuilder<Ctable, bool, QQueryOperations> deletedProperty() {
    return addPropertyName('deleted');
  }
}
