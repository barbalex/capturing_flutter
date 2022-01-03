import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
// import 'package:get/get.dart';
// import 'package:capturing/models/dbOperation.dart';
// import 'package:capturing/isar.g.dart';

var uuid = Uuid();

@Collection()
class RoleType {
  @Id()
  int? isarId; // auto increment id

  @Index()
  String? value;

  @Index()
  int? sort;

  String? comment;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  RoleType({
    this.value,
    this.sort,
    this.comment,
    this.serverRevAt,
  }) {
    deleted = false;
  }

  // // used to create data for pending operations
  // Map<String, dynamic> toMap() => {
  //       'value': this.value,
  //       'sort': this.sort,
  //       'comment': this.comment,
  //       'server_rev_at': this.serverRevAt,
  //       'deleted': this.deleted,
  //     };

  // RoleType.fromJson(Map p)
  //     : value = p['value'],
  //       sort = p['sort'],
  //       comment = p['comment'],
  //       serverRevAt = p['server_rev_at'],
  //       deleted = p['deleted'];

  // Future<void> delete() async {
  //   final Isar isar = Get.find<Isar>();
  //   this.deleted = true;
  //   DbOperation dbOperation =
  //       DbOperation(table: 'roleType').setData(this.toMap());
  //   await isar.writeTxn((isar) async {
  //     await isar.roleTypes.put(this);
  //     await isar.dbOperations.put(dbOperation);
  //   });
  //   return;
  // }

  // Future<void> save() async {
  //   final Isar isar = Get.find<Isar>();
  //   DbOperation dbOperation =
  //       DbOperation(table: 'roleType').setData(this.toMap());
  //   await isar.writeTxn((isar) async {
  //     await isar.roleTypes.put(this);
  //     await isar.dbOperations.put(dbOperation);
  //   });
  //   return;
  // }
}
