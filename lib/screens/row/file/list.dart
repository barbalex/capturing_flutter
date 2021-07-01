import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';

class FileList extends StatefulWidget {
  final Crow row;
  final Field field;

  FileList({
    required this.row,
    required this.field,
  });

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
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
  void dispose() {
    cfilesListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Cfile> files = isar.cfiles
        .where()
        .filter()
        .rowIdEqualTo(widget.row.id)
        .and()
        .fieldIdEqualTo(widget.field.id)
        .and()
        .deletedEqualTo(false)
        .findAllSync();
    if (files.length == 0) return Container();

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        height: 1,
      ),
      itemBuilder: (context, index) {
        Cfile file = files[index];
        File realFile = File(file.localPath ?? '');

        return Dismissible(
          key: UniqueKey(),
          // Show a red background as the item is swiped away.
          background: Container(
            color: Theme.of(context).colorScheme.secondary,
            child: Center(
              child: Text(
                'deleting',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onDismissed: (direction) {
            file.delete();
            // Show a snackbar. This snackbar could also contain "Undo" actions.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${file.filename ?? ''} dismissed"),
              ),
            );
          },
          child: ListTile(
            title: Text(file.filename ?? ''),
            leading: file.localPath != null
                ? Thumbnail(
                    dataResolver: () async {
                      return (await realFile.readAsBytes())
                          .buffer
                          .asUint8List();
                    },
                    mimeType: lookupMimeType(file.localPath ?? '') ?? '',
                    widgetSize: 56,
                    decoration: WidgetDecoration(
                        //backgroundColor: Colors.blueAccent,
                        //iconColor: Colors.red,
                        ),
                  )
                : null,
            onTap: () {
              try {
                OpenFile.open(file.localPath);
              } catch (e) {
                print(e);
                Get.snackbar(
                  'Error opening file',
                  e.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        );
      },
      itemCount: files.length,
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
    );
  }
}
