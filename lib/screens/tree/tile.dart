import 'package:flutter/material.dart';
import 'package:capturing/store.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    double left = 10 + (level - 1) * 28;
    bool open = object['open'];
    bool hasChildren = object['hasChildren'];
    bool inUrl = url.join().contains(objectUrl.join());
    //print('url: $url');
    //print('objectUrl: $objectUrl');
    //print('object: $object');
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
        padding: EdgeInsets.fromLTRB(left, 14, 0, 14),
        child: Row(
          children: [
            Container(
              child: object['object'].runtimeType == Field
                  ? Image.asset(
                      "images/column.png",
                      width: 18,
                      height: 18,
                      color: Theme.of(context).primaryColor,
                    )
                  : object['object'].runtimeType == Ctable
                      ? Image.asset(
                          "images/table.png",
                          width: 18,
                          height: 18,
                          color: Theme.of(context).primaryColor,
                        )
                      : hasChildren
                          ? Icon(
                              open
                                  ? FontAwesomeIcons.chevronDown
                                  : FontAwesomeIcons.chevronRight,
                              size: 18,
                              color: Theme.of(context).primaryColor,
                            )
                          : Container(
                              child: Icon(
                                FontAwesomeIcons.solidWindowMinimize,
                                size: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                              transform: Matrix4.translationValues(0, -6, 0),
                            ),
              transform: object['object'].runtimeType == Field
                  ? Matrix4.translationValues(1, -1, 0)
                  : object['object'].runtimeType == Ctable
                      ? Matrix4.translationValues(1, -1, 0)
                      : Matrix4.translationValues(0, 0, 0),
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
