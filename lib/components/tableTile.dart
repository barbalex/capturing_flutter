import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class TableTile extends StatelessWidget {
  final Ctable table;
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '';

  TableTile({required this.table});

  @override
  Widget build(BuildContext context) {
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
            content: Text("${table.label ?? table.name ?? ''} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          table.label ?? table.name ?? '',
        ),
        onTap: () {
          editingProject.value == projectId
              ? Get.toNamed('/projects/${table.projectId}/tables/${table.id}')
              : Get.toNamed(
                  '/projects/${table.projectId}/tables/${table.id}/rows/');
        },
      ),
    );
  }
}
