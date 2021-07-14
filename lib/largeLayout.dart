// get widget
// place that widget into content
// add sidebar with tree

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:capturing/screens/tree/index.dart';

class LargeLayout extends StatelessWidget {
  Widget content;

  LargeLayout({required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      columnSizes: [300.px, 1.fr],
      rowSizes: [1.fr],
      children: [
        Tree(),
        content,
      ],
    );
  }
}
