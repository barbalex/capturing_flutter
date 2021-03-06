import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';

part 'widgetType.g.dart';

var uuid = Uuid();

@Collection()
class WidgetType {
  @Id()
  int? isarId; // auto increment id

  @Index()
  String? value;

  bool? needsList;

  @Index()
  int? sort;

  String? comment;

  @Index()
  late DateTime serverRevAt;

  @Index()
  late bool deleted;

  WidgetType({
    this.value,
    this.needsList,
    this.sort,
    this.comment,
  }) {
    deleted = false;
    serverRevAt = DateTime.parse('1970-01-01 01:00:00.000');
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'value': this.value,
        'needs_list': this.needsList,
        'sort': this.sort,
        'comment': this.comment,
        'server_rev_at': this.serverRevAt.toIso8601String(),
        'deleted': this.deleted,
      };

  WidgetType.fromJson(Map p)
      : value = p['value'],
        needsList = p['needs_list'],
        sort = p['sort'],
        comment = p['comment'],
        serverRevAt = DateTime.parse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'widgetType').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.widgetTypes.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    DbOperation operation =
        DbOperation(table: 'widgetType').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.widgetTypes.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }
}
