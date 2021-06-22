import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/screens/tables/editable/index.dart';
import 'package:capturing/screens/tables/noneditable/index.dart';

class TablesListRouter extends StatefulWidget {
  @override
  _TablesListRouterState createState() => _TablesListRouterState();
}

class _TablesListRouterState extends State<TablesListRouter> {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();

  @override
  void initState() {
    super.initState();
    ever(editingProject, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (editingProject.value == projectId) {
      return TablesEditable();
    }
    return TablesNoneditable();
  }
}
