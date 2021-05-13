import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:file_picker/file_picker.dart';
import 'package:capturing/screens/row/file/list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:capturing/isar.g.dart';
import 'package:isar/isar.dart';

class FileWidget extends StatelessWidget {
  final Crow row;
  final Field field;
  final FirebaseStorage fbStorage = FirebaseStorage.instance;
  final Isar isar = Get.find<Isar>();

  FileWidget({
    required this.row,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 14.0,
        ),
        Text(
          field.label ?? field.name ?? 'Files',
          style: TextStyle(
            color: (Colors.grey.shade800),
            fontSize: 13,
          ),
        ),
        FileListWidget(row: row, field: field),
        TextButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: true);

            if (result != null) {
              result.files.forEach((file) async {
                Ctable? table;
                Project? project;
                try {
                  table = await isar.ctables
                      .where()
                      .filter()
                      .idEqualTo(row.tableId ?? '')
                      .findFirst();
                  project = await isar.projects
                      .where()
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
                    '${project?.accountId ?? 'account'}/${project?.id ?? 'project'}/${row.tableId}/${row.id}/${field.id}/${file.name}';
                try {
                  await fbStorage.ref(ref).putFile(File(file.path ?? ''));
                } catch (e) {
                  print(e);
                  Get.snackbar(
                    'Error saving file',
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
                String downloadURL = await fbStorage.ref(ref).getDownloadURL();

                Cfile cfile = Cfile(
                  rowId: row.id,
                  fieldId: field.id,
                  filename: file.name,
                );
                try {
                  cfile.create();
                } catch (e) {
                  print(e);
                  Get.snackbar(
                    'Error saving file',
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
              });
            }
            // else: user canceled the picker
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.add),
              ),
              Text('add File'),
            ],
          ),
        )
      ],
    );
  }
}
