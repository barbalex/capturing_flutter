import 'package:flutter/material.dart';
import 'package:capturing/components/tableTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';

class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> tableListener;

  @override
  void initState() {
    super.initState();
    final String projectId = Get.parameters['projectId'] ?? '0';
    tableListener = isar.ctables
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(projectId)
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
    final String projectId = Get.parameters['projectId'] ?? '0';

    //print('tablesList, projectId: $projectId');

    return FutureBuilder(
      future: isar.ctables
          .where()
          .filter()
          .deletedEqualTo(false)
          .and()
          .projectIdEqualTo(projectId)
          .sortByName()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
            );
          } else {
            //print('tablesList, data: ${snapshot.data}');
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                return TableTile(
                  table: snapshot.data[index],
                );
              },
              itemCount: snapshot.data.length,
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
