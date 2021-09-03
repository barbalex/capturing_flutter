import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/store.dart';

class FieldsFloatingActionButton extends StatelessWidget {
  final String projectId = activeProjectId ?? '';
  final String? tableId = url.length > 1 ? url[url.length - 2] : null;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.add,
        size: 40,
      ),
      onPressed: () async {
        if (tableId == null) return;
        Field newField = Field(tableId: tableId);
        await newField.create();
        url.value = newField.getUrl();
      },
      tooltip: 'Add Field'.tr,
    );
  }
}
