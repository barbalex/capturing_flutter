import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/screens/user/email.dart';
import 'package:expandable/expandable.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'We don\'t want your personal data.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                          'We only need your email address to recognize and authenticate you:'),
                    ],
                  ),
                  SizedBox(height: 0),
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
                  Card(
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text(
                          'Who needs subscriptions?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          children: [
                            Text(
                                'We do: to cover our bills 💰. You pay us with subscriptions, not with your data or ads.'),
                            SizedBox(height: 8),
                            Text(
                                'The deal is: we try to give you the best possible experience and keep your data safe. Happy customers and many subscriptions make us feel good 😊.'),
                            SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'You can use the '),
                                  TextSpan(
                                    text: 'free 30 day subscription',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' for testing.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'After it expires, you need a valid subscription to configure projects and keep them editable.'),
                            SizedBox(height: 8),
                            Text(
                                'Thus the user who created a project (its owner) needs a valid subscription.'),
                            SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Additional collaborators, whose emails are listed as project users, do '),
                                  TextSpan(
                                    text: 'not',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          ' need a subscription. They only need to register with their email. Then all projects in which they participate are synced to their app and they can start working.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text(
                          'What happens when a subscription expires?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          children: [
                            Text(
                                'When the subscription expires, so does the ability to configure projects and edit data 😢.'),
                            SizedBox(height: 8),
                            Text(
                                'You will still be able to read and export the data.'),
                            SizedBox(height: 8),
                            Text(
                                'Three months after expiration projects are removed from our live servers.'),
                            SizedBox(height: 8),
                            Text(
                                'Backups exist and your data will remain in your app. But as we pay our bills with subscriptions, we will not feel responsible for your data any more 🤷.'),
                            SizedBox(height: 8),
                            Text(
                                'Of course we will send you an email beforehand - we\'d love too keep you ❤️.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Text('Sorry, no user found'),
      ),
    );
  }
}
