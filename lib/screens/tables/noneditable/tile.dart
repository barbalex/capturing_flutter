import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class TablesNoneditableTile extends StatelessWidget {
  final Ctable table;
  final Isar isar = Get.find<Isar>();

  TablesNoneditableTile({required this.table});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(table.isarId.toString()),
      // Show a red background as the item is swiped away.
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: Text(
            'delete'.tr,
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
            content: Text('${table.getLabel()} ${'deleted'.tr}'),
          ),
        );
      },
      child: ListTile(
        title: Text(table.getLabel()),
        onTap: () {
          List<String> newUrl = [
            '/projects/',
            table.projectId ?? '',
            '/tables/',
            table.id,
            '/rows/'
          ];
          url.value = newUrl;
        },
      ),
    );
  }
}
