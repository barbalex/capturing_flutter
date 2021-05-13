import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/utils/toPgArray.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

// the name "Table" is used by a flutter widget which is bad when isar.g.dart is built!!
@Collection()
class Ctable {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index(
    composite: [CompositeIndex('projectId')],
    //unique: true,
  )
  String? name;

  String? label;

  // TODO:
  // need labelFields property
  // defines labeling the rows and sorting them
  // is array of field labels
  // in label they are separated by ;
  // need ability to define separator?

  List<String>? labelFields;

  String? labelFieldsSeparator;

  String? relType;

  @Index()
  String? optionType;

  @Index()
  String? projectId;
  IsarLink<Project> project = IsarLink<Project>();

  String? parentId;
  IsarLink<Ctable> parent = IsarLink<Ctable>();

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  Ctable({
    this.name,
    // wanted to make projectId required
    // but isar build fails: "Class needs to have a public zero-arg constructor"
    this.projectId,
    this.parentId,
    this.label,
    this.labelFields,
    this.labelFieldsSeparator,
    this.relType,
    this.optionType,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    relType = relType ?? 'n';
    labelFieldsSeparator = labelFieldsSeparator ?? ', ';
    label = label ?? name ?? null;
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
        'label_fields': this.labelFields,
        'label_fields_separator': this.labelFieldsSeparator,
        'rel_type': this.relType,
        'option_type': this.optionType,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Map<String, dynamic> toMapFromModel() => {
        'id': this.id,
        'name': this.name,
        'project_id': this.projectId,
        'parent_id': this.parentId,
        'label': this.label,
        'label_fields': toPgArray(this.labelFields),
        'label_fields_separator': this.labelFieldsSeparator,
        'rel_type': this.relType,
        'option_type': this.optionType,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  Ctable.fromJson(Map p)
      : id = p['id'],
        name = p['name'],
        projectId = p['project_id'],
        parentId = p['parent_id'],
        label = p['label'],
        labelFields = p['label_fields']?.cast<String>(),
        labelFieldsSeparator = p['label_fields_separator'],
        relType = p['rel_type'],
        optionType = p['option_type'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    DbOperation operation = DbOperation(table: 'tables').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.ctables.put(this);
      await isar.dbOperations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.ctables.put(this);
      DbOperation operation =
          DbOperation(table: 'tables').setData(this.toMap());
      await isar.dbOperations.put(operation);
    });
    return;
  }
}
