import 'package:flutter/material.dart';
import 'package:capturing/screens/fields/tile.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/field.dart';
import 'dart:math';

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
          .sortByOrd()
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
            List<Field> fields = snapshot.data;

            return ReorderableListView(
              children: <Widget>[
                for (int index = 0; index < fields.length; index++)
                  FieldTile(
                    key: Key('$index'),
                    field: fields[index],
                    index: index,
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                Field movedField = fields.removeAt(oldIndex);
                fields.insert(newIndex, movedField);
                fields.asMap().forEach((index, field) {
                  if (field.ord != index) {
                    field.ord = index;
                    field.save();
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
