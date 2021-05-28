import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TableTile extends StatelessWidget {
  final Ctable table;
  final Key key;
  final int level;

  TableTile({
    required this.table,
    required this.key,
    required this.level,
  }) : super(key: key);

  final Isar isar = Get.find<Isar>();

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
            content: Text("${table.getLabel()} dismissed"),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: EdgeInsets.only(left: level > 1 ? (level - 2) * 26 : 0),
              child: Row(
                children: [
                  Text('${level > 1 ? '→   ' : ''}${table.getLabel()}'),
                  Container(
                    child: table.optionType == null
                        ? null
                        : Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Tooltip(
                              message: 'is an options list',
                              child: Icon(
                                FontAwesomeIcons.caretSquareDown,
                                size: 16,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            onTap: () {
              List<String> newUrl = [
                '/projects/',
                table.projectId ?? '',
                '/tables/',
                table.id
              ];
              url.value = newUrl;
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
