import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/utils/toPgArray.dart';
import 'package:capturing/utils/pgArrayToListOfStrings.dart';

var uuid = Uuid();
final AuthController _authController = Get.find<AuthController>();

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

  String? singleLabel;

  @Index()
  int? ord;

  // defines labeling the rows and sorting them
  // is array of field labels
  // in label they are separated by ;
  // wanted to index this field but isar does not support indexint this type
  List<String>? labelFields;

  // ability to define separator
  String? labelFieldsSeparator;

  String? relType;

  @Index()
  String? optionType;

  @Index()
  String? projectId;

  String? parentId;

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
    this.singleLabel,
    this.ord,
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
    singleLabel = singleLabel ?? singleLabel ?? name ?? null;
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? _authController.userEmail ?? '';
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'project_id': this.projectId,
        'parent_id': this.parentId,
        'label': this.label,
        'single_label': this.singleLabel,
        'ord': this.ord,
        'label_fields': toPgArray(this.labelFields),
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
        'single_label': this.singleLabel,
        'ord': this.ord,
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
        singleLabel = p['single_label'],
        ord = p['ord'],
        //labelFields = p['label_fields']?.cast<String>(),
        // labelFields = p['label_fields'] == null
        //     ? null
        //     : List<String>.from(p['label_fields'].toList()),
        labelFields = pgArrayToListOfStrings(p['label_fields']),
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
    DbOperation dbOperation =
        DbOperation(table: 'tables').setData(this.toMap());
    await isar.writeTxn((isar) async {
      await isar.ctables.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  Future<void> save() async {
    final Isar isar = Get.find<Isar>();
    // 1. update other fields
    if (this.ord == null && this.projectId != null) {
      int? highestOrd = await isar.ctables
          .where()
          .projectIdEqualTo(this.projectId)
          .sortByOrdDesc()
          .ordProperty()
          .findFirst();
      this.ord = highestOrd != null ? highestOrd + 1 : 0;
    }
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = _authController.userEmail ?? '';
    DbOperation dbOperation =
        DbOperation(table: 'tables').setData(this.toMap());
    // 2. update isar and server
    await isar.writeTxn((isar) async {
      await isar.ctables.put(this);
      await isar.dbOperations.put(dbOperation);
    });
    return;
  }

  Future<void> saveData() async {
    await this.save();
    return;
  }

  String getLabel() {
    return this.label ?? this.name ?? '(no label)';
  }

  String getSingleLabel() {
    return this.singleLabel ?? this.label ?? this.name ?? '(no label)';
  }
}
