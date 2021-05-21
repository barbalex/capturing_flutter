import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:capturing/screens/field/standardValue/index.dart';
import 'package:capturing/screens/field/field.dart';

class FieldViewWidget extends StatefulWidget {
  @override
  _FieldViewWidgetState createState() => _FieldViewWidgetState();
}

class _FieldViewWidgetState extends State<FieldViewWidget> {
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

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Field of ${table.name}'),
              ),
              body: FieldWidget(
                field: field,
                fields: fields,
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
