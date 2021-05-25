import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reorderables/reorderables.dart';
import 'package:capturing/store.dart';

class LabelFieldsWidget extends StatefulWidget {
  @override
  _LabelFieldsWidgetState createState() => _LabelFieldsWidgetState();
}

class _LabelFieldsWidgetState extends State<LabelFieldsWidget> {
  final Isar isar = Get.find<Isar>();

  final String tableId = activeTableId ?? '';

  final RxList<String> labelFields = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          isar.fields.where().filter().tableIdEqualTo(tableId).findAll(),
          isar.ctables.where().filter().idEqualTo(tableId).findFirst(),
        ],
      ),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            Get.snackbar(
              'Error accessing local storage',
              snapshot.error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            List<Field> fields = snapshot.data?[0] as List<Field>;
            Ctable table = snapshot.data?[1];
            labelFields.value = table.labelFields ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fields used to label rows',
                  style: TextStyle(
                    color: (Colors.grey.shade800),
                    fontSize: 13,
                  ),
                ),
                fields.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            style: ButtonStyle(),
                            onPressed: () async {
                              List fields = await isar.fields
                                  .where()
                                  .filter()
                                  .tableIdEqualTo(tableId)
                                  .findAll();
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx) {
                                  return MultiSelectBottomSheet(
                                    items: fields
                                        .map((e) => MultiSelectItem(
                                            e.name, e.name ?? '(no name)'))
                                        .toList(),
                                    initialValue:
                                        (table.labelFields ?? []).toList(),
                                    onConfirm: (values) async {
                                      labelFields.value = values
                                          .map((e) => e as String)
                                          .toList();
                                      table.labelFields = labelFields;
                                      await isar.writeTxn((_) async {
                                        isar.ctables.put(table);
                                        await isar.dbOperations.put(DbOperation(
                                                table: 'tables')
                                            .setData(table.toMapFromModel()));
                                      });
                                      setState(() {});
                                    },
                                    maxChildSize: 0.8,
                                    initialChildSize: 0.5,
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Select'),
                                Icon(Icons.arrow_downward),
                              ],
                            ),
                          ),
                          labelFields.length > 0
                              ? Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReorderableRow(
                                        onReorder:
                                            (int oldIndex, int newIndex) async {
                                          String labelField =
                                              labelFields.removeAt(oldIndex);
                                          labelFields.insert(
                                              newIndex, labelField);
                                          table.labelFields = labelFields;
                                          await isar.writeTxn((_) async {
                                            isar.ctables.put(table);
                                            await isar.dbOperations.put(
                                              DbOperation(table: 'tables')
                                                  .setData(
                                                table.toMapFromModel(),
                                              ),
                                            );
                                          });
                                        },
                                        children: labelFields
                                            .map(
                                              (e) => Chip(
                                                label: Text(e),
                                                key: ValueKey(e),
                                                backgroundColor: Colors.white,
                                                shadowColor: Theme.of(context)
                                                    .primaryColor,
                                                elevation: 1,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      Visibility(
                                        child: Text(
                                          'Dragg fields to order them.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        visible: labelFields.length > 1,
                                      )
                                    ],
                                  ),
                                )
                              : Text('No Field choosen as row label yet.'),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        child: Text(
                            'You need to create fields before you can select the fields to label rows with.'),
                      ),
              ],
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
