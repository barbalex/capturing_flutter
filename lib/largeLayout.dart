// get widget
// place that widget into content
// add sidebar with tree

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:capturing/screens/tree/index.dart';

class LargeLayout extends StatelessWidget {
  final Widget content;
  final Widget bottomNavBar;
  final String title;

  LargeLayout(
      {required this.content, required this.title, required this.bottomNavBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: LayoutGrid(
        columnSizes: [300.px, 5.px, 1.fr],
        rowSizes: [1.fr],
        children: [
          Tree(),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              print('details: $details');
            },
            child: VerticalDivider(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              width: 5,
            ),
          ),
          content,
        ],
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
