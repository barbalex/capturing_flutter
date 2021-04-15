import 'package:isar/isar.dart';

@Collection()
class Project {
  @Id()
  int? isarId; // auto increment id

  String? id;

  @Index(indexType: IndexType.words)
  String? name;

  Project({
    this.isarId,
    this.id,
    this.name,
  });
}
