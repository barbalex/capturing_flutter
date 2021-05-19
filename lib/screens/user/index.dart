import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/user.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/screens/user/email.dart';

class UserWidget extends GetWidget<AuthController> {
  final Isar isar = Get.find<Isar>();
  final RxBool emailIsDirty = false.obs;
  final RxString emailErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    CUser? user = isar.cUsers
        .where()
        .filter()
        .emailEqualTo(controller.userEmail)
        .findFirstSync();

    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: user != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                EmailWidget(user: user),
              ],
            )
          : Text('Sorry, no user found'),
    );
  }
}
