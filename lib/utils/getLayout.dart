import 'package:flutter/cupertino.dart';

String getLayout({required BuildContext context}) {
  String layout = 'mobile';
  final mediaQuery = MediaQuery.of(context);
  if (mediaQuery.size.width > 1024) layout = 'large';
  return layout;
}
