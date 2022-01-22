import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';

part 'projectUser.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

@Collection()
class ProjectUser {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? projectId;

  String? userEmail;

  String? role;

  DateTime? clientRevAt;
  String? clientRevBy;

  @Index()
  late DateTime serverRevAt;

  @Index()
  late bool deleted;

  ProjectUser({
    this.projectId,
    this.userEmail,
    this.role,
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
        'project_id': this.projectId,
        'user_email': this.userEmail,
        'role': this.role,
        'client_rev_at': this.clientRevAt?.toIso8601String(),
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt.toIso8601String(),
        'deleted': this.deleted,
      };

  ProjectUser.fromJson(Map p)
      : id = p['id'],
        projectId = p['project_id'],
        userEmail = p['user_email'],
        role = p['role'],
        clientRevAt = DateTime.tryParse(p['client_rev_at']),
        clientRevBy = p['client_rev_by'],
        serverRevAt = DateTime.parse(p['server_rev_at']),
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation dbOperation =
        DbOperation(table: 'projectUsers').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.projectUsers.put(this);
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
        DbOperation(table: 'projectUsers').setData(this.toMap());
    // 2. update isar and server
    await isar.writeTxn((isar) async {
      await isar.projectUsers.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }
}
