import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';

part 'account.g.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

@Collection()
class Account {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  /// This was supposed to contain the user.uid from firebase
  /// But that makes no sense as we need to identify users (with their individual rights)
  /// using that uid. So: needs to be removed
  late String? serviceId;

  String? clientRevAt;
  String? clientRevBy;

  String? serverRevAt;

  @Index()
  late bool deleted;

  @Backlink(to: 'projects')
  Account({
    this.isarId,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    deleted = false;
    serviceId = _authController.user?.value?.uid;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? _authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'service_id': this.serviceId,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Account.fromJson(Map p)
      : id = p['id'],
        serviceId = p['service_id'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation =
        DbOperation(table: 'accounts').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.accounts.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    // 1. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = _authController.userEmail ?? '';
    DbOperation dbOperation =
        DbOperation(table: 'accounts').setData(this.toMap());
    // 2. update isar and server
    await isar.writeTxn((isar) async {
      await isar.accounts.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }
}
