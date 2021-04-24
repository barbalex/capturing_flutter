import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/tablesList.dart';
import 'package:capturing/store.dart';
import 'package:capturing/components/formTitle.dart';

class Tables extends StatelessWidget {
  final String projectId = Get.parameters['projectId'] ?? '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: only show actions if user is account_admin
        actions: <Widget>[
          Obx(
            () => IconButton(
              icon: Icon(
                Icons.build,
              ),
              onPressed: () {
                editingStructure.value = !editingStructure.value;
              },
              tooltip: editingStructure.value
                  ? 'Editing data structure. Click to stop.'
                  : 'Edit data structure',
              color: editingStructure.value
                  ? Theme.of(context).accentColor
                  : Colors.white,
            ),
          ),
        ],
        title: FormTitle(title: 'Tables'),
      ),
      body: TableList(),
      // TODO: only show action button if user is account_admin
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          Ctable newTable = Ctable(projectId: projectId);
          await newTable.create();
          Get.toNamed('/projects/${projectId}/tables/${newTable.id}');
        },
      ),
    );
  }
}