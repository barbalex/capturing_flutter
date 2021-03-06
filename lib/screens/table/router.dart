import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/table/index.dart';
import 'package:capturing/screens/table/bottomNavBar.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:capturing/screens/table/table.dart';
import 'package:isar/isar.dart';
import 'package:capturing/store.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/table.dart';
import 'package:collection/collection.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:async';

class TableRouter extends StatefulWidget {
  @override
  State<TableRouter> createState() => _TableRouterState();
}

class _TableRouterState extends State<TableRouter> {
  late StreamSubscription<void> tableListener;
  final Isar isar = Get.find<Isar>();

  @override
  void initState() {
    super.initState();
    tableListener = isar.ctables
        .where()
        .idEqualTo(activeTableId ?? '')
        .watchLazy()
        .listen((event) {
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
    String layout = getLayout(context: context);

    if (layout == 'sm') return SlideInUp(child: TableContainer());
    final Isar isar = Get.find<Isar>();

    Project? project =
        isar.projects.filter().idEqualTo(activeProjectId ?? '').findFirstSync();
    List<Ctable> tables = isar.ctables
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(activeProjectId)
        .sortByOrd()
        .findAllSync();
    Ctable? table = tables.where((p) => p.id == activeTableId).firstOrNull;
    if (table == null) return Container();
    //print('tableRouter, activeTableId: $activeTableId');
    //print('tableRouter, activeTable: ${activeTable?.getLabel()}');

    return LargeLayout(
      content: SlideInUp(child: TableWidget(tables: tables, table: table)),
      title: '${'Table of'.tr} ${project?.getLabel()}',
      bottomNavBar: TableBottomNavBar(),
    );
  }
}
