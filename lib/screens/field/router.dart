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
import 'dart:async';

class FieldRouter extends StatefulWidget {
  @override
  State<FieldRouter> createState() => _FieldRouterState();
}

class _FieldRouterState extends State<FieldRouter> {
  late StreamSubscription<void> tableListener;
  final Isar isar = Get.find<Isar>();

  @override
  void initState() {
    super.initState();
    tableListener = isar.fields
        .where()
        .idEqualTo(activeFieldId ?? '')
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
    Field? field =
        isar.fields.where().idEqualTo(activeFieldId ?? '').findFirstSync();
    print('FieldRouter, field id: ${field?.id}');

    if (field == null) return Container();

    if (layout == 'sm') {
      return SlideInUp(child: FieldContainer(field: field));
    }

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
