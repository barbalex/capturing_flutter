import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/screens/user/email.dart';

class UserWidget extends GetWidget<AuthController> {
  final Isar isar = Get.find<Isar>();
  final emailIsDirty = false.obs;
  final emailErrorText = ''.obs;
  final sendEmailTitle = 'Send email to reset password'.obs;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  EmailWidget(user: user),
                  SizedBox(height: 8),
                  OutlinedButton(
                    child: Text('Log out'),
                    onPressed: controller.signOut,
                  ),
                  Obx(
                    () => OutlinedButton(
                      child: Text(sendEmailTitle.value),
                      onPressed: () {
                        if (sendEmailTitle.value.contains('was sent')) {
                          return;
                        }
                        controller.sendPasswordResetEmail();
                        sendEmailTitle.value =
                            'The email was sent. Please check your email app';
                        Timer(Duration(seconds: 10), () {
                          sendEmailTitle.value = 'Send email to reset password';
                        });
                      },
                    ),
                  ),
                ],
              )
            : Text('Sorry, no user found'),
      ),
    );
  }
}
