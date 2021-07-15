// get widget
// place that widget into content
// add sidebar with tree

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:capturing/screens/tree/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:capturing/store.dart';
import 'package:capturing/models/store.dart';
import 'package:isar/isar.dart';
import 'isar.g.dart';
import 'package:get/get.dart';

class LargeLayout extends StatefulWidget {
  final Widget content;
  final Widget bottomNavBar;
  final String title;

  LargeLayout({
    required this.content,
    required this.title,
    required this.bottomNavBar,
  });

  @override
  State<LargeLayout> createState() => _LargeLayoutState();
}

class _LargeLayoutState extends State<LargeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: LayoutGrid(
        columnSizes: [largeLayoutTreeColumnSize.value.px, 12.px, 1.fr],
        rowSizes: [1.fr],
        children: [
          Tree(),
          MouseRegion(
            cursor: SystemMouseCursors.resizeLeftRight,
            child: Stack(
              children: [
                Center(
                    child: Container(
                  child: Icon(
                    Icons.drag_indicator,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  transform: Matrix4.translationValues(-6, 0, 0),
                )),
                Draggable(
                  child: VerticalDivider(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    thickness: 12,
                    width: 12,
                  ),
                  feedback: Container(),
                  onDragUpdate: (details) {
                    EasyDebounce.debounce(
                        'layoutDivider', Duration(milliseconds: 1), () {
                      int newVal = details.globalPosition.dx.toInt();
                      if (newVal != largeLayoutTreeColumnSize.value) {
                        largeLayoutTreeColumnSize.value = newVal;
                        setState(() {});
                      }
                    });

                    final Isar isar = Get.find<Isar>();
                    EasyDebounce.debounce(
                        'treeColumnSizeSetting', Duration(milliseconds: 200),
                        () async {
                      Store? store = await isar.stores.get(1);
                      if (store?.largeLayoutTreeColumnSize !=
                          largeLayoutTreeColumnSize.value) {
                        await isar.writeTxn((_) async {
                          store?.largeLayoutTreeColumnSize =
                              largeLayoutTreeColumnSize.value;
                          await isar.stores.put(store as Store);
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          widget.content,
        ],
      ),
      bottomNavigationBar: widget.bottomNavBar,
    );
  }
}
