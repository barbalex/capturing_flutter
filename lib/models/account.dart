import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:get/get.dart';

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
  late String clientRevAt;
  late String clientRevBy;
  String? serverRevAt;

  Account({
    this.isarId,
    this.name,
    this.manager,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    serviceId = authController.user.value?.uid;
    clientRevAt = DateTime.now().toIso8601String();
    clientRevBy = authController.userEmail ?? '';
  }
}
