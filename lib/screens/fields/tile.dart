import 'package:capturing/models/field.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class FieldTile extends StatelessWidget {
  final Field field;
  final Key key;

  FieldTile({
    required this.field,
    required this.key,
  }) : super(key: key);

  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(field.isarId.toString()),
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
        field.delete();
        // Show a snackbar. This snackbar could also contain "Undo" actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${field.getLabel()} dismissed"),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(field.getLabel()),
            onTap: () {
              url.value = [...url, field.id];
            },
            trailing: Icon(
              Icons.drag_handle,
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
