import 'package:hasura_connect/hasura_connect.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class ServerQueryNonSyncedController {
  HasuraConnect gqlConnect;
  final Isar isar = Get.find<Isar>();

  ServerQueryNonSyncedController({required this.gqlConnect});

  Future<dynamic> fetch() async {
    // fetch last time any project was revisioned server side
    String? fieldTypesLastServerRevAt = await isar.fieldTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? optionTypesLastServerRevAt = await isar.optionTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? relTypesLastServerRevAt = await isar.relTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? roleTypesLastServerRevAt = await isar.relTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? widgetTypesLastServerRevAt = await isar.widgetTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? widgetsForFieldsLastServerRevAt = await isar.widgetsForFields
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    // Errors. see: https://github.com/isar/isar/issues/83
    // String? projectsLastServerRevAtMaxxed =
    //     await isar.projects.where().serverRevAtProperty().max() ??
    //         '1900-01-01T00:00:00+01:00';
    //print(projectsLastServerRevAt);
    dynamic result;
    try {
      result = await gqlConnect.query(
        r'''
        query allDataQuery($fieldTypesLastServerRevAt: timestamptz, $optionTypesLastServerRevAt: timestamptz, $relTypesLastServerRevAt: timestamptz, $roleTypesLastServerRevAt: timestamptz, $widgetTypesLastServerRevAt: timestamptz, $widgetsForFieldsLastServerRevAt: timestamptz) {
          field_types(where: {server_rev_at: {_gt: $fieldTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
          option_types(where: {server_rev_at: {_gt: $optionTypesLastServerRevAt}}) {
            id
            value
            save_id
            sort
            comment
            server_rev_at
            deleted
          }
          rel_types(where: {server_rev_at: {_gt: $relTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
          role_types(where: {server_rev_at: {_gt: $roleTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
          widget_types(where: {server_rev_at: {_gt: $widgetTypesLastServerRevAt}}) {
            value
            needs_list
            sort
            comment
            server_rev_at
            deleted
          }
          widgets_for_fields(where: {server_rev_at: {_gt: $widgetsForFieldsLastServerRevAt}}) {
            field_value
            widget_value
            server_rev_at
            deleted
          }
        }

      ''',
        variables: {
          'fieldTypesLastServerRevAt': fieldTypesLastServerRevAt,
          'optionTypesLastServerRevAt': optionTypesLastServerRevAt,
          'relTypesLastServerRevAt': relTypesLastServerRevAt,
          'roleTypesLastServerRevAt': roleTypesLastServerRevAt,
          'widgetTypesLastServerRevAt': widgetTypesLastServerRevAt,
          'widgetsForFieldsLastServerRevAt': widgetsForFieldsLastServerRevAt,
        },
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    //print('result: $result');
    return result;
  }
}
