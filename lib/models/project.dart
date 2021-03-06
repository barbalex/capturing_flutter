import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';

part 'project.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

@Collection()
class Project {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  String? name;

  @Index()
  String? accountId;

  @Index()
  String? label;

  int? crs;

  DateTime? clientRevAt;
  String? clientRevBy;

  @Index()
  late DateTime serverRevAt;

  @Index()
  late bool deleted;

  Project({
    this.name,
    this.accountId,
    this.label,
    this.crs,
    this.clientRevAt,
    this.clientRevBy,
  }) {
    id = uuid.v1();
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now();
    clientRevBy = clientRevBy ?? _authController.userEmail ?? '';
    serverRevAt = DateTime.parse('1970-01-01 01:00:00.000');
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'account_id': this.accountId,
        'label': this.label,
        'crs': this.crs,
        'client_rev_at': this.clientRevAt?.toIso8601String(),
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt.toIso8601String(),
        'deleted': this.deleted,
      };

  Project.fromJson(Map p)
      : id = p['id'],
        name = p['name'],
        accountId = p['account_id'],
        label = p['label'],
        crs = p['crs'],
        clientRevAt = DateTime.tryParse(p['client_rev_at']),
        clientRevBy = p['client_rev_by'],
        serverRevAt = DateTime.parse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'projects').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.projects.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    DbOperation dbOperation =
        DbOperation(table: 'projects').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.projects.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    // 1. update other fields
    this.clientRevAt = DateTime.now();
    this.clientRevBy = _authController.userEmail ?? '';
    DbOperation dbOperation =
        DbOperation(table: 'projects').setData(this.toMap());
    // 2. update isar and server
    await isar.writeTxn((_) async {
      await isar.projects.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  Future<void> saveData() async {
    await this.save();
    return;
  }

  String getLabel() {
    return this.label ?? this.name ?? '(no name)'.tr;
  }
}
