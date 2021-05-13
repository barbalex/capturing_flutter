import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';
import 'dart:convert';
import 'package:capturing/utils/toPgArray.dart';
import 'package:crypto/crypto.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

// the name "Table" is used by a flutter widget which is bad when isar.g.dart is built!!
@Collection()
class Cfile {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? rowId;

  @Index()
  String? fieldId;

  String? filename;

  // TODO: need local_path
  // TODO: to enable worker to send to firebase
  // TODO: and to show thumbnail?

  // TODO: need firebase url
  // TODO: to enable fetching when when syncing

  String? hash;

  int? version;

  String? clientRevAt;
  String? clientRevBy;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  String? rev;

  String? parentRev;

  List<String>? revisions;

  int? depth;

  List<String>? conflicts;

  Cfile({
    this.rowId,
    this.fieldId,
    this.hash,
    this.version,
    this.filename,
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
    clientRevAt = DateTime.now().toIso8601String();
    clientRevBy = authController.userEmail ?? '';
    depth = 0;
    version = 0;
    parentRev = null;
    rev = '0-${md5.convert(utf8.encode('')).toString()}';
    revisions = ['0-${md5.convert(utf8.encode('')).toString()}'];
  }

  // used to create data for pending operations
  Map<String, dynamic> toMapFromServer() => {
        'id': this.id,
        'row_id': this.rowId,
        'field_id': this.fieldId,
        'hash': this.hash,
        'version': this.version,
        'filename': this.filename,
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

  Map<String, dynamic> toMapForServer() => {
        // id is set on server
        'isar_id': this.isarId,
        'file_id': this.id,
        'row_id': this.rowId,
        'field_id': this.fieldId,
        'hash': this.hash,
        'version': this.version,
        'filename': this.filename,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'rev': this.rev,
        'parent_rev': this.parentRev,
        'revisions': toPgArray(this.revisions),
        'depth': this.depth,
        'deleted': this.deleted,
        // conflicts are set on server
      };

  Cfile.fromJson(Map p)
      : id = p['id'],
        rowId = p['row_id'],
        fieldId = p['field_id'],
        hash = p['hash'],
        version = p['version'],
        filename = p['filename'],
        clientRevAt = p['client_rev_at'],
        clientRevBy = p['client_rev_by'],
        serverRevAt = p['server_rev_at'],
        rev = p['rev'],
        parentRev = p['parent_rev'],
        revisions = p['revisions']?.cast<String>(),
        depth = p['depth'],
        deleted = p['deleted'],
        conflicts = p['conflicts']?.cast<String>();

  Future<void> delete() async {
    this.deleted = true;
    this.save();
    return;
  }

  Future<void> deleteFromIsar() async {
    final Isar isar = Get.find<Isar>();
    isar.writeTxn((isar) async {
      await isar.cfiles.delete(this.isarId ?? 0);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.cfiles.put(this);
      Operation operation =
          Operation(table: 'cfiles').setData(this.toMapForServer());
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> save() async {
    // 1 create map of own data
    Map data = this.toMapForServer();
    // need to remove isar_id, is only used app side
    data.remove('isar_id');
    // 2. update other fields
    this.clientRevAt = DateTime.now().toIso8601String();
    this.clientRevBy = authController.userEmail ?? '';
    int newDepth = (this.depth ?? 0) + 1;
    int newVersion = (this.version ?? 0) + 1;
    String newParentRev = this.rev ?? '';
    data['version'] = newVersion;
    data['deleted'] = this.deleted;
    data['depth'] = newDepth;
    data['parent_rev'] = newParentRev;
    String newHash = md5.convert(utf8.encode(data.toString())).toString();
    String newRev = '$newDepth-$newHash';
    this.version = newVersion;
    this.depth = newDepth;
    this.parentRev = newParentRev;
    this.rev = newRev;
    this.revisions = [...this.revisions ?? [], newRev];
    // 3. update isar and server
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((_) async {
      await isar.cfiles.put(this);
      await isar.operations
          .put(Operation(table: 'cfiles').setData(this.toMapForServer()));
    });
    return;
  }
}
