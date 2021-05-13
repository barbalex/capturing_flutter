import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class RelType {
  @Id()
  int? isarId; // auto increment id

  @Index()
  String? value;

  @Index()
  int? sort;

  String? comment;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  RelType({
    this.value,
    this.sort,
    this.comment,
    this.serverRevAt,
  }) {
    deleted = false;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'value': this.value,
        'sort': this.sort,
        'comment': this.comment,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  RelType.fromJson(Map p)
      : value = p['value'],
        sort = p['sort'],
        comment = p['comment'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation = DbOperation(table: 'relType').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.relTypes.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.relTypes.put(this);
      DbOperation operation =
          DbOperation(table: 'relType').setData(this.toMap());
      await isar.dbOperations.put(operation);
    });
    return;
  }
}
