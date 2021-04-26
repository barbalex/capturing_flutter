import 'package:capturing/models/field.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';

class FieldTile extends StatelessWidget {
  final Field field;
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';

  FieldTile({required this.field});

  @override
  Widget build(BuildContext context) {
    // print(
    //     'field: id: ${field.id}, name: ${field.name}, clientRevAt: ${field.clientRevAt}, clientRevBy: ${field.clientRevBy}');
    return Dismissible(
      key: Key(field.isarId.toString()),
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
        field.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${field.name ?? ''} dismissed"),
          ),
        );
      },
      child: ListTile(
        title: Text(
          field.name ?? '',
        ),
        onTap: () {
          // TODO:
          // only go to field details if user is account_admin AND editingStructure
          // else: go to tables
          Get.toNamed(
              '/projects/${projectId}/tables/${tableId}/fields/${field.id}');
        },
      ),
    );
  }
}
