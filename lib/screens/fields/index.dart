import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/screens/fields/list.dart';
import 'package:capturing/screens/fields/bottomNavBar.dart';
import 'package:capturing/screens/fields/floatingActionButton.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/utils/getActiveUserRole.dart';

class FieldsContainer extends StatefulWidget {
  @override
  _FieldsContainerState createState() => _FieldsContainerState();
}

class _FieldsContainerState extends State<FieldsContainer> {
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
                    icon: Icon(Icons.build),
                    onPressed: () {
                      editingProject.value =
                          editingProject.value == projectId ? '' : projectId;
                    },
                    tooltip: editingProject.value == projectId
                        ? 'Editing data structure. Click to stop.'.tr
                        : 'Edit data structure'.tr,
                    color: editingProject.value == projectId
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.white,
                  ),
                )
              : Container(),
        ],
        title: Text('${'Fields of'.tr} ${table?.getSingleLabel() ?? ''}'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FieldList(),
      bottomNavigationBar: FieldsBottomNavBar(),
      floatingActionButton: FieldsFloatingActionButton(),
    );
  }
}
