import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

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
  String? serverRevAt;

  @Index()
  late bool deleted;

  WidgetType({
    this.value,
    this.needsList,
    this.sort,
    this.comment,
    this.serverRevAt,
  }) {
    deleted = false;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'value': this.value,
        'needs_list': this.needsList,
        'sort': this.sort,
        'comment': this.comment,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  WidgetType.fromJson(Map p)
      : value = p['value'],
        needsList = p['needs_list'],
        sort = p['sort'],
        comment = p['comment'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'widgetType').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.widgetTypes.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.widgetTypes.put(this);
      DbOperation operation =
          DbOperation(table: 'widgetType').setData(this.toMap());
      await isar.dbOperations.put(operation);
    });
    return;
  }
}
