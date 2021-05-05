import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class Account {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  late String? serviceId;

  String? managerId;
  IsarLink<CUser> manager = IsarLink<CUser>();

  String? clientRevAt;
  String? clientRevBy;

  String? serverRevAt;

  @Index()
  late bool deleted;

  @Backlink(to: 'projects')
  IsarLinks<Project> projects = IsarLinks<Project>();

  Account({
    this.isarId,
    this.managerId,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    deleted = false;
    serviceId = authController.user?.value?.uid;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'service_id': this.serviceId,
        'manager_id': this.managerId,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Account.fromJson(Map p)
      : id = p['id'],
        serviceId = p['service_id'],
        managerId = p['manager_id'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    Operation operation = Operation(table: 'accounts').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.accounts.put(this);
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.accounts.put(this);
      Operation operation = Operation(table: 'accounts').setData(this.toMap());
      await isar.operations.put(operation);
    });
    return;
  }
}
