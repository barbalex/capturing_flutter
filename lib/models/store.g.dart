// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

extension GetStoreCollection on Isar {
  IsarCollection<Store> get stores {
    return getCollection('Store');
  }
}

final StoreSchema = CollectionSchema(
  name: 'Store',
  schema:
      '{"name":"Store","properties":[{"name":"url","type":"StringList"},{"name":"editingProject","type":"String"},{"name":"largeLayoutTreeColumnSize","type":"Long"}],"indexes":[],"links":[]}',
  adapter: const _StoreAdapter(),
  idName: 'id',
  propertyIds: {'url': 0, 'editingProject': 1, 'largeLayoutTreeColumnSize': 2},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) => obj.id,
  version: 0,
);

class _StoreAdapter extends IsarTypeAdapter<Store> {
  const _StoreAdapter();

  @override
  int serialize(IsarCollection<Store> collection, RawObject rawObj,
      Store object, List<int> offsets,
      [int? existingBufferSize]) {
    rawObj.id = object.id ?? Isar.minId;
    var dynamicSize = 0;
    final value0 = object.url;
    dynamicSize += (value0?.length ?? 0) * 8;
    List<Uint8List?>? bytesList0;
    if (value0 != null) {
      bytesList0 = [];
      for (var str in value0) {
        final bytes = BinaryWriter.utf8Encoder.convert(str);
        bytesList0.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _url = bytesList0;
    final value1 = object.editingProject;
    Uint8List? _editingProject;
    if (value1 != null) {
      _editingProject = BinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += _editingProject?.length ?? 0;
    final value2 = object.largeLayoutTreeColumnSize;
    final _largeLayoutTreeColumnSize = value2;
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
    writer.writeStringList(offsets[0], _url);
    writer.writeBytes(offsets[1], _editingProject);
    writer.writeLong(offsets[2], _largeLayoutTreeColumnSize);
    return bufferSize;
  }

  @override
  Store deserialize(IsarCollection<Store> collection, int id,
      BinaryReader reader, List<int> offsets) {
    final object = Store(
      url: reader.readStringList(offsets[0]),
      editingProject: reader.readStringOrNull(offsets[1]),
      largeLayoutTreeColumnSize: reader.readLongOrNull(offsets[2]),
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
        return (reader.readStringList(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readLongOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension StoreQueryWhereSort on QueryBuilder<Store, Store, QWhere> {
  QueryBuilder<Store, Store, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: '_id'));
  }
}

extension StoreQueryWhere on QueryBuilder<Store, Store, QWhereClause> {
  QueryBuilder<Store, Store, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idNotEqualTo(int? id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClause(WhereClause(
        indexName: '_id',
        upper: [id],
        includeUpper: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClause(WhereClause(
        indexName: '_id',
        lower: [id],
        includeLower: false,
      )).addWhereClause(WhereClause(
        indexName: '_id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idIsNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      upper: [null],
      includeUpper: true,
      lower: [null],
      includeLower: true,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idIsNotNull() {
    return addWhereClause(WhereClause(
      indexName: '_id',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension StoreQueryFilter on QueryBuilder<Store, Store, QFilterCondition> {
  QueryBuilder<Store, Store, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyAnyIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyEqualTo(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyGreaterThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'url',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyLessThan(
    String? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'url',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyBetween(
    String? lower,
    String? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'url',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyEndsWith(String value,
      {bool caseSensitive = true}) {
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
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return addFilterCondition(FilterCondition.between(
      property: 'editingProject',
      lower: lower,
      upper: upper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectStartsWith(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.startsWith,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectEndsWith(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.isNull,
      property: 'largeLayoutTreeColumnSize',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeEqualTo(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.eq,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeGreaterThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.gt,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeLessThan(
    int? value,
  ) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.lt,
      property: 'largeLayoutTreeColumnSize',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeBetween(
    int? lower,
    int? upper,
  ) {
    return addFilterCondition(FilterCondition.between(
      property: 'largeLayoutTreeColumnSize',
      lower: lower,
      upper: upper,
    ));
  }
}

extension StoreQueryWhereSortBy on QueryBuilder<Store, Store, QSortBy> {
  QueryBuilder<Store, Store, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortByEditingProject() {
    return addSortByInternal('editingProject', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> sortByEditingProjectDesc() {
    return addSortByInternal('editingProject', Sort.desc);
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
  QueryBuilder<Store, Store, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenByEditingProject() {
    return addSortByInternal('editingProject', Sort.asc);
  }

  QueryBuilder<Store, Store, QAfterSortBy> thenByEditingProjectDesc() {
    return addSortByInternal('editingProject', Sort.desc);
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
  QueryBuilder<Store, Store, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Store, Store, QDistinct> distinctByEditingProject(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('editingProject',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Store, Store, QDistinct> distinctByLargeLayoutTreeColumnSize() {
    return addDistinctByInternal('largeLayoutTreeColumnSize');
  }
}

extension StoreQueryProperty on QueryBuilder<Store, Store, QQueryProperty> {
  QueryBuilder<Store, int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<Store, List<String>?, QQueryOperations> urlProperty() {
    return addPropertyName('url');
  }

  QueryBuilder<Store, String?, QQueryOperations> editingProjectProperty() {
    return addPropertyName('editingProject');
  }

  QueryBuilder<Store, int?, QQueryOperations>
      largeLayoutTreeColumnSizeProperty() {
    return addPropertyName('largeLayoutTreeColumnSize');
  }
}
