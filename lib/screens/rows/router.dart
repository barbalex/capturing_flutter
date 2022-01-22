import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/rows/index.dart';
import 'package:capturing/screens/rows/bottomNavBar.dart';
import 'package:capturing/screens/rows/floatingActionButton.dart';
import 'package:capturing/screens/rows/list.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:capturing/models/row.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/project.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:async';

class RowsRouter extends StatefulWidget {
  @override
  State<RowsRouter> createState() => _RowsRouterState();
}

class _RowsRouterState extends State<RowsRouter> {
  late StreamSubscription<void> rowsListener;
  final Isar isar = Get.find<Isar>();

  @override
  void initState() {
    super.initState();
    rowsListener = isar.crows
        .where()
        .filter()
        .deletedEqualTo(false)
        .and()
        .tableIdEqualTo(activeTableId)
        .watchLazy()
        .listen((event) {
      print('rows router listener registered change');
      setState(() {});
    });
  }

  @override
  void dispose() {
    rowsListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);
    final String? tableId = activeTableId;
    final Isar isar = Get.find<Isar>();

    goUp() async {
      List<String> newUrl = [...url];
      if (url.length.isEven && url.length > 0) {
        // this is a row > go up to it's list
        newUrl.removeLast();
      } else if (url.length == 5) {
        // up four, if grandParent is project and only one table exists
        // else: up two
        int parentTablesCount = 0;
        // only check parent if url is long enough
        String? grandParentType = url.length > 4 ? url[url.length - 5] : null;
        String? grandParentId = url.length > 3 ? url[url.length - 4] : null;
        if (grandParentType == '/projects/') {
          parentTablesCount = await isar.ctables
              .where()
              .filter()
              .projectIdEqualTo(grandParentId)
              .and()
              .parentIdIsNull()
              .and()
              .deletedEqualTo(false)
              .and()
              .optionTypeEqualTo(null)
              .count();
        }
        if (newUrl.length > 3) {
          newUrl.removeLast();
          newUrl.removeLast();
          newUrl.removeLast();
          newUrl.removeLast();
        }
        if (parentTablesCount == 1 && newUrl.length > 3) {
          newUrl.removeLast();
          newUrl.removeLast();
          newUrl.removeLast();
          newUrl.removeLast();
        }
      } else {
        // if grandParent is not project, never go up four
        // because there are or can be created rows next to tables!
        if (newUrl.length > 3) {
          newUrl.removeLast();
          newUrl.removeLast();
          newUrl.removeLast();
          newUrl.removeLast();
        }
      }
      url.value = newUrl;
    }

    if (layout == 'sm') return SlideInUp(child: RowsContainer(goUp: goUp));
    Ctable? table = isar.ctables
      ..filter().idEqualTo(tableId ?? '').findFirstSync();
    Project? project = isar.projects
        .where()
        .filter()
        .idEqualTo(activeProjectId ?? '')
        .findFirstSync();
    String label = table?.getLabel() ?? project?.getLabel() ?? '';

    return LargeLayout(
      content: SlideInUp(child: RowsList()),
      title: label,
      bottomNavBar: RowsBottomNavBar(goUp: goUp),
      floatingActionButton: RowsFloatingActionButton(),
    );
  }
}
