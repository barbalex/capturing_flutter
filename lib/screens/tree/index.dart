import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/project.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:capturing/screens/tree/tile.dart';
import 'package:capturing/store.dart';
import 'package:capturing/screens/tree/nodes/index.dart';

class Tree extends StatefulWidget {
  final bool? multiColumn;
  Tree({this.multiColumn = false});

  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  final Isar isar = Get.find<Isar>();
  late StreamSubscription<void> projectListener;
  final String projectId = activeProjectId ?? '';

  @override
  void initState() {
    super.initState();
    projectListener = isar.projects.watchLazy().listen((event) {
      setState(() {});
    });
    ever(editingProject, (_) async {
      setState(() {});
    });
  }

  @override
  void dispose() {
    projectListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('tree rendering');
    List<Map> nodes = buildNodes();
    final bool multiColumn = widget.multiColumn ?? false;
    double dividerOpacity = multiColumn ? 0.4 : 0;

    return Material(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              TreeTile(object: nodes[index]),
              Divider(
                height: 0,
                color:
                    Theme.of(context).primaryColor.withOpacity(dividerOpacity),
              ),
            ],
          );
        },
        itemCount: nodes.length,
      ),
    );
  }
}
