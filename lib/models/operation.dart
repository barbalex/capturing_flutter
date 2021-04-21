import 'package:isar/isar.dart';
import 'dart:convert';

@Collection()
class Operation {
  @Id()
  int? id;

  @Index()
  DateTime time = DateTime.now();

  String? table;

  //@DataConverter()
  //Map<String, dynamic>? data;
  String? data;

  Operation setData(Map data) {
    this.data = json.encode(data);
    return this;
  }

  Map<String, dynamic> getData() {
    return json.decode(this.data ?? '');
  }

  Operation({
    this.table,
  });
}

// isar does not support Map (https://isar.dev/schema#supported-types)
// Need to convert to String (https://isar.dev/type-converters)
// this did not work because:
// data could not be set to Map - build claimed Map was not supported by isar
// class DataConverter extends TypeConverter<Map<String, dynamic>, String> {
//   const DataConverter();

//   @override
//   Map<String, dynamic> fromIsar(String dataString) {
//     return json.decode(dataString);
//   }

//   @override
//   String toIsar(Map data) {
//     return json.encode(data);
//   }
// }
