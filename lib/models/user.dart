import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';

part 'user.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

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

  /// this is the id of the account row
  String? accountId;

  /// authId receives the value from firebases user.uid
  /// It is a long lived firebase authentication session = refresh token
  /// https://firebase.google.com/docs/auth/admin/manage-sessions
  /// It is used to create short lived id tokens
  /// that authenticate calls to the backend during one hour
  String? authId;

  DateTime? clientRevAt;
  String? clientRevBy;

  @Index()
  late DateTime serverRevAt;

  @Index()
  late bool deleted;

  CUser({
    this.name,
    this.email,
    this.accountId,
    this.authId,
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
        'email': this.email,
        'account_id': this.accountId,
        'auth_id': this.authId,
        'client_rev_at': this.clientRevAt?.toIso8601String(),
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt.toIso8601String(),
        'deleted': this.deleted,
      };

  CUser.fromJson(Map p)
      : id = p['id'],
        name = p['name'],
        email = p['email'],
        accountId = p['account_id'],
        authId = p['auth_id'],
        clientRevAt = DateTime.tryParse(p['client_rev_at']),
        clientRevBy = p['client_rev_by'],
        serverRevAt = DateTime.parse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation = DbOperation(table: 'users').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.cUsers.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  String? getRoleForProject(String projectId) {
    final Isar isar = Get.find<Isar>();
    Project? project =
        isar.projects.filter().idEqualTo(projectId).findFirstSync();
    if (project?.accountId != null && project?.accountId == this.accountId) {
      return 'account_manager';
    }
    String? role = isar.projectUsers
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
    // 1. update other fields
    this.clientRevAt = DateTime.now();
    this.clientRevBy = _authController.userEmail ?? '';
    DbOperation dbOperation = DbOperation(table: 'users').setData(this.toMap());
    // 2. update isar and server
    await isar.writeTxn((_) async {
      await isar.cUsers.put(this);
      await isar.dbOperations.put(dbOperation);
    });
  }
}
