import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:capturing/screens/row/file/list.dart';

class FileWidget extends StatefulWidget {
  final Crow row;
  final Field field;

  FileWidget({
    required this.row,
    required this.field,
  });

  @override
  _FileWidgetState createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> cfilesListener;

  @override
  void initState() {
    super.initState();
    cfilesListener = isar.cfiles
        .where()
        .filter()
        .rowIdEqualTo(widget.row.id)
        .and()
        .fieldIdEqualTo(widget.field.id)
        .watchLazy()
        .listen((event) {
      setState(() {});
    });
  }

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
        FileListWidget(row: widget.row, field: widget.field),
        TextButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: true);

            if (result != null) {
              result.files.forEach((file) async {
                print(
                    'FileWidget. file: $file, name: ${file.name}, path: ${file.path}');
                Cfile cfile = Cfile(
                  rowId: widget.row.id,
                  fieldId: widget.field.id,
                  filename: file.name,
                );
                await cfile.save();
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
