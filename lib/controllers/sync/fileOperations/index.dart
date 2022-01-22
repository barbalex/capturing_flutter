import 'dart:io';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/fileOperation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileOperationsController {
  final Isar isar = Get.find<Isar>();
  final FirebaseStorage fbStorage = FirebaseStorage.instance;

  FileOperationsController();

  Future<void> run() async {
    List<FileOperation> operations =
        await isar.fileOperations.where().sortByTime().findAll();
    // clone list because need to delete items inside the loop
    [...operations].forEach((operation) async {
      // 1. upload to firebase
      Cfile? file;
      Crow? row;
      Ctable? table;
      Project? project;
      try {
        file = await isar.cfiles
            .filter()
            .idEqualTo(operation.fileId ?? '')
            .findFirst();
        row =
            await isar.crows.filter().idEqualTo(file?.rowId ?? '').findFirst();
        table = await isar.ctables
            .filter()
            .idEqualTo(row?.tableId ?? '')
            .findFirst();
        project = await isar.projects
            .filter()
            .idEqualTo(table?.projectId ?? '')
            .findFirst();
      } catch (e) {
        print(e);
        Get.snackbar(
          'Error saving file',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      String ref =
          '${project?.accountId ?? 'account'}/${project?.id ?? 'project'}/${row?.tableId ?? 'table'}/${row?.id ?? 'row'}/${file?.fieldId ?? 'field'}/${file?.filename ?? 'name'}';
      try {
        await fbStorage.ref(ref).putFile(File(file?.localPath ?? ''));
      } catch (e) {
        print(e);
        Get.snackbar(
          'Error saving file',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      String url = await fbStorage.ref(ref).getDownloadURL();

      // 2. create operation to update file url
      file?.url = url;
      file?.save();
    });
    return;
  }
}
