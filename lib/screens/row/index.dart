import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/screens/row/text.dart';
import 'package:capturing/screens/row/date.dart';

class RowWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String tableId = Get.parameters['tableId'] ?? '0';
  final String id = Get.parameters['rowId'] ?? '0';
  final RxBool nameIsDirty = false.obs;
  final RxString idErrorText = ''.obs;
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        isar.crows
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(tableId)
            .findAll(),
        isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
        isar.ctables
            .where()
            .filter()
            .isOptionsEqualTo(true)
            .and()
            .deletedEqualTo(false)
            .findAll(),
        isar.fields
            .where()
            .filter()
            .tableIdEqualTo(tableId)
            .and()
            .deletedEqualTo(false)
            .findAll(),
      ]).then((value) async {
        //List<Crow> rows = value[0] as List<Crow>;
        //Crow row = rows.where((p) => p.id == id).first;
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
            List<Field> fields = snapshot.data[3];
            //print('RowWidget, fields: ${fields.map((e) => e.name)}');
            Ctable table = snapshot.data[1];
            List<Crow> rows = snapshot.data[0];
            Crow? row = rows.where((p) => p.id == id).first;
            //List<Ctable> optionTables = snapshot.data[2];
            // List<String> optionTableValues = [
            //   '(no value)',
            //   ...optionTables.map((e) => e.name ?? '')
            // ].toList();

            int ownIndex = rows.indexOf(row);
            bool existsNextRow = rows.length > ownIndex + 1;
            Crow? nextRow = existsNextRow ? rows[ownIndex + 1] : null;
            bool existsPreviousRow = ownIndex > 0;
            Crow? previousRow = existsPreviousRow ? rows[ownIndex - 1] : null;

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Row of ${table.name}'),
              ),
              body: Center(
                child: Focus(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    children: fields.map((field) {
                      // TODO: pick correct widget depending on row.widgetType
                      // Markdown: https://pub.dev/packages/flutter_markdown
                      // Quill: https://pub.dev/packages/flutter_quill
                      // https://api.flutter.dev/flutter/material/Switch-class.html
                      // https://api.flutter.dev/flutter/material/Checkbox-class.html
                      // https://api.flutter.dev/flutter/material/Radio-class.html
                      // https://api.flutter.dev/flutter/material/showDatePicker.html
                      // https://api.flutter.dev/flutter/material/Slider-class.html
                      //print('RowWidget, widgetType: ${field.widgetType}');
                      switch (field.widgetType) {
                        case 'text':
                          return TextWidget(
                              table: table, row: row, field: field);
                        case 'text-area':
                          return TextWidget(
                            table: table,
                            row: row,
                            field: field,
                            maxLines: null,
                          );
                        case 'date-chooser':
                          return DateWidget(
                            table: table,
                            row: row,
                            field: field,
                          );
                        default:
                          return TextWidget(
                            table: table,
                            row: row,
                            field: field,
                            maxLines: null,
                          );
                      }
                    }).toList(),
                  ),
                ),
              ),
              bottomNavigationBar: Obx(
                () => BottomNavigationBar(
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
                    existsPreviousRow
                        ? BottomNavigationBarItem(
                            icon: Icon(Icons.arrow_back),
                            label: 'Previous',
                          )
                        : BottomNavigationBarItem(
                            icon: Icon(Icons.add),
                            label: 'New',
                          ),
                    existsNextRow
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
                            '/projects/${projectId}/tables/${tableId}/rows');
                        break;
                      case 2:
                        {
                          if (!existsPreviousRow) {
                            Crow newRow = Crow();
                            await newRow.create();
                            Get.toNamed(
                                '/projects/${projectId}/tables/${tableId}/rows/${newRow.id}');
                            break;
                          }
                          Get.toNamed(
                              '/projects/${projectId}/tables/${tableId}/rows/${previousRow?.id}');
                          break;
                        }
                      case 3:
                        {
                          if (!existsNextRow) {
                            Crow newRow = Crow();
                            await newRow.create();
                            Get.toNamed(
                                '/projects/${projectId}/tables/${tableId}/rows/${newRow.id}');
                            break;
                          }
                          Get.toNamed(
                              '/projects/${projectId}/tables/${tableId}/rows/${nextRow?.id}');
                          break;
                        }
                    }
                  },
                ),
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
