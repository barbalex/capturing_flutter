import 'package:isar/isar.dart';

@Collection()
class DbOperation {
  @Id()
  int? id;

  @Index()
  DateTime? time;

  // needed to upload the file to firebase
  String localPath;

  // needed to after uploading
  // add the url to the file row using a dbOperation
  String fileId;

  DbOperation({
    required this.localPath,
    required this.fileId,
  }) {
    time = DateTime.now();
  }
}
