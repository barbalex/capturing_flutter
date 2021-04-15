import 'package:isar/isar.dart';

@Collection()
class Project {
  @Id()
  int? id; // auto increment id

  String? serverId;

  @Index(indexType: IndexType.words)
  String? name;

  Project({
    this.id,
    this.serverId,
    this.name,
  });
}
