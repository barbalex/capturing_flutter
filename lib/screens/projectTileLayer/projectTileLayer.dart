import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/screens/projectTileLayer/textField.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_debounce/easy_debounce.dart';

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
        FormBuilderRangeSlider(
          name: 'zoom',
          initialValue: RangeValues(
              projectTileLayer.minZoom ?? 0, projectTileLayer.maxZoom ?? 25),
          onChanged: (RangeValues? value) {
            EasyDebounce.debounce('layerZoomRange', Duration(milliseconds: 200),
                () {
              if (value == null) return;
              if (value.start == projectTileLayer.minZoom &&
                  value.end == projectTileLayer.maxZoom) return;
              projectTileLayer.minZoom = value.start;
              projectTileLayer.maxZoom = value.end;
              projectTileLayer.save();
            });
          },
          min: 0,
          max: 25,
          divisions: 25,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColorLight,
          decoration: InputDecoration(
            labelText: 'Visible in zoom range',
          ),
        ),
        FormBuilderSlider(
          name: 'opacity',
          onChanged: (double? val) {
            EasyDebounce.debounce('layerZoomRange', Duration(milliseconds: 200),
                () {
              if (val == null) return;
              if (val == projectTileLayer.opacity) return;
              projectTileLayer.opacity = val;
              projectTileLayer.save();
            });
          },
          min: 0.0,
          max: 1.0,
          initialValue: 1.0,
          divisions: 20,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColorLight,
          decoration: InputDecoration(
            labelText: 'Opacity',
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Layer Types (use one):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          margin: EdgeInsetsGeometry.lerp(
            EdgeInsets.zero,
            EdgeInsets.zero,
            0,
          ),
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              iconPadding: EdgeInsets.all(15),
              iconSize: 30,
            ),
            header: ListTile(
              title: Text(
                'WMS (Web Map Service)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    label: 'Base url',
                    val: projectTileLayer.wmsBaseUrl,
                    save: (val) {
                      projectTileLayer.wmsBaseUrl = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  TextWidget(
                    label: 'Format',
                    val: projectTileLayer.wmsFormat,
                    save: (val) {
                      projectTileLayer.wmsFormat = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  TextWidget(
                    label: 'Layers (if multiple: separate by colon)',
                    val: projectTileLayer.wmsLayers?.join(', ') ?? '',
                    save: (val) {
                      projectTileLayer.wmsLayers = val?.split(', ');
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  // TODO: add wmsParameters (object)
                  TextWidget(
                    label: 'Request',
                    val: projectTileLayer.wmsRequest,
                    save: (val) {
                      projectTileLayer.wmsRequest = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  TextWidget(
                    label: 'Service',
                    val: projectTileLayer.wmsService,
                    save: (val) {
                      projectTileLayer.wmsService = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  TextWidget(
                    label: 'Styles',
                    val: projectTileLayer.wmsStyles?.join(', ') ?? '',
                    save: (val) {
                      projectTileLayer.wmsStyles = val?.split(', ');
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  FormBuilderCheckbox(
                    name: 'wmsTransparent',
                    title: Text('Transparent'),
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
                    label: 'Version',
                    val: projectTileLayer.wmsVersion,
                    save: (val) {
                      projectTileLayer.wmsVersion = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Card(
          margin: EdgeInsetsGeometry.lerp(
            EdgeInsets.zero,
            EdgeInsets.zero,
            0,
          ),
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              iconPadding: EdgeInsets.all(15),
              iconSize: 30,
            ),
            header: ListTile(
              title: Text(
                'URL template',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
