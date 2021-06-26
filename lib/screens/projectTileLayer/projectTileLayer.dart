import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/screens/projectTileLayer/textField.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
          save: (val) {
            projectTileLayer.label = val;
            projectTileLayer.save();
          },
        ),
        TextWidget(
          label: 'URL template',
          val: projectTileLayer.urlTemplate,
          save: (val) {
            projectTileLayer.urlTemplate = val;
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        TextWidget(
          label: 'Subdomains',
          val: projectTileLayer.subdomains?.join(', ') ?? '',
          save: (val) {
            projectTileLayer.subdomains = val?.split(', ');
            projectTileLayer.save();
          },
        ),
        TextWidget(
          label: 'Max zoom',
          val: projectTileLayer.maxZoom,
          save: (val) {
            projectTileLayer.maxZoom = val != null ? double.parse(val) : val;
            projectTileLayer.save();
          },
          maxLines: 1,
          type: 'decimal',
        ),
        TextWidget(
          label: 'Min zoom',
          val: projectTileLayer.minZoom,
          save: (val) {
            projectTileLayer.minZoom = val != null ? double.parse(val) : val;
            projectTileLayer.save();
          },
          maxLines: 1,
          type: 'decimal',
        ),
        TextWidget(
          label: 'Opacity',
          val: projectTileLayer.opacity,
          save: (val) {
            projectTileLayer.opacity = val != null ? double.parse(val) : val;
            projectTileLayer.save();
          },
          maxLines: 1,
          type: 'decimal',
        ),
        TextWidget(
          label: 'WMS base url',
          val: projectTileLayer.wmsBaseUrl,
          save: (val) {
            projectTileLayer.wmsBaseUrl = val;
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        TextWidget(
          label: 'WMS format',
          val: projectTileLayer.wmsFormat,
          save: (val) {
            projectTileLayer.wmsFormat = val;
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        TextWidget(
          label: 'WMS layers',
          val: projectTileLayer.wmsLayers?.join(', ') ?? '',
          save: (val) {
            projectTileLayer.wmsLayers = val?.split(', ');
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        // TODO: add wmsParameters (object)
        TextWidget(
          label: 'WMS request',
          val: projectTileLayer.wmsRequest,
          save: (val) {
            projectTileLayer.wmsRequest = val;
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        TextWidget(
          label: 'WMS service',
          val: projectTileLayer.wmsService,
          save: (val) {
            projectTileLayer.wmsService = val;
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        TextWidget(
          label: 'WMS styles',
          val: projectTileLayer.wmsStyles?.join(', ') ?? '',
          save: (val) {
            projectTileLayer.wmsStyles = val?.split(', ');
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
        FormBuilderCheckbox(
          name: 'wmsTransparent',
          title: Text('WMS transparent'),
          onChanged: (bool? val) async {
            projectTileLayer.wmsTransparent = val;
            projectTileLayer.save();
            setState(() {});
          },
          // need to set false for null!
          initialValue: projectTileLayer.wmsTransparent ?? false,
          tristate: false,
        ),
        TextWidget(
          label: 'WMS version',
          val: projectTileLayer.wmsVersion,
          save: (val) {
            projectTileLayer.wmsVersion = val;
            projectTileLayer.save();
          },
          maxLines: 1,
        ),
      ],
    );
  }
}
