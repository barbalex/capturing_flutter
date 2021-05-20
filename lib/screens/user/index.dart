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
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'We don\'t need nor want your '),
                            TextSpan(
                              text: 'personal data',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                      ),
                      Text('So we reduce it to a minimum:'),
                      Text('- your email address (to recognize you)'),
                      Text('- subscription payments (to pay our bills)'),
                    ],
                  ),
                  SizedBox(height: 8),
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
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Text(
                        'Who needs a subscription?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Inside the free tier you can test everything.'),
                      Text(
                          'After the free tier expires, a valid subscription is required to create and configure projects as well as edit their data.'),
                      Text(
                          'Thus the user who created a project (its owner) needs to have a valid subscription.'),
                      Text(
                          'Additional collaborators, whose email is listed as project user, do not need a subscription. They only need to register with their email.'),
                      Text(
                          'When a subscription expires, you will only be able to read your data. That includes exporting it. Project owners will also be able to delete projects. Three months after expiration projects are removed from our live servers (Backups exist).'),
                      Text(
                          'We will send you an email before your subscription expires - we\'d love too keep you!'),
                    ],
                  ),
                ],
              )
            : Text('Sorry, no user found'),
      ),
    );
  }
}
