import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

@Collection()
class Project {
  @Id()
  int? isarId; // auto increment id

  late String id;

  @Index(indexType: IndexType.words)
  String? name;

  Project({
    this.isarId,
    this.name,
  }) {
    id = uuid.v1();
  }
}

// class Project {
//   final String accountId;
//   final String label;
//   final int srsId;
//   final String clientRevAt;
//   final String clientRevBy;
//   final String serverRevAt;

//   Project(this.id, this.accountId, this.name, this.label, this.srsId,
//       this.clientRevAt, this.clientRevBy, this.serverRevAt);
// }
