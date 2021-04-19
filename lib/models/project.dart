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
  late String id;

  @Index()
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
    this.isarId,
    this.name,
    this.accountId,
    this.label,
    this.srsId,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }
}
