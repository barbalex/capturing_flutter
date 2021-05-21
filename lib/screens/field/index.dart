import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
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

  final RxInt bottomBarIndex = 0.obs;

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
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Field> fields = snapshot.data[0];
            Field? field = fields.where((p) => p.id == id).first;
            Ctable table = snapshot.data[1];

            int ownIndex = fields.indexOf(field);
            bool existsNextField = fields.length > ownIndex + 1;
            Field? nextField = existsNextField ? fields[ownIndex + 1] : null;
            bool existsPreviousField = ownIndex > 0;
            Field? previousField =
                existsPreviousField ? fields[ownIndex - 1] : null;

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
