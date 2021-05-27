import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/screens/tables/editable/index.dart';
import 'package:capturing/screens/tables/noneditable/index.dart';

class Tables extends StatefulWidget {
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  final String projectId = activeProjectId ?? '';
  final Isar isar = Get.find<Isar>();
  StreamSubscription<String>? editingProjectListener;

  @override
  void dispose() {
    super.dispose();
    editingProjectListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    editingProjectListener = editingProject.listen((_) {
      setState(() {});
    });

    if (editingProject.value == projectId) {
      return TablesEditable();
    }
    return TablesNoneditable();
  }
}
