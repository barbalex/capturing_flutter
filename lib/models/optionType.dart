import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';

var uuid = Uuid();
final AuthController authController = Get.find<AuthController>();

@Collection()
class OptionType {
  @Id()
  int? isarId; // auto increment id

  @Index()
  late String id;

  @Index()
  String? value;

  bool? saveId;

  @Index()
  int? sort;

  String? comment;

  @Index()
  String? serverRevAt;

  @Index()
  late bool deleted;

  OptionType({
    this.value,
    this.saveId,
    this.sort,
    this.comment,
    this.serverRevAt,
  }) {
    id = uuid.v1();
    saveId = saveId ?? false;
    deleted = false;
  }

  // used to create data for pending operations
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'value': this.value,
        'save_id': this.saveId,
        'sort': this.sort,
        'comment': this.comment,
        'server_rev_at': this.serverRevAt,
        'deleted': this.deleted,
      };

  OptionType.fromJson(Map p)
      : id = p['id'],
        value = p['value'],
        saveId = p['save_id'],
        sort = p['sort'],
        comment = p['comment'],
        serverRevAt = p['server_rev_at'],
        deleted = p['deleted'];

  Future<void> delete() async {
    final Isar isar = Get.find<Isar>();
    this.deleted = true;
    Operation operation = Operation(table: 'optionType').setData(this.toMap());
    isar.writeTxn((isar) async {
      await isar.optionTypes.put(this);
      await isar.operations.put(operation);
    });
    return;
  }

  Future<void> create() async {
    final Isar isar = Get.find<Isar>();
    await isar.writeTxn((isar) async {
      await isar.optionTypes.put(this);
      Operation operation =
          Operation(table: 'optionType').setData(this.toMap());
      await isar.operations.put(operation);
    });
    return;
  }
}
