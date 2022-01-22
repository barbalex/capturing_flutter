// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member

extension GetStoreCollection on Isar {
  IsarCollection<Store> get stores {
    return getCollection('Store');
  }
}

final StoreSchema = CollectionSchema(
  name: 'Store',
  schema:
      '{"name":"Store","properties":[{"name":"editingProject","type":"String"},{"name":"largeLayoutTreeColumnSize","type":"Long"},{"name":"url","type":"StringList"}],"indexes":[],"links":[]}',
  adapter: const _StoreAdapter(),
  idName: 'id',
  propertyIds: {'editingProject': 0, 'largeLayoutTreeColumnSize': 1, 'url': 2},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) => obj.id,
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 0,
);

class _StoreAdapter extends IsarTypeAdapter<Store> {
  const _StoreAdapter();

  @override
  int serialize(IsarCollection<Store> collection, IsarRawObject rawObj,
      Store object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.id ?? Isar.autoIncrement;
    var dynamicSize = 0;
    final value0 = object.editingProject;
    IsarUint8List? _editingProject;
    if (value0 != null) {
      _editingProject = BinaryWriter.utf8Encoder.convert(value0);
    }
    dynamicSize += _editingProject?.length ?? 0;
    final value1 = object.largeLayoutTreeColumnSize;
    final _largeLayoutTreeColumnSize = value1;
    final value2 = object.url;
    dynamicSize += (value2?.length ?? 0) * 8;
    List<IsarUint8List?>? bytesList2;
    if (value2 != null) {
      bytesList2 = [];
      for (var str in value2) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList2.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _url = bytesList2;
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
    writer.writeBytes(offsets[0], _editingProject);
    writer.writeLong(offsets[1], _largeLayoutTreeColumnSize);
    writer.writeStringList(offsets[2], _url);
    return bufferSize;
  }

  @override
  Store deserialize(IsarCollection<Store> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Store(
      editingProject: reader.readStringOrNull(offsets[0]),
      largeLayoutTreeColumnSize: reader.readLongOrNull(offsets[1]),
      url: reader.readStringList(offsets[2]),
    );
    object.id = id;
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
        return (reader.readLongOrNull(offset)) as P;
      case 2:
        return (reader.readStringList(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension StoreQueryWhereSort on QueryBuilder<Store, Store, QWhere> {
  QueryBuilder<Store, Store, QAfterWhere> anyId() {
    return addWhereClause(const WhereClause(indexName: null));
  }
}

extension StoreQueryWhere on QueryBuilder<Store, Store, QWhereClause> {
  QueryBuilder<Store, Store, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idNotEqualTo(int? id) {
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

  QueryBuilder<Store, Store, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClause(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idBetween(
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
}

extension StoreQueryFilter on QueryBuilder<Store, Store, QFilterCondition> {
  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'editingProject',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'editingProject',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'editingProject',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Store, Store, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'largeLayoutTreeColumnSize',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'largeLayoutTreeColumnSize',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'url',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.endsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyContains(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.contains,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.matches,
      property: 'url',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension StoreQueryWhereSortBy on QueryBuilder<Store, Store, QSortBy> {
  QueryBuilder<Store, Store, QAfterSortBy> sortByEditingProject() {
    return addSortByInternal('editingProject', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortByEditingProjectDesc() {
    return addSortByInternal('editingProject', Sort.desc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortByLargeLayoutTreeColumnSize() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy>
      sortByLargeLayoutTreeColumnSizeDesc() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.desc);
  }
}

extension StoreQueryWhereSortThenBy on QueryBuilder<Store, Store, QSortThenBy> {
  QueryBuilder<Store, Store, QAfterSortBy> thenByEditingProject() {
    return addSortByInternal('editingProject', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenByEditingProjectDesc() {
    return addSortByInternal('editingProject', Sort.desc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenByLargeLayoutTreeColumnSize() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy>
      thenByLargeLayoutTreeColumnSizeDesc() {
    return addSortByInternal('largeLayoutTreeColumnSize', Sort.desc);
  }
}

extension StoreQueryWhereDistinct on QueryBuilder<Store, Store, QDistinct> {
  QueryBuilder<Store, Store, QDistinct> distinctByEditingProject(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('editingProject',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Store, Store, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Store, Store, QDistinct> distinctByLargeLayoutTreeColumnSize() {
    return addDistinctByInternal('largeLayoutTreeColumnSize');
  }
}

extension StoreQueryProperty on QueryBuilder<Store, Store, QQueryProperty> {
  QueryBuilder<Store, String?, QQueryOperations> editingProjectProperty() {
    return addPropertyName('editingProject');
  }

  QueryBuilder<Store, int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Store, int?, QQueryOperations>
      largeLayoutTreeColumnSizeProperty() {
    return addPropertyName('largeLayoutTreeColumnSize');
  }

  QueryBuilder<Store, List<String>?, QQueryOperations> urlProperty() {
    return addPropertyName('url');
  }
}
