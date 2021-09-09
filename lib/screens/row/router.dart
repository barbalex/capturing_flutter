import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/row/index.dart';
import 'package:capturing/screens/row/row.dart';
import 'package:capturing/screens/row/bottomNavBar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/store.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:async';

class RowRouter extends StatefulWidget {
  @override
  State<RowRouter> createState() => _RowRouterState();
}

class _RowRouterState extends State<RowRouter> {
  late StreamSubscription<void> rowsListener;
  final Isar isar = Get.find<Isar>();

  @override
  void initState() {
    super.initState();
    rowsListener = isar.crows
        .where()
        .idEqualTo(activeRowId ?? '')
        .watchLazy()
        .listen((event) {
      print('row router listener registered change');
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

    if (layout == 'sm') return SlideInUp(child: RowContainer());

    final Isar isar = Get.find<Isar>();
    Crow? row = isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
    if (row == null) return Container();
    Ctable? table =
        isar.ctables.where().idEqualTo(row.tableId ?? '').findFirstSync();
    String? formTitle = table?.singleLabel != null
        ? table?.singleLabel
        : '${'Row of'.tr} ${table?.getLabel()}';

    return LargeLayout(
      content: SlideInUp(child: RowWidget(row: row)),
      title: formTitle ?? '(table without label)'.tr,
      bottomNavBar: RowBottomNavBar(row: row),
    );
  }
}
