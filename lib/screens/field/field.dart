import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/screens/field/standardValue/index.dart';
import 'package:capturing/components/nameLabel.dart';
import 'package:capturing/store.dart';

class FieldWidget extends StatefulWidget {
  final Field? field;

  FieldWidget({required this.field});

  @override
  _FieldWidgetState createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  final Isar isar = Get.find<Isar>();
  final String projectId = activeProjectId ?? '';
  final String tableId = activeTableId ?? '';

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

    return FutureBuilder(
      future: Future.wait([
        isar.fieldTypes
            .where()
            .filter()
            .deletedEqualTo(false)
            .sortBySort()
            .findAll(),
        isar.ctables.where().filter().not().optionTypeEqualTo(null).findAll()
      ]).then((value) async {
        optionsTableName.value = await isar.ctables
                .where()
                .filter()
                .idEqualTo(field.optionsTable ?? '')
                .nameProperty()
                .findFirst() ??
            '';
        widgetNeedsOptions.value = await isar.widgetTypes
                .where()
                .filter()
                .valueEqualTo(field.widgetType)
                .needsListProperty()
                .findFirst() ??
            false;
        widgetsForField.value = await isar.widgetsForFields
            .where()
            .filter()
            .fieldValueEqualTo(field.fieldType)
            .findAll();
        return value;
      }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Ctable> optionTables = snapshot.data[1];
            List<String> optionTableValues = [
              '(no value)',
              ...optionTables.map((e) => e.name ?? '')
            ].toList();
            List<FieldType> fieldTypes = snapshot.data[0];
            List<String> fieldTypeValues =
                fieldTypes.map((e) => e.value ?? '').toList();
            List<String> widgetTypeValues =
                widgetsForField.map((e) => e.widgetValue ?? '').toList();
            // IMPORTANT: need to add chosen widgetType to the list
            // if it is not in widgetTypeValues bad things happen!
            if (field.widgetType != null &&
                !widgetTypeValues.contains(field.widgetType)) {
              widgetTypeValues.add(field.widgetType ?? '');
            }

            TextEditingController nameController = TextEditingController();
            nameController.text = field.name ?? '';
            TextEditingController labelController = TextEditingController();
            labelController.text = field.label ?? '';
            isInternalId.value = field.isInternalId ?? false;
            TextEditingController fieldController = TextEditingController();
            fieldController.text = field.fieldType ?? '';
            fieldType.value = field.fieldType ?? '';
            TextEditingController widgetController = TextEditingController();
            widgetController.text = field.widgetType ?? '';
            widgetType.value = field.widgetType ?? '';
            TextEditingController optionsTableController =
                TextEditingController();
            optionsTableController.text = optionsTableName.value;
            bool showWidgetType = widgetsForField.length > 0;
            // only show if widget accepts list
            bool showOptionsTable =
                optionTables.length > 0 && widgetNeedsOptions.value;

            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              children: <Widget>[
                NameLabelWidget(dataset: field),
                SizedBox(
                  height: 8.0,
                ),
                Obx(
                  () => CheckboxListTile(
                    title: Text('Is an internal Id'),
                    value: isInternalId.value,
                    onChanged: (val) async {
                      isInternalId.value = val ?? false;
                      field.isInternalId = val;
                      await field.save();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                FormBuilderDropdown(
                  name: 'fieldType',
                  onChanged: (String? newValue) async {
                    fieldType.value = newValue ?? '';
                    field.fieldType = newValue;
                    // If only one widget Type exists for this field type, add it
                    List<WidgetsForField> widgetsForField = await isar
                        .widgetsForFields
                        .where()
                        .filter()
                        .fieldValueEqualTo(newValue)
                        .findAll();
                    List<String> widgetsForFieldValues = widgetsForField
                        .map((e) => e.widgetValue ?? '')
                        .toList();
                    if (widgetsForField.length == 1) {
                      String widgetTypeValue = widgetsForFieldValues.first;
                      widgetType.value = widgetTypeValue;
                      field.widgetType = widgetTypeValue;
                    }
                    // if a widgetType is choosen but not in the list
                    // remove it
                    if (!widgetsForFieldValues.contains(widgetType.value)) {
                      widgetType.value = '';
                      field.widgetType = null;
                    }
                    await field.save();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'Field Type',
                  ),
                  initialValue: field.fieldType,
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
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Field Type',
                  style: TextStyle(
                    color: (Colors.grey.shade800),
                    fontSize: 13,
                  ),
                ),
                Obx(
                  () => DropdownButton<String>(
                    value: fieldType.value == '' ? null : fieldType.value,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) async {
                      fieldType.value = newValue ?? '';
                      field.fieldType = newValue;
                      // If only one widget Type exists for this field type, add it
                      List<WidgetsForField> widgetsForField = await isar
                          .widgetsForFields
                          .where()
                          .filter()
                          .fieldValueEqualTo(newValue)
                          .findAll();
                      List<String> widgetsForFieldValues = widgetsForField
                          .map((e) => e.widgetValue ?? '')
                          .toList();
                      if (widgetsForField.length == 1) {
                        String widgetTypeValue = widgetsForFieldValues.first;
                        widgetType.value = widgetTypeValue;
                        field.widgetType = widgetTypeValue;
                      }
                      // if a widgetType is choosen but not in the list
                      // remove it
                      if (!widgetsForFieldValues.contains(widgetType.value)) {
                        widgetType.value = '';
                        field.widgetType = null;
                      }
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
                  ),
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Widget Type',
                        style: TextStyle(
                          color: (Colors.grey.shade800),
                          fontSize: 13,
                        ),
                      ),
                      Obx(
                        () => DropdownButton<String>(
                          value:
                              widgetType.value == '' ? null : widgetType.value,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
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
                        ),
                      ),
                    ],
                  ),
                  visible: showWidgetType,
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Options Table',
                        style: TextStyle(
                          color: (Colors.grey.shade800),
                          fontSize: 13,
                        ),
                      ),
                      Obx(
                        () => DropdownButton<String>(
                          value: optionsTableName.value == ''
                              ? null
                              : optionsTableName.value,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
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
        return CircularProgressIndicator();
      },
    );
  }
}
