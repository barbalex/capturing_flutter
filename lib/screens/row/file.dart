import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/file.dart';
import 'package:file_picker/file_picker.dart';

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
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    ever(errorText, (_) {
      setState(() {});
    });

    return FutureBuilder(
      future: isar.cfiles
          .where()
          .filter()
          .rowIdEqualTo(widget.row.id)
          .and()
          .fieldIdEqualTo(widget.field.id)
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

            return Text('file picker');
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
