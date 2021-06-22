import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class StandardValueOptionDropdownWidget extends StatefulWidget {
  final Field field;
  final Function save;

  StandardValueOptionDropdownWidget({
    required this.field,
    required this.save,
  });

  @override
  _StandardValueOptionDropdownWidgetState createState() =>
      _StandardValueOptionDropdownWidgetState();
}

class _StandardValueOptionDropdownWidgetState
    extends State<StandardValueOptionDropdownWidget> {
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
    List<Crow> optionRows = isar.crows
        .where()
        .filter()
        .tableIdEqualTo(widget.field.optionsTable ?? '')
        .findAllSync();
    List<Map> optionRowsData = optionRows.map((o) => o.getData()).toList();
    List<String> options =
        optionRowsData.map((e) => e['value'] as String).toList();

    return FormBuilderDropdown(
      name: widget.field.id,
      validator: (_) {
        if (errorText.value != '') return errorText.value;
        return null;
      },
      onChanged: (String? choosen) async {
        if (choosen == widget.field.standardValue) return;
        widget.field.standardValue = choosen;
        widget.save();
      },
      decoration: InputDecoration(
        labelText: 'Standard Value',
      ),
      initialValue: widget.field.standardValue,
      items: options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
      allowClear: true,
    );
  }
}
