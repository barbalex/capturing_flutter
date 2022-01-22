import 'package:flutter/material.dart';
import 'package:capturing/screens/fields/tile.dart';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';

class FieldList extends StatefulWidget {
  @override
  _FieldListState createState() => _FieldListState();
}

class _FieldListState extends State<FieldList> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> fieldListener;
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;

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
    List<Field> fields = isar.fields
        .filter()
        .deletedEqualTo(false)
        .and()
        .tableIdEqualTo(tableId)
        .sortByOrd()
        .findAllSync();

    return ReorderableListView(
      children: <Widget>[
        for (int index = 0; index < fields.length; index++)
          FieldTile(
            key: Key('$index'),
            field: fields[index],
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
