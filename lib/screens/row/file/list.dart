import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';

class FileListWidget extends StatefulWidget {
  final Crow row;
  final Field field;

  FileListWidget({
    required this.row,
    required this.field,
  });

  @override
  _FileListWidgetState createState() => _FileListWidgetState();
}

class _FileListWidgetState extends State<FileListWidget> {
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
    return FutureBuilder(
      future: isar.cfiles
          .where()
          .filter()
          .rowIdEqualTo(widget.row.id)
          .and()
          .fieldIdEqualTo(widget.field.id)
          .and()
          .deletedEqualTo(false)
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
            if (files.length == 0) return Container();

            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                Cfile file = files[index];
                return Dismissible(
                  //key: Key(file.isarId.toString()),
                  key: UniqueKey(),
                  // Show a red background as the item is swiped away.
                  background: Container(
                    color: Theme.of(context).accentColor,
                    child: Center(
                      child: Text(
                        'dismissing',
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
                    onTap: () {
                      print('TODO: open file');
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
        return CircularProgressIndicator();
      },
    );
  }
}
