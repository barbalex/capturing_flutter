import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class Table {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index(
    composite: [CompositeIndex('projectId')],
    unique: true,
  )
  String? name;

  String? label;

  String? relType;

  @Index()
  bool? isOptions;

  String? projectId;
  IsarLink<Project> project = IsarLink<Project>();

  String? parentId;
  IsarLink<Table> table = IsarLink<Table>();

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  Table({
    this.name,
    // wanted to make projectId required
    // but isar build fails: "Class needs to have a public zero-arg constructor"
    this.projectId,
    this.parentId,
    this.label,
    this.relType,
    this.isOptions,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    relType = relType ?? 'n';
    isOptions = isOptions ?? false;
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'project_id': this.projectId,
        'parent_id': this.parentId,
        'label': this.label,
        'rel_type': this.relType,
        'is_options': this.isOptions,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Table.fromJson(Map p)
      : id = p['id'],
        name = p['name'],
        projectId = p['project_id'],
        parentId = p['parent_id'],
        label = p['label'],
        relType = p['rel_type'],
        isOptions = p['is_options'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    Operation operation = Operation(table: 'tables').setData(this.toMap());
    // isar.writeTxn((isar) async {
    //   await isar.tables.put(this);
    //   await isar.operations.put(operation);
    // });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    // await isar.writeTxn((isar) async {
    //   await isar.tables.put(this);
    //   Operation operation = Operation(table: 'tables').setData(this.toMap());
    //   await isar.operations.put(operation);
    // });
    return;
  }
}
