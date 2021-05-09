import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:capturing/components/rowTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';

class RowList extends StatefulWidget {
  final Ctable table;

  RowList({required this.table});

  @override
  _RowListState createState() => _RowListState();
}

class _RowListState extends State<RowList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> rowListener;
  final String tableId = Get.parameters['tableId'] ?? '0';

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
    return FutureBuilder(
      future: Future.wait([
        isar.crows
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            // TODO: sort by what?
            .findAll(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Crow> rows = snapshot.data?[0] ?? [];
        List<String> labelFields = widget.table.labelFields ?? [];
        // TODO: sort by one label after the other, not their concatenation
        rows.sort((a, b) =>
            a.getLabel(labelFields).compareTo(b.getLabel(labelFields)));

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                return RowTile(
                  row: rows[index],
                  table: widget.table,
                );
              },
              itemCount: rows.length,
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
