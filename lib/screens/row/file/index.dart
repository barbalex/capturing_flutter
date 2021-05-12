import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:capturing/screens/row/file/list.dart';

class FileWidget extends StatelessWidget {
  final Crow row;
  final Field field;

  FileWidget({
    required this.row,
    required this.field,
  });

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.cfiles
          .where()
          .filter()
          .rowIdEqualTo(row.id)
          .and()
          .fieldIdEqualTo(field.id)
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Cfile> files = snapshot.data;
            print('file. files: $files, length: ${files.length}');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 14.0,
                ),
                Text(
                  'Files',
                  style: TextStyle(
                    color: (Colors.grey.shade800),
                    fontSize: 13,
                  ),
                ),
                files.length == 0 ? FileListWidget(files: files) : Container(),
                TextButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);

                    if (result != null) {
                      result.files.forEach((file) {
                        print(
                            'FileWidget. file: $file, name: ${file.name}, path: ${file.path}');
                        Cfile cfile = Cfile(
                          rowId: row.id,
                          fieldId: field.id,
                          filename: file.name,
                        );
                        cfile.save();
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
        return CircularProgressIndicator();
      },
    );
  }
}
