import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
        FileListWidget(row: row, field: field),
        TextButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: true);

            if (result != null) {
              result.files.forEach((file) {
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
