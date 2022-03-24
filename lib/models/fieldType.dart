import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';

part 'fieldType.g.dart';

var uuid = Uuid();

@Collection()
class FieldType {
  @Id()
  int? isarId; // auto increment id

  @Index()
  String? value;

  @Index()
  int? sort;

  String? comment;

  @Index()
  late DateTime serverRevAt;

  @Index()
  late bool deleted;

  FieldType({
    this.value,
    this.sort,
    this.comment,
  }) {
    deleted = false;
    serverRevAt = DateTime.parse('1970-01-01 01:00:00.000');
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'value': this.value,
        'sort': this.sort,
        'comment': this.comment,
        'server_rev_at': this.serverRevAt.toIso8601String(),
        'deleted': this.deleted,
      };

  FieldType.fromJson(Map p)
      : value = p['value'],
        sort = p['sort'],
        comment = p['comment'],
        serverRevAt = DateTime.parse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'fieldType').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.fieldTypes.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    DbOperation dbOperation =
        DbOperation(table: 'fieldType').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.fieldTypes.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }
}
