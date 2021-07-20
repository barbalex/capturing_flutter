import 'package:flutter/material.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/store.dart';

class RowsFloatingActionButton extends StatelessWidget {
  final String? tableId = activeTableId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.add,
        size: 40,
      ),
      onPressed: () async {
        List<String> urlCopied = [...url];
        // remove last rows folder
        urlCopied.removeLast();
        int indexOfLastRowsFolder =
            urlCopied.lastIndexWhere((e) => e == '/rows/');
        String? parentRowId = indexOfLastRowsFolder == -1
            ? null
            : urlCopied.length > indexOfLastRowsFolder
                ? urlCopied[indexOfLastRowsFolder + 1]
                : null;
        Crow newRow = Crow(tableId: tableId, parentId: parentRowId);
        await newRow.create();
        url.value = [...url, newRow.id];
      },
      tooltip: 'Add Row',
    );
  }
}
