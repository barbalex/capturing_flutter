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

  final RxList<String> labelFields = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    List<Field?> fields = isar.fields
        .where()
        .filter()
        .tableIdEqualTo(activeTableId)
        .findAllSync();
    Ctable? table = isar.ctables
        .where()
        .filter()
        .idEqualTo(activeTableId ?? '')
        .findFirstSync();
    labelFields.value = table?.labelFields ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fields used to label rows'.tr,
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
                    onPressed: () {
                      List<Field> fields = isar.fields
                          .where()
                          .tableIdEqualTo(activeTableId)
                          .findAllSync();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return MultiSelectBottomSheet(
                            items: fields
                                .map(
                                  (e) => MultiSelectItem(
                                    e.id,
                                    e.getLabel(),
                                  ),
                                )
                                .toList(),
                            initialValue: (table?.labelFields ?? []).toList(),
                            onConfirm: (values) async {
                              if (table == null) return;
                              labelFields.value =
                                  values.map((e) => e as String).toList();
                              table.labelFields = labelFields;
                              await isar.writeTxn((_) async {
                                isar.ctables.put(table);
                                await isar.dbOperations.put(
                                    DbOperation(table: 'tables')
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
                        Text('Select'.tr),
                        Icon(Icons.arrow_downward),
                      ],
                    ),
                  ),
                  labelFields.length > 0
                      ? Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReorderableRow(
                                onReorder: (int oldIndex, int newIndex) async {
                                  if (table == null) return;
                                  String labelField =
                                      labelFields.removeAt(oldIndex);
                                  labelFields.insert(newIndex, labelField);
                                  table.labelFields = labelFields;
                                  await isar.writeTxn((_) async {
                                    isar.ctables.put(table);
                                    await isar.dbOperations.put(
                                      DbOperation(table: 'tables').setData(
                                        table.toMapFromModel(),
                                      ),
                                    );
                                  });
                                },
                                children: labelFields.map(
                                  (e) {
                                    Field? field = isar.fields
                                        .where()
                                        .idEqualTo(e)
                                        .findFirstSync();
                                    return Chip(
                                      label: Text(
                                        field?.getLabel() ??
                                            'no field found'.tr,
                                      ),
                                      key: ValueKey(e),
                                      backgroundColor: Colors.white,
                                      shadowColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 1,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.padded,
                                      deleteIcon: Icon(Icons.highlight_off),
                                      deleteIconColor: Colors.red,
                                      onDeleted: () async {
                                        print('TODO: delete');
                                        if (table == null) return;
                                        labelFields.removeWhere((f) => f == e);
                                        table.labelFields = labelFields;
                                        await isar.writeTxn((_) async {
                                          isar.ctables.put(table);
                                          await isar.dbOperations.put(
                                              DbOperation(table: 'tables')
                                                  .setData(
                                                      table.toMapFromModel()));
                                        });
                                        setState(() {});
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                              Visibility(
                                child: Text(
                                  'Dragg fields to order them.'.tr,
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
                      : Text('No Field choosen as row label yet.'.tr),
                ],
              )
            : Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: Text(
                    'You need to create fields before you can select the fields to label rows with.'
                        .tr),
              ),
      ],
    );
  }
}
