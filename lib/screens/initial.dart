import 'package:flutter/material.dart';

/**
 * It takes a moment to fetch the store from isar
 * If a data url is shown immediately, the data will be empty
 * that creates a not so nice transition when the data arrives
 * so show a spinner
 */

class Initial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
