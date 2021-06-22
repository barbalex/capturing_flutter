import 'package:flutter/material.dart';
import 'package:capturing/screens/rows/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/store.dart';

class RowsList extends StatefulWidget {
  final Ctable? table;

  RowsList({this.table});

  @override
  _RowsListState createState() => _RowsListState();
}

class _RowsListState extends State<RowsList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> rowListener;
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;
  final String? parentTableId = url.length < 5 ? null : url[url.length - 2];

  @override
  void initState() {
    super.initState();
    rowListener = isar.crows.watchLazy().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    rowListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Ctable? table = widget.table;
    //print('Row List, parentTableId: $parentTableId');
    List<String> urlCopied = [...url];
    // remove last rows folder
    urlCopied.removeLast();
    int indexOfLastRowsFolder = urlCopied.lastIndexWhere((e) => e == '/rows/');
    String? parentRowId;
    try {
      parentRowId = urlCopied[indexOfLastRowsFolder + 1];
    } catch (e) {
      // example error: RangeError (index): Invalid value: Not in inclusive range 0..4: 5
      //print(e);
    }
    return FutureBuilder(
      future: Future.wait([
        isar.crows
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            .and()
            .optional(
              parentRowId != null,
              (q) => q.parentIdEqualTo(parentRowId),
            )
            .findAll(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            if (snapshot.data == null) return Container();
            List<Crow> rows = snapshot.data?[0] ?? [];
            List<String> labelFields = table?.labelFields ?? [];
            // TODO: sort by one label after the other, not their concatenation
            rows.sort((a, b) =>
                a.getLabel(labelFields).compareTo(b.getLabel(labelFields)));

            return ListView.builder(
              itemBuilder: (context, index) {
                Crow row = rows[index];

                return Column(
                  children: [
                    RowTile(
                      row: row,
                      table: table,
                    ),
                    Divider(
                      height: 0,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ],
                );
              },
              itemCount: rows.length,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
