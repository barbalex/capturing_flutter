import 'package:capturing/store.dart';
import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/fields/index.dart';
import 'package:capturing/screens/fields/list.dart';
import 'package:capturing/screens/fields/bottomNavBar.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class FieldsRouter extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);

    if (layout == 'sm') return FieldsContainer();
    Ctable? table = isar.ctables
        .where()
        .filter()
        .idEqualTo(activeTableId ?? '')
        .findFirstSync();

    return LargeLayout(
      content: FieldList(),
      title: '${'Fields of'.tr} ${table?.getSingleLabel() ?? ''}',
      bottomNavBar: FieldsBottomNavBar(),
    );
  }
}
