import 'package:flutter/material.dart';
import 'package:capturing/store.dart';
import 'package:capturing/models/project.dart';
import 'package:get/get.dart';

class TreeTile extends StatelessWidget {
  final Map object;

  TreeTile({required this.object});

  @override
  Widget build(BuildContext context) {
    // TODO:
    // add indent symbol and indentation
    // klick symbol and text separately?
    bool editingStructure = editingProject.value == object['object'].id;
    List<String> objectUrl =
        (object['url'] as List).map((e) => e as String).toList();
    double level = object['level']?.toDouble();
    double left = level == 1 ? level * 10 : level * 17;
    bool open = object['open'];
    bool inUrl = url.join().contains(objectUrl.join());
    bool mayEdit = object['object'].runtimeType == Project
        ? mayEditByProject(object['object'])
        : false;
    Widget editButton = mayEdit
        ? IconButton(
            icon: Icon(
              editingStructure ? Icons.build : Icons.build_outlined,
            ),
            onPressed: () {
              editingProject.value =
                  editingStructure ? '' : object['object'].id;
            },
            tooltip: editingStructure
                ? 'Editing data structure. Click to stop.'.tr
                : 'Edit data structure'.tr,
            color: editingStructure
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
          )
        : Container();

    return InkWell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(left, 14, 10, 14),
        child: Row(
          children: [
            Icon(
              open ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  editButton,
                ],
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
