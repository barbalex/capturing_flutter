import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/widgetsForField.dart';

class FieldWidget extends StatefulWidget {
  @override
  _FieldWidgetState createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String id = Get.parameters['fieldId'] ?? '0';
  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;
  final RxBool isInternalId = false.obs;
  final RxString fieldType = ''.obs;
  final RxString widgetType = ''.obs;
  final RxString optionsTableName = ''.obs;
  final RxBool widgetNeedsOptions = false.obs;
  final RxList<WidgetsForField> widgetsForField = <WidgetsForField>[].obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isar.fields
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            .sortByName()
            .findAll(),
        isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
        isar.fieldTypes
            .where()
            .filter()
            .deletedEqualTo(false)
            .sortBySort()
            .findAll(),
        isar.ctables.where().filter().not().optionTypeEqualTo(null).findAll()
      ]).then((value) async {
        List<Field> fields = value[0] as List<Field>;
        Field field = fields.where((p) => p.id == id).first;
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
            Ctable table = snapshot.data[1];
            List<Field> fields = snapshot.data[0];
            Field? field = fields.where((p) => p.id == id).first;
            List<Ctable> optionTables = snapshot.data[3];
            List<String> optionTableValues = [
              '(no value)',
              ...optionTables.map((e) => e.name ?? '')
            ].toList();
            List<FieldType> fieldTypes = snapshot.data[2];
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

            int ownIndex = fields.indexOf(field);
            bool existsNextField = fields.length > ownIndex + 1;
            Field? nextField = existsNextField ? fields[ownIndex + 1] : null;
            bool existsPreviousField = ownIndex > 0;
            Field? previousField =
                existsPreviousField ? fields[ownIndex - 1] : null;
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

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Field of ${table.name}'),
              ),
              body: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  children: <Widget>[
                    Obx(
                      () => Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus && nameIsDirty.value == true) {
                            // set label too if is empty
                            if (field.label == null) {
                              field.label = field.name;
                            }
                            try {
                              await isar.writeTxn((_) async {
                                isar.fields.put(field);
                                await isar.operations.put(
                                    Operation(table: 'fields')
                                        .setData(field.toMap()));
                              });
                              nameIsDirty.value = false;
                              if (nameErrorText.value != '') {
                                nameErrorText.value = '';
                              }
                            } catch (e) {
                              String errorText = e.toString();
                              if (errorText.contains('Unique index violated')) {
                                errorText = 'The name has to be unique';
                              }
                              nameErrorText.value = errorText;
                            }
                          }
                        },
                        child: TextField(
                          controller: nameController,
                          onChanged: (value) async {
                            field.name = value;
                            nameIsDirty.value = true;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            errorText: nameErrorText.value != ''
                                ? nameErrorText.value
                                : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Obx(
                      () => Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus && labelIsDirty.value == true) {
                            try {
                              await isar.writeTxn((_) async {
                                isar.fields.put(field);
                                await isar.operations.put(
                                    Operation(table: 'fields')
                                        .setData(field.toMap()));
                              });
                              labelIsDirty.value = false;
                              if (labelErrorText.value != '') {
                                labelErrorText.value = '';
                              }
                            } catch (e) {
                              labelErrorText.value = e.toString();
                            }
                          }
                        },
                        child: TextField(
                          controller: labelController,
                          onChanged: (value) async {
                            field.label = value;
                            labelIsDirty.value = true;
                          },
                          decoration: InputDecoration(
                            labelText: 'Label',
                            errorText: labelErrorText.value != ''
                                ? labelErrorText.value
                                : null,
                          ),
                        ),
                      ),
                    ),
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
                          await isar.writeTxn((_) async {
                            isar.fields.put(field);
                            await isar.operations.put(Operation(table: 'fields')
                                .setData(field.toMap()));
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
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
                            String widgetTypeValue =
                                widgetsForFieldValues.first;
                            widgetType.value = widgetTypeValue;
                            field.widgetType = widgetTypeValue;
                          }
                          // if a widgetType is choosen but not in the list
                          // remove it
                          if (!widgetsForFieldValues
                              .contains(widgetType.value)) {
                            widgetType.value = '';
                            field.widgetType = null;
                          }
                          await isar.writeTxn((_) async {
                            isar.fields.put(field);
                            await isar.operations.put(
                              Operation(table: 'fields').setData(field.toMap()),
                            );
                          });
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
                              value: widgetType.value == ''
                                  ? null
                                  : widgetType.value,
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
                                await isar.writeTxn((_) async {
                                  await isar.fields.put(field);
                                  await isar.operations.put(
                                    Operation(table: 'fields')
                                        .setData(field.toMap()),
                                  );
                                });
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
                                  await isar.writeTxn((_) async {
                                    await isar.fields.put(field);
                                    await isar.operations.put(
                                      Operation(table: 'fields')
                                          .setData(field.toMap()),
                                    );
                                  });
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
                                await isar.writeTxn((_) async {
                                  await isar.fields.put(field);
                                  await isar.operations.put(
                                    Operation(table: 'fields')
                                        .setData(field.toMap()),
                                  );
                                });
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
                          )
                        ],
                      ),
                      visible: showOptionsTable,
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Obx(() => BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map),
                        label: 'Map',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.arrow_upward,
                        ),
                        label: 'List',
                      ),
                      existsPreviousField
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_back),
                              label: 'Previous',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'New',
                            ),
                      existsNextField
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_forward),
                              label: 'Next',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'New',
                            ),
                    ],
                    currentIndex: bottomBarIndex.value,
                    onTap: (index) async {
                      bottomBarIndex.value = index;
                      switch (index) {
                        case 0:
                          print('TODO:');
                          break;
                        case 1:
                          Get.toNamed(
                              '/projects/${projectId}/tables/${tableId}/fields');
                          break;
                        case 2:
                          {
                            if (!existsPreviousField) {
                              Field newField = Field();
                              await newField.create();
                              Get.toNamed(
                                  '/projects/${projectId}/tables/${tableId}/fields/${newField.id}');
                              break;
                            }
                            Get.toNamed(
                                '/projects/${projectId}/tables/${tableId}/fields/${previousField?.id}');
                            break;
                          }
                        case 3:
                          {
                            if (!existsNextField) {
                              Field newField = Field();
                              await newField.create();
                              Get.toNamed(
                                  '/projects/${projectId}/tables/${tableId}/fields/${newField.id}');
                              break;
                            }
                            Get.toNamed(
                                '/projects/${projectId}/tables/${tableId}/fields/${nextField?.id}');
                            break;
                          }
                      }
                    },
                  )),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
