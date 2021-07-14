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
    List<String> objectUrl =
        (object['url'] as List).map((e) => e as String).toList();
    double level = object['level']?.toDouble();
    double left = level == 1 ? level * 10 : level * 17;
    bool open = object['open'];
    bool inUrl = url.join().contains(objectUrl.join());

    return InkWell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(left, 14, 10, 14),
        child: Row(
          children: [
            Icon(open ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                object['object'].getLabel(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: inUrl ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        url.value = objectUrl;
        return;
      },
    );
  }
}
