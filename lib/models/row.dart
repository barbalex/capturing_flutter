import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

// the name "Table" is used by a flutter widget which is bad when isar.g.dart is built!!
@Collection()
class Row {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? tableId;

  String? geometry;

  String? data;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  String? rev;

  String? parentRev;

  List<String>? revisions = [];

  int? depth;

  List<String>? conflicts = [];

  Row({
    this.tableId,
    this.data,
    this.geometry,
    this.clientRevAt,
    this.clientRevBy,
    this.serverRevAt,
    this.rev,
    this.parentRev,
    this.revisions,
    this.depth,
    this.conflicts,
  }) {
    id = uuid.v1();
    deleted = false;
    clientRevAt = clientRevAt ?? DateTime.now().toIso8601String();
    clientRevBy = clientRevBy ?? authController.userEmail ?? '';
    depth = depth ?? 0;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'table_id': this.tableId,
        'data': this.data,
        'geometry': this.geometry,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'rev': this.rev,
        'parent_rev': this.parentRev,
        'revisions': this.revisions,
        'depth': this.depth,
        'deleted': this.deleted,
        'conflicts': this.conflicts,
      };

  Row.fromJson(Map p)
      : id = p['id'],
        tableId = p['table_id'],
        data = p['data'],
        geometry = p['geometry'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        rev = p['rev'],
        parentRev = p['parent_rev'],
        revisions = p['revisions'],
        depth = p['depth'],
        deleted = p['deleted'],
        conflicts = p['conflicts'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    Operation operation = Operation(table: 'tables').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.rows.put(this);
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.rows.put(this);
      Operation operation = Operation(table: 'tables').setData(this.toMap());
      await isar.operations.put(operation);
    });
    return;
  }
}
