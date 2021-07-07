import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class TreeTile extends StatelessWidget {
  final Map object;

  TreeTile({required this.object});

  @override
  Widget build(BuildContext context) {
    //print('ProjectsTile, 1');

    return ListTile(
      title: Text(object['object'].getLabel()),
      onTap: () {
        url.value = object['url'];
        return;
      },
    );
  }
}
