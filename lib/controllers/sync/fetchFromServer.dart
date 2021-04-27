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
    String? usersLastServerRevAt = await isar.users
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
    // Errors. see: https://github.com/isar/isar/issues/83
    // String? projectsLastServerRevAtMaxxed =
    //     await isar.projects.where().serverRevAtProperty().max() ??
    //         '1900-01-01T00:00:00+01:00';
    print(projectsLastServerRevAt);
    dynamic result;
    try {
      result = await gqlConnect.query(
        r'''
        query allDataQuery($accountsLastServerRevAt: timestamptz, $fieldsLastServerRevAt: timestamptz, $fieldTypesLastServerRevAt: timestamptz, $optionTypesLastServerRevAt: timestamptz, $projectsLastServerRevAt: timestamptz, $projectUsersLastServerRevAt: timestamptz, $relTypesLastServerRevAt: timestamptz, $ctablesLastServerRevAt: timestamptz, $usersLastServerRevAt: timestamptz, $widgetTypesLastServerRevAt: timestamptz) {
          accounts(where: {server_rev_at: {_gt: $accountsLastServerRevAt}}) {
            id
            service_id
            manager_id
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
            is_internal_id
            field_type
            widget_type
            options_table
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
          rel_types(where: {server_rev_at: {_gt: $relTypesLastServerRevAt}}) {
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
            rel_type
            is_options
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
            sort
            comment
            server_rev_at
            deleted
          }
        }
      ''',
        variables: {
          'accountsLastServerRevAt': accountsLastServerRevAt,
          'fieldsLastServerRevAt': fieldsLastServerRevAt,
          'fieldTypesLastServerRevAt': fieldTypesLastServerRevAt,
          'optionTypesLastServerRevAt': optionTypesLastServerRevAt,
          'projectsLastServerRevAt': projectsLastServerRevAt,
          'projectUsersLastServerRevAt': projectUsersLastServerRevAt,
          'relTypesLastServerRevAt': relTypesLastServerRevAt,
          'ctablesLastServerRevAt': ctablesLastServerRevAt,
          'usersLastServerRevAt': usersLastServerRevAt,
          'widgetTypesLastServerRevAt': widgetTypesLastServerRevAt
        },
      );
    } catch (e) {
      print('graphqlController, error fetching server data: $e');
    }
    print('result: $result');
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
