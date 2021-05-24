import 'package:capturing/models/field.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';

class FieldTile extends StatelessWidget {
  final Field field;
  final int index;
  final Key key;
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '';
  final String tableId = Get.parameters['tableId'] ?? '';
  final String tableId2 = Get.parameters['tableId2'] ?? '';
  final String tableId3 = Get.parameters['tableId3'] ?? '';

  FieldTile({
    required this.field,
    required this.index,
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(field.isarId.toString()),
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
        field.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${field.label ?? field.name ?? '(field without name)'} dismissed"),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              field.label ?? field.name ?? '(field without name)',
            ),
            //tileColor: index.isOdd ? oddItemColor : evenItemColor,
            onTap: () {
              Get.toNamed(
                  '/projects/${projectId}/tables/${tableId}/fields/${field.id}');
            },
            trailing: Icon(
              Icons.drag_indicator,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
