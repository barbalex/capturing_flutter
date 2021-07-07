import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';

class TreeTile extends StatelessWidget {
  final Project project;
  final Isar isar = Get.find<Isar>();

  TreeTile({required this.project});

  @override
  Widget build(BuildContext context) {
    //print('ProjectsTile, 1');
    return ListTile(
      title: Text(project.getLabel()),
      onTap: () async {
        List<Ctable> tables = await isar.ctables
            .where()
            .filter()
            .projectIdEqualTo(project.id)
            .and()
            .parentIdIsNull()
            .and()
            .deletedEqualTo(false)
            .and()
            // show option tables only when editing structure
            .optional(editingProject.value != project.id,
                (q) => q.optionTypeEqualTo(null))
            .findAll();
        int tableCount = tables.length;
        // if only one table exists, navigate to children list
        if (tableCount == 1 && editingProject.value != project.id) {
          url.value = [
            '/projects/',
            project.id,
            '/tables/',
            tables[0].id,
            '/rows/',
          ];
          return;
        }
        mayEdit(project.id)
            ? url.value = ['/projects/', project.id]
            : url.value = ['/projects/', project.id, '/tables/'];
        return;
      },
    );
  }
}
