import 'package:isar/isar.dart';
import 'dart:convert';

@Collection()
class DbOperation {
  @Id()
  int? id;

  @Index()
  DateTime? time;

  String? table;

  //@DataConverter()
  //Map<String, dynamic>? data;
  String? data;

  DbOperation setData(Map data) {
    this.data = json.encode(data);
    return this;
  }

  Map<String, dynamic> getData() {
    if (this.data == null) return {};
    dynamic data = this.data ?? '';
    while (data.runtimeType == String) {
      data = json.decode(data ?? '');
    }
    return data;
  }

  DbOperation({
    this.table,
  }) {
    time = DateTime.now();
  }
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
