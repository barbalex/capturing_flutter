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

class RowRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);

    if (layout == 'sm') return SlideInUp(child: RowContainer());

    final Isar isar = Get.find<Isar>();
    Crow? row = isar.crows.where().idEqualTo(activeRowId ?? '').findFirstSync();
    if (row == null) return Container();
    Ctable? table = isar.ctables
        .where()
        .filter()
        .idEqualTo(row.tableId ?? '')
        .findFirstSync();
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
