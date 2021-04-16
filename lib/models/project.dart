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

  late String id;

  @Index(indexType: IndexType.words)
  String? name;

  String? accountId;
  IsarLink<Account> account = IsarLink<Account>();

  String? label;

  int? srsId;

  String? clientRevAt;
  String? clientRevBy;

  String? serverRevAt;

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
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }
}
