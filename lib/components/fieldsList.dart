import 'package:flutter/material.dart';
import 'package:capturing/components/fieldTile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';

class FieldList extends StatefulWidget {
  @override
  _FieldListState createState() => _FieldListState();
}

class _FieldListState extends State<FieldList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> fieldListener;
  final String tableId = Get.parameters['tableId'] ?? '0';

  @override
  void initState() {
    super.initState();
    fieldListener = isar.fields.watchLazy().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    fieldListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isar.fields
          .where()
          .filter()
          .deletedEqualTo(false)
          .and()
          .tableIdEqualTo(tableId)
          .sortByName()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                return FieldTile(
                  field: snapshot.data[index],
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
