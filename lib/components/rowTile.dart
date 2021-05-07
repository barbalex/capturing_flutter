import 'package:capturing/models/row.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';

class RowTile extends StatelessWidget {
  final Ctable table;
  final Crow row;
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';

  RowTile({required this.row, required this.table});

  @override
  Widget build(BuildContext context) {
    List<String> labelFields = table.labelFields ?? [];
    String label = row.getLabel(labelFields);

    return Dismissible(
      key: Key(row.isarId.toString()),
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
        row.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // TODO: what field to use for name?
            content: Text("${row.id} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          // TODO: what field to use for name?
          label,
        ),
        onTap: () {
          // TODO:
          // only go to row details if user is account_admin AND editingStructure
          // else: go to tables
          Get.toNamed(
              '/projects/${projectId}/tables/${tableId}/rows/${row.id}');
        },
      ),
    );
  }
}
