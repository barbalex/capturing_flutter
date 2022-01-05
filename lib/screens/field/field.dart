import 'package:capturing/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/widgetType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/screens/field/standardValue/index.dart';
import 'package:capturing/components/nameLabel.dart';
import 'package:collection/collection.dart';

class FieldWidget extends StatefulWidget {
  final Field? field;

  FieldWidget({required this.field});

  @override
  _FieldWidgetState createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  final Isar isar = Get.find<Isar>();

  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;
  final RxBool isInternalId = false.obs;
  final RxString fieldType = ''.obs;
  final RxString widgetType = ''.obs;
  final RxString optionsTableName = ''.obs;
  final RxBool widgetNeedsOptions = false.obs;
  final RxList<WidgetsForField> widgetsForField = <WidgetsForField>[].obs;

  @override
  Widget build(BuildContext context) {
    Field field = widget.field as Field;

    Future<void> setWidgetTypeForFieldType({String? fieldType}) async {
      // If only one widget Type exists for this field type, add it
      List<WidgetsForField> widgetsForField = await isar.widgetsForFields
          .where()
          .filter()
          .fieldValueEqualTo(fieldType)
          .findAll();
      List<String> widgetsForFieldValues =
          widgetsForField.map((e) => e.widgetValue ?? '').toList();
      if (widgetsForField.length > 0) {
        String? widgetTypeValue = widgetsForFieldValues.firstOrNull;
        if (widgetTypeValue != null) {
          widgetType.value = widgetTypeValue;
          field.widgetType = widgetTypeValue;
        }
      }
      // if a widgetType is choosen but not in the list
      // remove it
      if (!widgetsForFieldValues.contains(widgetType.value)) {
        widgetType.value = '';
        field.widgetType = null;
      }
    }

    List<Ctable> optionTables = isar.ctables
        .where()
        .filter()
        .projectIdEqualTo(activeProjectId)
        .and()
        .not()
        .nameIsNull()
        .and()
        .not()
        .optionTypeEqualTo(null)
        .findAllSync();
    List<String> optionTableValues = [
      '(no value)',
      ...optionTables.map((e) => e.name ?? '').toSet().toList()
    ].toList();
    print('fieldWidget, optionTableValues: $optionTableValues');
    print('fieldWidget, activeProjectId: $activeProjectId');
    List<FieldType> fieldTypes = isar.fieldTypes
        .where()
        .filter()
        .deletedEqualTo(false)
        .sortBySort()
        .findAllSync();
    List<String> fieldTypeValues =
        fieldTypes.map((e) => e.value ?? '').toList();

    optionsTableName.value = isar.ctables
            .where()
            .filter()
            .idEqualTo(field.optionsTable ?? '')
            .nameProperty()
            .findFirstSync() ??
        '';
    widgetNeedsOptions.value = isar.widgetTypes
            .where()
            .filter()
            .valueEqualTo(field.widgetType)
            .needsListProperty()
            .findFirstSync() ??
        false;
    widgetsForField.value = isar.widgetsForFields
        .where()
        .filter()
        .fieldValueEqualTo(field.fieldType)
        .findAllSync();

    List<String> widgetTypeValues =
        widgetsForField.map((e) => e.widgetValue ?? '').toList();
    // IMPORTANT: need to add chosen widgetType to the list
    // if it is not in widgetTypeValues bad things happen!
    if (field.widgetType != null &&
        !widgetTypeValues.contains(field.widgetType)) {
      widgetTypeValues.add(field.widgetType ?? '');
    }

    isInternalId.value = field.isInternalId ?? false;
    fieldType.value = field.fieldType ?? '';
    widgetType.value = field.widgetType ?? '';
    bool showWidgetType = widgetsForField.length > 0;
    // only show if widget accepts list
    bool showOptionsTable = optionTables.length > 0 && widgetNeedsOptions.value;

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 20, right: 20),
      children: <Widget>[
        NameLabelWidget(dataset: field),
        SizedBox(height: 8.0),
        Obx(
          () => CheckboxListTile(
            title: Text('Is an internal ID'.tr),
            value: isInternalId.value,
            onChanged: (val) async {
              isInternalId.value = val ?? false;
              field.isInternalId = val;
              await field.save();
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        SizedBox(height: 8.0),
        FormBuilderDropdown(
          key: Key(field.fieldType ?? ''),
          name: 'fieldType',
          decoration: InputDecoration(labelText: 'Field Type'.tr),
          initialValue: field.fieldType,
          onChanged: (String? newValue) async {
            fieldType.value = newValue ?? '';
            field.fieldType = newValue;
            await setWidgetTypeForFieldType(fieldType: newValue);
            await field.save();
            setState(() {});
          },
          items: fieldTypeValues
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          allowClear: true,
        ),
        Visibility(
          child: FormBuilderDropdown(
            key: Key(field.widgetType ?? ''),
            name: 'widgetType',
            decoration: InputDecoration(labelText: 'Widget Type'.tr),
            initialValue: field.widgetType,
            onChanged: (String? newValue) async {
              widgetType.value = newValue ?? '';
              field.widgetType = newValue;
              await field.save();
              setState(() {});
            },
            items: widgetTypeValues
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            allowClear: true,
          ),
          visible: showWidgetType,
        ),
        Visibility(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.0),
              Text(
                'Options Table'.tr,
                style: TextStyle(
                  color: (Colors.grey.shade800),
                  fontSize: 13,
                ),
              ),
              Obx(
                () => DropdownButton<String>(
                  value: optionTableValues.contains(optionsTableName.value)
                      ? optionsTableName.value
                      : null,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) async {
                    if (newValue == '(no  value)') {
                      optionsTableName.value = '';
                      field.optionsTable = null;
                      await field.save();
                      return;
                    }
                    String? tableId = await isar.ctables
                        .where()
                        .filter()
                        .nameEqualTo(newValue)
                        .idProperty()
                        .findFirst();
                    optionsTableName.value = newValue ?? '';
                    field.optionsTable = tableId;
                    // print(
                    //     'field, onChangedOptionsTable: newValue: $newValue, tableId: $tableId');
                    // print(
                    //     'field, onChangedOptionsTable: field: ${field.toMap()}');
                    await field.save();
                  },
                  items: optionTableValues
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          visible: showOptionsTable,
        ),
        StandardValueWidget(field: field),
      ],
    );
  }
}
