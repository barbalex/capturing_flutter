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

    String legendUrl =
        '${projectTileLayer.wmsBaseUrl}LAYERS=${projectTileLayer.wmsLayers?.join(',')}&SERVICE=${projectTileLayer.wmsService}&VERSION=${projectTileLayer.wmsVersion}&REQUEST=GetLegendGraphic&FORMAT=${projectTileLayer.wmsFormat}${projectTileLayer.wmsStyles != null ? '&STYLE=${projectTileLayer.wmsStyles}' : ''}&CRS=EPSG%3A2056&BBOX=2680000,1243000,2696931,1255698&WIDTH=800&HEIGHT=600';

    return ListView(
      shrinkWrap: true,
      //padding: EdgeInsets.only(left: 20, right: 20),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                label: 'Label'.tr,
                val: projectTileLayer.getLabel(),
                save: (val) {
                  projectTileLayer.label = val;
                  projectTileLayer.save();
                },
              ),
              FormBuilderRangeSlider(
                name: 'zoom',
                initialValue: RangeValues(projectTileLayer.minZoom ?? 0,
                    projectTileLayer.maxZoom ?? 25),
                onChanged: (RangeValues? value) {
                  EasyDebounce.debounce(
                      'layerZoomRange', Duration(milliseconds: 200), () {
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
                  labelText: 'Visible in Zoom Range'.tr,
                ),
              ),
              FormBuilderSlider(
                name: 'opacity',
                onChanged: (double? val) {
                  EasyDebounce.debounce(
                      'layerZoomRange', Duration(milliseconds: 200), () {
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
                  labelText: 'Opacity'.tr,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Layer Type (choose one):'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Card(
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
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    label: 'Base URL'.tr,
                    val: projectTileLayer.wmsBaseUrl,
                    save: (val) {
                      projectTileLayer.wmsBaseUrl = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  FormBuilderDropdown(
                    name: 'wmsVersion',
                    onChanged: (String? val) async {
                      projectTileLayer.wmsFormat = val;
                      projectTileLayer.save();
                    },
                    decoration: InputDecoration(labelText: 'Format'.tr),
                    initialValue: projectTileLayer.wmsFormat,
                    items: [
                      'image/cgm',
                      'image/gif',
                      'image/jpeg',
                      'image/png',
                      'image/png; mode=8bit',
                      'image/svg+xml',
                      'image/tiff',
                    ].map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    allowClear: true,
                  ),
                  TextWidget(
                    label: 'Layers (separate by semicolon, no space)'.tr,
                    val: projectTileLayer.wmsLayers?.join(',') ?? '',
                    save: (val) {
                      projectTileLayer.wmsLayers = val?.split(',');
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  // TODO: add wmsParameters (object)
                  TextWidget(
                    label: 'Request'.tr,
                    val: projectTileLayer.wmsRequest,
                    save: (val) {
                      projectTileLayer.wmsRequest = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  TextWidget(
                    label: 'Style'.tr,
                    val: projectTileLayer.wmsStyles?.join(',') ?? '',
                    save: (val) {
                      projectTileLayer.wmsStyles = val?.split(',');
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  FormBuilderCheckbox(
                    name: 'wmsTransparent',
                    title: Text('Transparent'.tr),
                    onChanged: (bool? val) async {
                      projectTileLayer.wmsTransparent = val;
                      projectTileLayer.save();
                      setState(() {});
                    },
                    // need to set false for null!
                    initialValue: projectTileLayer.wmsTransparent ?? false,
                    tristate: false,
                  ),
                  FormBuilderDropdown(
                    name: 'wmsVersion',
                    onChanged: (String? val) async {
                      projectTileLayer.wmsVersion = val;
                      projectTileLayer.save();
                    },
                    decoration: InputDecoration(labelText: 'Version'.tr),
                    initialValue: projectTileLayer.wmsVersion,
                    items: [
                      '1.3.0',
                      '1.1.1',
                      '1.1',
                      '1.0',
                      '0.9',
                      '0.1.0',
                      '0.0.3',
                    ].map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    allowClear: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    child: Text(
                      'Legend:'.tr,
                      style: TextStyle(
                        color: (Colors.grey.shade600),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  projectTileLayer.wmsBaseUrl != null
                      ? Image.network(
                          legendUrl,
                          errorBuilder: (context, error, stackTrace) => Text(
                              'no legend available with the provided information'),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Card(
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              iconPadding: EdgeInsets.all(15),
              iconSize: 30,
            ),
            header: ListTile(
              title: Text(
                'URL Template'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    label: 'URL Template'.tr,
                    val: projectTileLayer.urlTemplate,
                    save: (val) {
                      projectTileLayer.urlTemplate = val;
                      projectTileLayer.save();
                    },
                    maxLines: 1,
                  ),
                  TextWidget(
                    label: 'Subdomains'.tr,
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
