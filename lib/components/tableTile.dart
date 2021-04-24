import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';

class TableTile extends StatelessWidget {
  final Ctable table;
  final Isar isar = Get.find<Isar>();

  TableTile({required this.table});

  @override
  Widget build(BuildContext context) {
    print(
        'table: id: ${table.id}, name: ${table.name}, clientRevAt: ${table.clientRevAt}, clientRevBy: ${table.clientRevBy}');
    return Dismissible(
      key: Key(table.isarId.toString()),
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
        table.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${table.name ?? ''} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          table.name ?? '',
        ),
        onTap: () {
          // TODO:
          // only go to table details if user is account_admin AND editingStructure
          // else: go to tables
          Get.toNamed('/projects/${table.projectId}/tables/${table.id}');
        },
      ),
    );
  }
}
