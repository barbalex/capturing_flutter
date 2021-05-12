import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/file.dart';

class FileListWidget extends StatelessWidget {
  final List<Cfile> files;

  FileListWidget({
    required this.files,
  });
  final Isar isar = Get.find<Isar>();
  final RxString errorText = ''.obs;

  @override
  Widget build(BuildContext context) {
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
