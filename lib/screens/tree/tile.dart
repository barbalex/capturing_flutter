import 'package:flutter/material.dart';
import 'package:capturing/store.dart';

class TreeTile extends StatelessWidget {
  final Map object;

  TreeTile({required this.object});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // add indent symbol and indentation
    // klick symbol and text separately?
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            SizedBox(width: 10),
            Text(
              object['object'].getLabel(),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      onTap: () {
        url.value = object['url'];
        return;
      },
    );
  }
}
