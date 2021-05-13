import 'package:isar/isar.dart';

@Collection()
class FileOperation {
  @Id()
  int? id;

  @Index()
  DateTime? time;

  // needed to upload the file to firebase
  String? localPath;

  // needed to after uploading
  // add the url to the file row using a dbOperation
  String? fileId;

  FileOperation({
    this.localPath,
    this.fileId,
  }) {
    time = DateTime.now();
  }
}
