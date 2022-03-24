import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:isar/isar.dart';
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
    CUser? user =
        isar.cUsers.filter().emailEqualTo(controller.userEmail).findFirstSync();

    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  EmailWidget(user: user),
                  SizedBox(height: 8),
                  OutlinedButton(
                    child: Text('Log out'),
                    onPressed: () => controller.logOut(context),
                  ),
                  SizedBox(height: 8),
                  OutlinedButton(
                    child: Text('Purge then reload data'),
                    onPressed: () => controller.reloadData(context),
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
                  SizedBox(height: 8),
                  Card(
                    margin: EdgeInsetsGeometry.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.zero,
                      0,
                    ),
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text(
                          'I care about my personal data 😟',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('We don\'t want it!'),
                            SizedBox(height: 8),
                            Text(
                                'We only need your email address to recognize and authenticate you.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    margin: EdgeInsetsGeometry.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.zero,
                      0,
                    ),
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text(
                          'How is capturing.app financed? 💰',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('With payed subscriptions.'),
                            SizedBox(height: 8),
                            Text('Not with your data or ads!'),
                            SizedBox(height: 8),
                            Text(
                                'The deal is: In return for your subscription we work hard to give you the best possible experience and keep your data safe.'),
                            SizedBox(height: 8),
                            Text(
                                'Happy customers and many payed subscriptions make us feel good 😊'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    margin: EdgeInsetsGeometry.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.zero,
                      0,
                    ),
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Who needs subscriptions? ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.0,
                                  ),
                                  child: Icon(
                                    // WAS: Icons.groups
                                    // but mac said it did not exist????
                                    Icons.group,
                                    size: 16,
                                    color: Colors.yellow.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Whoever creates a project (its owner).'),
                            SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Additional collaborators, whose emails the owner lists as project users, do '),
                                  TextSpan(
                                    text: 'not',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' need a subscription. ',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'Collaborators only need to register with their email. Then all projects in which they participate are synced to their app.'),
                            SizedBox(height: 8),
                            Text(
                                'You can simultaneously own projects and collaborate in others.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    margin: EdgeInsetsGeometry.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.zero,
                      0,
                    ),
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'What subscriptions exist? ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 16,
                                    color: Colors.yellow.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Use the '),
                                  TextSpan(
                                    text: 'free 30 day',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' subscription for testing.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'After it expires, you need a payed subscription to configure own projects and keep them editable.'),
                            SizedBox(height: 8),
                            Text(
                                'We haven\'t decided on payed subscriptions yet.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    margin: EdgeInsetsGeometry.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.zero,
                      0,
                    ),
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconPadding: EdgeInsets.all(15),
                        iconSize: 30,
                      ),
                      header: ListTile(
                        title: Text(
                          'What if a subscription expires? 🤔',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'It is no more possible to configure projects and edit data 😢.'),
                            SizedBox(height: 8),
                            Text(
                                'You will still be able to read and export the data.'),
                            SizedBox(height: 8),
                            Text(
                                'Three months after expiration projects are removed from our live servers.'),
                            SizedBox(height: 8),
                            Text(
                                'Backups exist and your data will remain in your app. But as we pay our bills with subscriptions, we won\'t feel responsible for your data any more 🙁.'),
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
