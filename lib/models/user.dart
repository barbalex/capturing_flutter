import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/models/projectUser.dart';
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
  IsarLink<Account> account = IsarLink<Account>();

  String? authId;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  @Backlink(to: 'projectUsers')
  IsarLinks<ProjectUser> projectUsers = IsarLinks<ProjectUser>();

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
    Operation operation = Operation(table: 'users').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.cUsers.put(this);
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.cUsers.put(this);
      Operation operation = Operation(table: 'users').setData(this.toMap());
      await isar.operations.put(operation);
    });
    return;
  }
}
