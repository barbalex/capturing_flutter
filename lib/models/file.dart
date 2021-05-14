import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/models/fileOperation.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
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

  // need local_path
  // TODO: to enable worker to send to firebase
  // TODO: and to show thumbnail? https://pub.dev/packages/thumbnailer
  String? localPath;

  // need download url
  // TODO: to enable fetching when when syncing
  String? url;

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
    this.url,
    this.version,
    this.filename,
    this.localPath,
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
    depth = 1;
    version = 0;
    parentRev = null;
    rev = '1-${md5.convert(utf8.encode('')).toString()}';
    revisions = ['1-${md5.convert(utf8.encode('')).toString()}'];
  }

  // used to create data for pending operations
  Map<String, dynamic> toMapFromServer() => {
        'id': this.id,
        'row_id': this.rowId,
        'field_id': this.fieldId,
        'url': this.url,
        'version': this.version,
        'localPath': this.localPath,
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

  Map<String, dynamic> toMapForOperation() => {
        'isar_id': this.isarId,
        'file_id': this.id,
        'row_id': this.rowId,
        'field_id': this.fieldId,
        'url': this.url,
        'version': this.version,
        'filename': this.filename,
        'local_path': this.localPath,
        'client_rev_at': this.clientRevAt,
        'client_rev_by': this.clientRevBy,
        'server_rev_at': this.serverRevAt,
        'rev': this.rev,
        'parent_rev': this.parentRev,
        'revisions': toPgArray(this.revisions),
        'depth': this.depth,
        'deleted': this.deleted,
      };

  Map<String, dynamic> toMapForServer() => {
        // id is set on server
        'file_id': this.id,
        'row_id': this.rowId,
        'field_id': this.fieldId,
        'url': this.url,
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
        url = p['url'],
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

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.cfiles.put(this);
      DbOperation dbOperation =
          DbOperation(table: 'cfiles').setData(this.toMapForOperation());
      await isar.dbOperations.put(dbOperation);
      // create FileOperation to upload to firebase
      FileOperation fileOperation =
          FileOperation(localPath: this.localPath, fileId: this.id);
      await isar.fileOperations.put(fileOperation);
    });
    return;
  }

  Future<void> save() async {
    // only in use for:
    // a. deleting
    // b. setting url after uploading file
    // as files are not edited

    // 1 create map of own data
    Map data = this.toMapForServer();
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
      await isar.dbOperations
          .put(DbOperation(table: 'cfiles').setData(this.toMapForOperation()));
    });
    return;
  }
}
