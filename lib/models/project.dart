import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:get/get.dart';

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
  String? label;
  int? srsId;
  late String clientRevAt;
  late String clientRevBy;
  String? serverRevAt;

  Project(
      {this.isarId,
      this.name,
      this.accountId,
      this.label,
      this.srsId,
      this.serverRevAt}) {
    id = uuid.v1();
    clientRevAt = DateTime.now().toIso8601String();
    clientRevBy = authController.userEmail ?? '';
  }
}

// class Project {

//   Project(this.id, this.accountId, this.name, this.label, this.srsId,
//       this.clientRevAt, this.clientRevBy, this.serverRevAt);
// }
