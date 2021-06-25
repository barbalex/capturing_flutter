import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/screens/projectTileLayer/textField.dart';

class ProjectTileLayerWidget extends StatefulWidget {
  final ProjectTileLayer? projectTileLayer;

  ProjectTileLayerWidget({required this.projectTileLayer});

  @override
  _ProjectTileLayerWidgetState createState() => _ProjectTileLayerWidgetState();
}

class _ProjectTileLayerWidgetState extends State<ProjectTileLayerWidget> {
  final Isar isar = Get.find<Isar>();

  final RxBool labelIsDirty = false.obs;
  final RxString labelErrorText = ''.obs;

  @override
  Widget build(BuildContext context) {
    ProjectTileLayer projectTileLayer =
        widget.projectTileLayer as ProjectTileLayer;
    print('subdomains: ${projectTileLayer.subdomains}');

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 20, right: 20),
      children: <Widget>[
        TextWidget(
          label: 'Label',
          val: projectTileLayer.getLabel(),
          save: (val) async {
            projectTileLayer.label = val;
            await projectTileLayer.save();
            return;
          },
        ),
        TextWidget(
          label: 'URL template',
          val: projectTileLayer.urlTemplate,
          save: (val) async {
            projectTileLayer.urlTemplate = val;
            await projectTileLayer.save();
            return;
          },
          maxLines: 1,
        ),
        TextWidget(
          label: 'Subdomains',
          val: projectTileLayer.subdomains?.join(', ') ?? '',
          save: (val) async {
            projectTileLayer.subdomains = val?.split(', ');
            await projectTileLayer.save();
            return;
          },
        ),
      ],
    );
  }
}
