import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:capturing/models/account.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class Project {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String? id;

  @Index(unique: true)
  String? name;

  String? accountId;
  IsarLink<Account> account = IsarLink<Account>();

  String? label;

  int? srsId;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  Project({
    this.id,
    this.name,
    this.accountId,
    this.label,
    this.srsId,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = id ?? uuid.v1();
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }

  void updateFromServer(Project p) {
    this.name == p.name;
    this.accountId == p.accountId;
    this.label == p.label;
    this.srsId == p.srsId;
    this.clientRevAt == p.clientRevAt;
    this.clientRevBy == p.clientRevBy;
    this.serverRevAt == p.serverRevAt;
    this.deleted == p.deleted;
  }

  bool isEqual(Project p) {
    return this.name == p.name &&
        this.accountId == p.accountId &&
        this.label == p.label &&
        this.srsId == p.srsId &&
        this.clientRevAt == p.clientRevAt &&
        this.clientRevBy == p.clientRevBy &&
        this.serverRevAt == p.serverRevAt &&
        this.deleted == p.deleted;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'account_id': this.accountId,
        'label': this.label,
        'srs_id': this.srsId,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Project.fromJson(Map p)
      : id = p['id'],
        name = p['name'],
        accountId = p['account_id'],
        label = p['label'],
        srsId = p['srs_id'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];
}
