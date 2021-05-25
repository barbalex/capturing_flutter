import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class RowTableTile extends StatelessWidget {
  final Ctable table;
  final Isar isar = Get.find<Isar>();

  RowTableTile({required this.table});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(table.isarId.toString()),
      // Show a red background as the item is swiped away.
      background: Container(
        color: Theme.of(context).accentColor,
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
        table.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${table.label ?? table.name ?? ''} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          table.label ?? table.name ?? '',
        ),
        onTap: () {
          List<String> urlCopied = [...url];
          urlCopied.removeLast();
          List<String> newUrl = [...urlCopied, '/tables/', table.id, '/rows/'];
          print('RowTableTile. url: $url, newUrl: $newUrl');
          url.value = newUrl;
        },
      ),
    );
  }
}
