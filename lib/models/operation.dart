import 'package:isar/isar.dart';
import 'dart:convert';

@Collection()
class Operation {
  @Id()
  int? id;

  @Index()
  late DateTime time;

  String? table;

  @DataConverter()
  String? data;

  Operation({
    this.table,
    this.data,
  }) {
    time = DateTime.now();
  }
}

// isar does not support Map (https://isar.dev/schema#supported-types)
// Need to convert to String (https://isar.dev/type-converters)
class DataConverter extends TypeConverter<Map, String> {
  const DataConverter();

  @override
  Map fromIsar(String data) {
    return json.decode(data);
  }

  @override
  String toIsar(data) {
    return json.encode(data);
  }
}
