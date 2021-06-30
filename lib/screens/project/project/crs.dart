import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/store.dart';
import 'package:get/get.dart';

class CrsWidget extends StatelessWidget {
  final Project project;

  CrsWidget({required this.project});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FormBuilderDropdown(
        name: 'crs',
        onChanged: (int? crs) {
          project.crs = crs;
          project.save();
        },
        decoration:
            InputDecoration(labelText: 'CRS (Coordinate Reference System)'),
        initialValue: project.crs,
        items: crsList.value
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: Text(value.toString()),
              ),
            )
            .toList(),
        allowClear: true,
      ),
    );
  }
}
