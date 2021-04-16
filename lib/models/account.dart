import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:capturing/models/project.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class Account {
  @Id()
  int? isarId; // auto increment id

  late String id;

  @Index(indexType: IndexType.words)
  String? name;

  late String? serviceId;
  String? manager;

  String? clientRevAt;
  String? clientRevBy;

  String? serverRevAt;

  @Backlink(to: 'projects')
  IsarLink<Project> project = IsarLink<Project>();

  Account({
    this.isarId,
    this.name,
    this.manager,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    serviceId = authController.user.value?.uid;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }
}
