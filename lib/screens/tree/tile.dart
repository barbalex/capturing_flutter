import 'package:flutter/material.dart';
import 'package:capturing/store.dart';

class TreeTile extends StatelessWidget {
  final Map object;

  TreeTile({required this.object});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(object['object'].getLabel()),
      onTap: () {
        url.value = object['url'];
        return;
      },
    );
  }
}
