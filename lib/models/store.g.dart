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
  version: 1,
);

class _StoreAdapter extends IsarTypeAdapter<Store> {
  const _StoreAdapter();

  @override
  void serialize(IsarCollection<Store> collection, IsarRawObject rawObj,
      Store object, List<int> offsets, AdapterAlloc alloc) {
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

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = bufAsBytes(rawObj.buffer, size);
    final writer = BinaryWriter(buffer, 26);
    writer.writeBytes(offsets[0], _editingProject);
    writer.writeLong(offsets[1], _largeLayoutTreeColumnSize);
    writer.writeStringList(offsets[2], _url);
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
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension StoreQueryWhere on QueryBuilder<Store, Store, QWhereClause> {
  QueryBuilder<Store, Store, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idNotEqualTo(int? id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
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
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Store, Store, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
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
    return addWhereClauseInternal(WhereClause(
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
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'editingProject',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'editingProject',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> editingProjectMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'editingProject',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'largeLayoutTreeColumnSize',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition>
      largeLayoutTreeColumnSizeEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
      property: 'largeLayoutTreeColumnSize',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'url',
      value: null,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition.between(
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
    return addFilterConditionInternal(FilterCondition(
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
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'url',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Store, Store, QAfterFilterCondition> urlAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
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
    return addPropertyNameInternal('editingProject');
  }

  QueryBuilder<Store, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Store, int?, QQueryOperations>
      largeLayoutTreeColumnSizeProperty() {
    return addPropertyNameInternal('largeLayoutTreeColumnSize');
  }

  QueryBuilder<Store, List<String>?, QQueryOperations> urlProperty() {
    return addPropertyNameInternal('url');
  }
}
