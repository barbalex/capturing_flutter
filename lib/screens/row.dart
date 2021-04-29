import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/models/table.dart';

class RowWidget extends StatefulWidget {
  @override
  _RowWidgetState createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
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
            // TODO: sort by what?
            .findAll(),
        isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
        isar.ctables.where().filter().isOptionsEqualTo(true).findAll()
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
            Ctable table = snapshot.data[1];
            print('row, table: $table');
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
            TextEditingController nameController = TextEditingController();
            nameController.text = row.id;

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Row of ${table.name}'),
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
                                isar.crows.put(row);
                                await isar.operations.put(
                                    Operation(table: 'rows')
                                        .setData(row.toMap()));
                              });
                              nameIsDirty.value = false;
                              if (idErrorText.value != '') {
                                idErrorText.value = '';
                              }
                            } catch (e) {
                              String errorText = e.toString();
                              if (errorText.contains('Unique index violated')) {
                                errorText = 'The name has to be unique';
                              }
                              idErrorText.value = errorText;
                            }
                          }
                        },
                        child: TextField(
                          controller: nameController,
                          onChanged: (value) async {
                            row.id = value;
                            nameIsDirty.value = true;
                          },
                          decoration: InputDecoration(
                            labelText: 'Id',
                            errorText: idErrorText.value != ''
                                ? idErrorText.value
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                            label: 'Create new',
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
