import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class CUser {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index(unique: true)
  String? name;

  @Index(unique: true)
  String? email;

  String? accountId;

  String? authId;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  CUser({
    this.name,
    this.email,
    this.accountId,
    this.authId,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'email': this.email,
        'account_id': this.accountId,
        'auth_id': this.authId,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  CUser.fromJson(Map p)
      : id = p['id'],
        name = p['name'],
        email = p['email'],
        accountId = p['account_id'],
        authId = p['auth_id'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation = DbOperation(table: 'users').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.cUsers.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.cUsers.put(this);
      DbOperation operation = DbOperation(table: 'users').setData(this.toMap());
      await isar.dbOperations.put(operation);
    });
    return;
  }

  String? getRoleForProject(String projectId) {
    final Isar isar = Get.find<Isar>();
    Project? project =
        isar.projects.where().filter().idEqualTo(projectId).findFirstSync();
    if (project?.accountId != null && project?.accountId == this.accountId) {
      return 'account_manager';
    }
    String? role = isar.projectUsers
        .where()
        .filter()
        .projectIdEqualTo(projectId)
        .and()
        .userEmailEqualTo(this.email)
        .roleProperty()
        .findFirstSync();
    return role;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    // 2. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = authController.userEmail ?? '';
    Map operationData = this.toMap();
    DbOperation newDbOperation =
        DbOperation(table: 'users').setData(operationData);
    // 3. update isar and server
    await isar.writeTxn((_) async {
      await isar.cUsers.put(this);
      await isar.dbOperations.put(newDbOperation);
    });
  }
}
