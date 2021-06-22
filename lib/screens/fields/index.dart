import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/fields/list.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/utils/getActiveUserRole.dart';

class FieldsListContainer extends StatefulWidget {
  @override
  _FieldsListContainerState createState() => _FieldsListContainerState();
}

class _FieldsListContainerState extends State<FieldsListContainer> {
  final String projectId = activeProjectId ?? '';
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;

  final Isar isar = Get.find<Isar>();

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    ever(editingProject, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Map',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.arrow_upward,
        ),
        label: 'Table list',
      ),
    ];
    if (editingProject.value == projectId) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
          ),
          label: 'Table',
        ),
      );
    }
    String? activeUserRole = getActiveUserRole(projectId);
    bool mayEditStructure =
        ['project_manager', 'account_manager'].contains(activeUserRole);

    Ctable? table =
        isar.ctables.where().filter().idEqualTo(tableId ?? '').findFirstSync();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // only show actions if user is account_admin
          mayEditStructure
              ? Obx(
                  () => IconButton(
                    icon: Icon(
                      Icons.build,
                    ),
                    onPressed: () {
                      editingProject.value =
                          editingProject.value == projectId ? '' : projectId;
                    },
                    tooltip: editingProject.value == projectId
                        ? 'Editing data structure. Click to stop.'
                        : 'Edit data structure',
                    color: editingProject.value == projectId
                        ? Theme.of(context).accentColor
                        : Colors.white,
                  ),
                )
              : Container(),
        ],
        title: FormTitle(title: 'Fields of ${table?.getLabel()}'),
      ),
      body: FieldList(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: bottomNavigationBarItems,
        currentIndex: 0,
        onTap: (index) async {
          switch (index) {
            case 0:
              url.value = [...url, 'map/'];
              break;
            case 1:
              url.value = ['/projects/', projectId, '/tables/'];
              break;
            case 2:
              if (tableId == null) break;
              url.value = ['/projects/', projectId, '/tables/', tableId ?? ''];
              break;
          }
        },
      ),
      // TODO: only show action button if user is account_admin
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          if (tableId == null) return;
          Field newField = Field(tableId: tableId);
          await newField.create();
          url.value = [
            '/projects/',
            projectId,
            '/tables/',
            tableId ?? '',
            '/fields/',
            newField.id
          ];
        },
        tooltip: 'Add Field',
      ),
    );
  }
}
