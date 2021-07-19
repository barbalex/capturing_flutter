import 'package:capturing/screens/field/field.dart';
import 'package:capturing/store.dart';
import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/field/index.dart';
import 'package:capturing/screens/field/bottomNavBar.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/largeLayout.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:animate_do/animate_do.dart';

class FieldRouter extends StatelessWidget {
  final Isar isar = Get.find<Isar>();

  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);
    final String? fieldId = url.length > 0 ? url[url.length - 1] : null;
    Field? field = isar.fields.where().idEqualTo(fieldId ?? '').findFirstSync();

    if (field == null) return Container();

    if (layout == 'sm') return FieldContainer(field: field);
    Ctable? table = isar.ctables
        .where()
        .filter()
        .idEqualTo(activeTableId ?? '')
        .findFirstSync();

    return LargeLayout(
      content: SlideInUp(child: FieldWidget(field: field)),
      title: '${'Field of'.tr} ${table?.getSingleLabel() ?? ''}',
      bottomNavBar: FieldBottomNavBar(),
    );
  }
}
