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

  @Index()
  String? name;

  late String? serviceId;
  String? manager;

  String? clientRevAt;
  String? clientRevBy;

  String? serverRevAt;

  @Index()
  late bool deleted;

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
    deleted = false;
    serviceId = authController.user.value?.uid;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'manager': this.manager,
        'clientRevAt': this.clientRevAt,
        'clientRevBy': this.clientRevBy,
        'deleted': this.deleted,
      };
}
