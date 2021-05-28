import 'package:capturing/store.dart';
import 'package:flutter/material.dart';
import 'package:capturing/screens/tables/editable/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/tables/editable/tableMapsFromTables.dart';

class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> tableListener;
  final String projectId = activeProjectId ?? '';
  final level = 2.obs;

  @override
  void initState() {
    super.initState();
    tableListener = isar.ctables
        .where()
        .filter()
        .projectIdEqualTo(projectId)
        .and()
        .deletedEqualTo(false)
        .watchLazy()
        .listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tableListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('Table List, build, parentTableId: $parentTableId');
    return FutureBuilder(
      future: isar.ctables
          .where()
          .filter()
          .projectIdEqualTo(projectId)
          .and()
          .deletedEqualTo(false)
          .sortByOrd()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('snapshot: $snapshot');
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            if (snapshot.data == null) return Container();
            List<Map> tableMaps = tableMapsFromTables(snapshot.data);

            return ReorderableListView(
              children: <Widget>[
                for (int index = 0; index < tableMaps.length; index++)
                  TableTile(
                    key: Key('$index'),
                    table: tableMaps[index]['table'],
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                print('onReorder');
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                Map movedTable = tableMaps.removeAt(oldIndex);
                tableMaps.insert(newIndex, movedTable);
                tableMaps.asMap().forEach((index, tableMap) {
                  Ctable table = tableMap['table'];
                  if (table.ord != index) {
                    table.ord = index;
                    table.save();
                  }
                });
              },
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
