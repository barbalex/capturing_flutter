import 'package:hasura_connect/hasura_connect.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class ServerFetchController {
  HasuraConnect gqlConnect;
  final Isar isar = Get.find<Isar>();

  ServerFetchController({required this.gqlConnect});

  Future<dynamic> fetch() async {
    // fetch last time any project was revisioned server side
    String? accountsLastServerRevAt = await isar.accounts
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? fieldsLastServerRevAt = await isar.fields
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? fieldTypesLastServerRevAt = await isar.fieldTypes
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? filesLastServerRevAt = await isar.cfiles
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
    String? projectsLastServerRevAt = await isar.projects
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? projectUsersLastServerRevAt = await isar.projectUsers
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? rowsLastServerRevAt = await isar.crows
            .where()
            .sortByServerRevAtDesc()
            .serverRevAtProperty()
            .findFirst() ??
        '1900-01-01T00:00:00+01:00';
    String? ctablesLastServerRevAt = await isar.ctables
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
    String? usersLastServerRevAt = await isar.cUsers
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
        query allDataQuery($accountsLastServerRevAt: timestamptz, $fieldsLastServerRevAt: timestamptz, $fieldTypesLastServerRevAt: timestamptz, $filesLastServerRevAt: timestamptz, $optionTypesLastServerRevAt: timestamptz, $projectsLastServerRevAt: timestamptz, $projectUsersLastServerRevAt: timestamptz, $rowsLastServerRevAt: timestamptz, $relTypesLastServerRevAt: timestamptz, $roleTypesLastServerRevAt: timestamptz, $ctablesLastServerRevAt: timestamptz, $usersLastServerRevAt: timestamptz, $widgetTypesLastServerRevAt: timestamptz, $widgetsForFieldsLastServerRevAt: timestamptz) {
          accounts(where: {server_rev_at: {_gt: $accountsLastServerRevAt}}) {
            id
            service_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
          fields(where: {server_rev_at: {_gt: $fieldsLastServerRevAt}}) {
            id
            table_id
            name
            label
            ord
            is_internal_id
            field_type
            widget_type
            options_table
            standard_value
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
          field_types(where: {server_rev_at: {_gt: $fieldTypesLastServerRevAt}}) {
            value
            sort
            comment
            server_rev_at
            deleted
          }
          files(where: {server_rev_at: {_gt: $filesLastServerRevAt}}) {
            id
            row_id
            field_id
            filename
            url
            version
            client_rev_at
            client_rev_by
            server_rev_at
            rev
            parent_rev
            revisions
            depth
            deleted
            conflicts
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
          projects(where: {server_rev_at: {_gt: $projectsLastServerRevAt}}) {
            id
            label
            name
            account_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
            srs_id
          }
          project_users(where: {server_rev_at: {_gt: $projectUsersLastServerRevAt}}) {
            id
            project_id
            user_email
            role
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
          rows(where: {server_rev_at: {_gt: $rowsLastServerRevAt}}) {
            id
            table_id
            parent_id
            geometry
            geometry_n
            geometry_e
            geometry_s
            geometry_w
            data
            client_rev_at
            client_rev_by
            server_rev_at
            rev
            parent_rev
            revisions
            depth
            deleted
            conflicts
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
          tables(where: {server_rev_at: {_gt: $ctablesLastServerRevAt}}) {
            id
            name
            label
            ord
            label_fields
            label_fields_separator
            rel_type
            option_type
            project_id
            parent_id
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
          users(where: {server_rev_at: {_gt: $usersLastServerRevAt}}) {
            id
            name
            email
            account_id
            auth_id
            client_rev_at
            client_rev_by
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
          'accountsLastServerRevAt': accountsLastServerRevAt,
          'fieldsLastServerRevAt': fieldsLastServerRevAt,
          'fieldTypesLastServerRevAt': fieldTypesLastServerRevAt,
          'filesLastServerRevAt': filesLastServerRevAt,
          'optionTypesLastServerRevAt': optionTypesLastServerRevAt,
          'projectsLastServerRevAt': projectsLastServerRevAt,
          'projectUsersLastServerRevAt': projectUsersLastServerRevAt,
          'rowsLastServerRevAt': rowsLastServerRevAt,
          'relTypesLastServerRevAt': relTypesLastServerRevAt,
          'roleTypesLastServerRevAt': roleTypesLastServerRevAt,
          'ctablesLastServerRevAt': ctablesLastServerRevAt,
          'usersLastServerRevAt': usersLastServerRevAt,
          'widgetTypesLastServerRevAt': widgetTypesLastServerRevAt,
          'widgetsForFieldsLastServerRevAt': widgetsForFieldsLastServerRevAt
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

    // does not work in local dev, see: https://github.com/Flutterando/hasura_connect/issues/96
    // Snapshot snapshot = await wsConnect.subscription('''
    //   subscription allDataSubscription {
    //     projects {
    //       id
    //       label
    //       name
    //       account_id
    //     }
    //   }
    //   ''');
    //
    // TODO: need to refetch token after one hour when firebase token expires
    // see: https://github.com/Flutterando/hasura_connect/issues/67#issuecomment-669650467
    // and solution: https://gist.github.com/osaxma/141d6be2b522f8bfe8673af14eb20bd1
    //
    // snapshot.listen((data) {
    //   print('graphqlController, data from subscription: $data');
    // });
  }
}
