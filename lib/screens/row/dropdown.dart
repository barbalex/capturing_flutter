import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropdownWidget extends StatefulWidget {
  final Crow row;
  final Field field;

  DropdownWidget({
    required this.row,
    required this.field,
  });

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  final Isar isar = Get.find<Isar>();
  final RxString errorText = ''.obs;

  @override
  void initState() {
    super.initState();

    ever(errorText, (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Crow> options = isar.crows
        .filter()
        .tableIdEqualTo(widget.field.optionsTable ?? '')
        .findAllSync();
    List<String> optionsList = options
        .map((option) {
          Map data = option.getData();
          return data['value'];
        })
        .where((e) => e != null)
        .map((e) => e as String)
        .toSet()
        .toList();
    Map<String, dynamic> data = widget.row.getData();

    return FormBuilderDropdown(
      key: Key('${widget.field.id}/${data['${widget.field.name}'] ?? ''}'),
      name: widget.field.id,
      validator: (_) {
        if (errorText.value != '') return errorText.value;
        return null;
      },
      onChanged: (choosen) async {
        if (choosen == data['${widget.field.name}']) return;
        data['${widget.field.name}'] = choosen;
        widget.row.data = json.encode(data);
        try {
          await widget.row
              .saveData(fieldName: widget.field.name ?? '', value: choosen);
          errorText.value = '';
        } catch (e) {
          print(e);
          errorText.value = e.toString();
        }
      },
      decoration: InputDecoration(
        labelText: widget.field.label ?? widget.field.name,
      ),
      initialValue: data['${widget.field.name}'] != null
          ? data['${widget.field.name}']
          : null,
      items: optionsList
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      allowClear: true,
    );
  }
}
