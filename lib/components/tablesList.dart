import 'package:flutter/material.dart';
import 'package:capturing/components/tableTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    final String projectId = Get.parameters['projectId'] ?? '0';
    isar.ctables.watchLazy().listen((event) {
      setState(() {});
    });

    print('tablesList, projectId: $projectId');

    return FutureBuilder(
      future: isar.ctables
          .where()
          .filter()
          .deletedEqualTo(false)
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
            print('tablesList, data: ${snapshot.data}');
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
