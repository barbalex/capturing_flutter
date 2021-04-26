import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/operation.dart';

class FieldWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String id = Get.parameters['fieldId'] ?? '0';
  final RxBool dirty = false.obs;
  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;
  final RxBool isInternalId = false.obs;

  @override
  Widget build(BuildContext context) {
    //print('field, id: $id');
    return FutureBuilder(
      future: isar.fields
          .where()
          .filter()
          .deletedEqualTo(false)
          .sortByName()
          .findAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Field> fields = snapshot.data;
            Field field = fields.where((p) => p.id == id).first;
            int ownIndex = fields.indexOf(field);
            bool existsNextField = fields.length > ownIndex + 1;
            Field? nextField = existsNextField ? fields[ownIndex + 1] : null;
            bool existsPreviousField = ownIndex > 0;
            Field? previousField =
                existsPreviousField ? fields[ownIndex - 1] : null;
            var nameTxt = TextEditingController();
            nameTxt.text = field.name ?? '';
            var labelTxt = TextEditingController();
            labelTxt.text = field.label ?? '';
            isInternalId.value = field.isInternalId ?? false;

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Field'),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Obx(
                      () => Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus && nameIsDirty.value == true) {
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
                          controller: nameTxt,
                          onChanged: (value) async {
                            field.name = value;
                            nameIsDirty.value = true;
                          },
                          onEditingComplete: () => print('onEditingComplete'),
                          onSubmitted: (_) => print('onSubmitted'),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            errorText: nameErrorText.value != ''
                                ? nameErrorText.value
                                : null,
                          ),
                          //autofocus: true,
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
                          controller: labelTxt,
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
                        label: 'Field list',
                      ),
                      existsPreviousField
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_back),
                              label: 'Previous',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'Create new',
                            ),
                      existsNextField
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_forward),
                              label: 'Next',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'Create new',
                            ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.arrow_downward),
                        label: 'Rows',
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
                          Get.toNamed('/projects/${projectId}/tables/');
                          break;
                        case 2:
                          {
                            if (!existsPreviousField) {
                              Field newField = Field();
                              await newField.create();
                              Get.toNamed(
                                  '/projects/${projectId}/tables/${tableId}/${newField.id}');
                              break;
                            }
                            Get.toNamed(
                                '/projects/${projectId}/tables/${tableId}/${previousField?.id}');
                            break;
                          }
                        case 3:
                          {
                            if (!existsNextField) {
                              Field newField = Field();
                              await newField.create();
                              Get.toNamed(
                                  '/projects/${projectId}/tables/${tableId}/${newField.id}');
                              break;
                            }
                            Get.toNamed(
                                '/projects/${projectId}/tables/${tableId}/${nextField?.id}');
                            break;
                          }
                        case 4:
                          Get.toNamed('/projects/${projectId}/rows/');
                          break;
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
