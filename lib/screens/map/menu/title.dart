import 'package:flutter/material.dart';

class MapTitle extends StatelessWidget {
  final String title;

  MapTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -1, 0),
      width: 50,
      height: 13,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        border: Border(
          left: BorderSide(color: Theme.of(context).primaryColor),
          right: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}