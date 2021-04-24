import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/components/formTitle.dart';

class TableWidget extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final RxBool dirty = false.obs;
  final RxBool nameIsDirty = false.obs;
  final RxBool labelIsDirty = false.obs;
  final RxString nameErrorText = ''.obs;
  final RxString labelErrorText = ''.obs;
  final RxInt bottomBarIndex = 0.obs;
  final RxBool bottomBarInactive = true.obs;
  final String projectId = Get.parameters['projectId'] ?? '0';
  final String id = Get.parameters['tableId'] ?? '0';

  @override
  Widget build(BuildContext context) {
    //print('table, id: $id');
    return FutureBuilder(
      future: isar.ctables
          .where()
          .filter()
          .deletedEqualTo(false)
          .projectIdEqualTo(projectId)
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
            List<Ctable> tables = snapshot.data;
            Ctable table = tables.where((p) => p.id == id).first;
            int ownIndex = tables.indexOf(table);
            bool existsNextTable = tables.length > ownIndex + 1;
            Ctable? nextTable = existsNextTable ? tables[ownIndex + 1] : null;
            bool existsPreviousTable = ownIndex > 0;
            Ctable? previousTable =
                existsPreviousTable ? tables[ownIndex - 1] : null;
            var nameTxt = TextEditingController();
            nameTxt.text = table.name ?? '';
            var labelTxt = TextEditingController();
            labelTxt.text = table.label ?? '';

            return Scaffold(
              appBar: AppBar(
                title: FormTitle(title: 'Table'),
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
                                isar.ctables.put(table);
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
                            table.name = value;
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
                    Obx(() => Focus(
                          onFocusChange: (hasFocus) async {
                            if (!hasFocus && labelIsDirty.value == true) {
                              try {
                                await isar.writeTxn((_) async {
                                  isar.ctables.put(table);
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
                        )),
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
                        label: 'Up to List',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.arrow_back,
                          color: existsPreviousTable
                              ? Colors.white
                              : Colors.purple.shade800,
                        ),
                        label: 'Previous',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: existsNextTable
                              ? Colors.white
                              : Colors.purple.shade800,
                        ),
                        label: 'Next',
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
                          Get.toNamed('/tables');
                          break;
                        case 2:
                          {
                            if (!existsPreviousTable) {
                              Get.snackbar(
                                'First Table reached',
                                'There is no previous',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              break;
                            }
                            Get.toNamed(
                                '/projects/$projectId/tables/${previousTable?.id}');
                            break;
                          }
                        case 3:
                          {
                            if (!existsNextTable) {
                              Get.snackbar(
                                'Last Table reached',
                                'There is no next',
                                snackPosition: SnackPosition.BOTTOM,
                              );
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
