import 'package:flutter/cupertino.dart';

String getLayout({required BuildContext context}) {
  String layout = 'sm';
  final mediaQuery = MediaQuery.of(context);
  if (mediaQuery.size.width > 1023) layout = 'lg';
  if (mediaQuery.size.width > 1919) layout = 'xl';
  return layout;
}
