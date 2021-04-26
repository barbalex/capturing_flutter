import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/models/project.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:capturing/models/operation.dart';

class TableWidget extends StatefulWidget {
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Isar isar = Get.find<Isar>();
  final RxBool dirty = false.obs;
  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;
  final RxBool isOptions = false.obs;
  final RxString parentId = ''.obs;

  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;

  final String projectId = Get.parameters['projectId'] ?? '0';
  final String id = Get.parameters['tableId'] ?? '0';

  final RxString parentTableName = ''.obs;

  @override
  Widget build(BuildContext context) {
    //print('table, id: $id');
    return FutureBuilder(
      future: Future.wait([
        isar.ctables
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .projectIdEqualTo(projectId)
            .sortByName()
            .findAll(),
        isar.projects.where().filter().idEqualTo(projectId).findFirst(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Project project = snapshot.data?[1];
            List<Ctable> tables = snapshot.data?[0] ?? [];
            Ctable table = tables.where((p) => p.id == id).first;
            int ownIndex = tables.indexOf(table);
            bool existsNextTable = tables.length > ownIndex + 1;
            Ctable? nextTable = existsNextTable ? tables[ownIndex + 1] : null;
            bool existsPreviousTable = ownIndex > 0;
            Ctable? previousTable =
                existsPreviousTable ? tables[ownIndex - 1] : null;
            TextEditingController nameController = TextEditingController();
            nameController.text = table.name ?? '';
            TextEditingController labelController = TextEditingController();
            labelController.text = table.label ?? '';
            isOptions.value = table.isOptions ?? false;
            parentId.value = table.parentId ?? '';
            TextEditingController parentController = TextEditingController();
            print(
                'parentId: ${table.parentId}, table.parent.value: ${table.parent.value}, table.parent.value?.name: ${table.parent.value?.name}');
            fetchParent() async {
              Ctable? parentTable = await isar.ctables
                  .where()
                  .filter()
                  .idEqualTo(table.parentId ?? '')
                  .findFirst();
              parentTableName.value = parentTable?.name ?? '';
            }

            fetchParent();

            parentController.text = parentTableName.value;

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Table of ${project.name}'),
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
                                await isar.ctables.put(table);
                                await isar.operations.put(
                                    Operation(table: 'tables')
                                        .setData(table.toMap()));
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
                            table.name = value;
                            nameIsDirty.value = true;
                          },
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
                                await isar.ctables.put(table);
                                await isar.operations.put(
                                    Operation(table: 'tables')
                                        .setData(table.toMap()));
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
                            table.label = value;
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
                    Obx(
                      () => CheckboxListTile(
                        title: Text('Is an options list'),
                        value: isOptions.value,
                        onChanged: (val) async {
                          isOptions.value = val ?? false;
                          table.isOptions = val;
                          await isar.writeTxn((_) async {
                            isar.ctables.put(table);
                            await isar.operations.put(Operation(table: 'tables')
                                .setData(table.toMap()));
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: parentController,
                        decoration: InputDecoration(labelText: 'Parent table'),
                      ),
                      suggestionsCallback: (pattern) async => isar.ctables
                          .where()
                          .filter()
                          .not()
                          .idEqualTo(table.id)
                          .and()
                          .nameContains(pattern, caseSensitive: false)
                          .and()
                          .projectIdEqualTo(projectId)
                          .sortByName()
                          .findAll(),
                      itemBuilder: (context, Ctable table) {
                        return ListTile(
                          title: Text(table.name ?? ''),
                        );
                      },
                      onSuggestionSelected: (Ctable choosenTable) async {
                        parentId.value = choosenTable.id;
                        table.parentId = choosenTable.id;
                        print(
                            'new parentId: ${choosenTable.id}, table: $table, table.id: ${table.id}, table.parentId: ${table.parentId}');
                        await isar.writeTxn((_) async {
                          isar.ctables.put(table);
                          await isar.operations.put(Operation(table: 'tables')
                              .setData(table.toMap()));
                        });
                      },
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
                        label: 'Table list',
                      ),
                      existsPreviousTable
                          ? BottomNavigationBarItem(
                              icon: Icon(Icons.arrow_back),
                              label: 'Previous',
                            )
                          : BottomNavigationBarItem(
                              icon: Icon(Icons.add),
                              label: 'Create new',
                            ),
                      existsNextTable
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
                        label: 'Children',
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
                          Get.toNamed('/projects/$projectId/tables/');
                          break;
                        case 2:
                          {
                            if (!existsPreviousTable) {
                              Ctable newTable = Ctable(projectId: projectId);
                              await newTable.create();
                              Get.toNamed(
                                  '/projects/${projectId}/tables/${newTable.id}');
                              break;
                            }
                            Get.toNamed(
                                '/projects/$projectId/tables/${previousTable?.id}');
                            break;
                          }
                        case 3:
                          {
                            if (!existsNextTable) {
                              Ctable newTable = Ctable(projectId: projectId);
                              await newTable.create();
                              Get.toNamed(
                                  '/projects/${projectId}/tables/${newTable.id}');
                              break;
                            }
                            Get.toNamed(
                                '/projects/$projectId/tables/${nextTable?.id}');
                            break;
                          }
                        case 4:
                          print('TODO:');
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
