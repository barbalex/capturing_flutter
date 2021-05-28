import 'package:capturing/models/row.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/store.dart';

class RowTile extends StatelessWidget {
  final Ctable? table;
  final Crow row;
  final Isar isar = Get.find<Isar>();

  RowTile({required this.row, this.table});

  @override
  Widget build(BuildContext context) {
    List<String> labelFields = table?.labelFields ?? [];
    String label = row.getLabel(labelFields);

    return Dismissible(
      key: Key(row.isarId.toString()),
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
        row.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${label} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          label,
        ),
        onTap: () {
          url.value = [...url, row.id];
        },
      ),
    );
  }
}
