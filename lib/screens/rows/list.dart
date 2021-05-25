import 'package:flutter/material.dart';
import 'package:capturing/screens/rows/rowTile.dart';
import 'package:capturing/screens/rows/tableTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/store.dart';

class RowList extends StatefulWidget {
  final Ctable table;

  RowList({required this.table});

  @override
  _RowListState createState() => _RowListState();
}

class _RowListState extends State<RowList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> rowListener;

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
    Ctable table = widget.table;

    return FutureBuilder(
      future: Future.wait([
        isar.crows
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(activeTableId)
            .findAll(),
        isar.ctables
            .where()
            .filter()
            .projectIdEqualTo(activeProjectId)
            .and()
            .optional(parentTableId == null, (q) => q.parentIdIsNull())
            .and()
            .optional(
                parentTableId != null, (q) => q.parentIdEqualTo(parentTableId))
            .and()
            .deletedEqualTo(false)
            .and()
            // show option tables only when editing structure
            .optional(editingProject.value != activeProjectId,
                (q) => q.optionTypeEqualTo(null))
            .sortByName()
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
            List<Crow> rows = snapshot.data?[0] ?? [];
            List<Ctable> tables = snapshot.data?[1] ?? [];
            List<String> labelFields = table.labelFields ?? [];
            // TODO: sort by one label after the other, not their concatenation
            rows.sort((a, b) =>
                a.getLabel(labelFields).compareTo(b.getLabel(labelFields)));
            List<dynamic> children = [];
            if (tables.length > 0) {
              // TODO: push title
              children.add('Tables:');
              children.addAll(tables);
            }
            if (rows.length > 0) {
              children.add('Rows:');
              children.addAll(rows);
            }
            children.forEach((el) {
              print('RowsList, elType: ${el.runtimeType}');
            });

            return ListView.builder(
              itemBuilder: (context, index) {
                dynamic child = children[index];
                bool isTitle = child.runtimeType == String;
                bool isTable = child.runtimeType == Ctable;

                return Column(
                  children: [
                    isTitle
                        ? Container(
                            alignment: Alignment.centerLeft,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Text(
                                child,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : isTable
                            ? RowTableTile(table: child)
                            : RowTile(
                                row: child,
                                table: table,
                              ),
                    Divider(
                      height: 0,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ],
                );
              },
              itemCount: children.length,
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
