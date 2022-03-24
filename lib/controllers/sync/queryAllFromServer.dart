// NOT IN USE
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/field.dart';
import 'package:capturing/models/fieldType.dart';
import 'package:capturing/models/file.dart';
import 'package:capturing/models/optionType.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/row.dart';
import 'package:capturing/models/table.dart';
import 'package:capturing/models/relType.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/models/widgetType.dart';
import 'package:capturing/models/widgetsForField.dart';
import 'package:capturing/models/tileLayer.dart';
import 'package:capturing/models/projectTileLayer.dart';

class ServerQueryController {
  final Isar isar = Get.find<Isar>();
  final GraphQLClient graphqlClient = Get.find<GraphQLClient>();

  ServerQueryController();

  Future<dynamic> fetch() async {
    // fetch last time any project was revisioned server side
    DateTime accountsLastServerRevAt =
        await isar.accounts.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime fieldsLastServerRevAt =
        await isar.fields.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime fieldTypesLastServerRevAt =
        await isar.fieldTypes.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime filesLastServerRevAt =
        await isar.cfiles.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime optionTypesLastServerRevAt =
        await isar.optionTypes.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime projectsLastServerRevAt =
        await isar.projects.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime projectUsersLastServerRevAt =
        await isar.projectUsers.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime? rowsLastServerRevAt =
        await isar.crows.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime ctablesLastServerRevAt =
        await isar.ctables.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime relTypesLastServerRevAt =
        await isar.relTypes.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime roleTypesLastServerRevAt =
        await isar.relTypes.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime usersLastServerRevAt =
        await isar.cUsers.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime widgetTypesLastServerRevAt =
        await isar.widgetTypes.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime widgetsForFieldsLastServerRevAt =
        await isar.widgetsForFields.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime tileLayersLastServerRevAt =
        await isar.ctileLayers.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    DateTime projectTileLayersLastServerRevAt =
        await isar.projectTileLayers.where().serverRevAtProperty().max() ??
            DateTime.fromMicrosecondsSinceEpoch(0);
    // Errors. see: https://github.com/isar/isar/issues/83
    // DateTime projectsLastServerRevAtMaxxed =
    //     await isar.projects.where().serverRevAtProperty().max() ??
    //         DateTime.fromMicrosecondsSinceEpoch(0);
    //print(projectsLastServerRevAt);
    try {
      QueryResult result = await graphqlClient.query(
        QueryOptions(
          document: gql(r'''
        query allDataQuery($accountsLastServerRevAt: timestamptz, $fieldsLastServerRevAt: timestamptz, $fieldTypesLastServerRevAt: timestamptz, $filesLastServerRevAt: timestamptz, $optionTypesLastServerRevAt: timestamptz, $projectsLastServerRevAt: timestamptz, $projectUsersLastServerRevAt: timestamptz, $rowsLastServerRevAt: timestamptz, $relTypesLastServerRevAt: timestamptz, $roleTypesLastServerRevAt: timestamptz, $ctablesLastServerRevAt: timestamptz, $usersLastServerRevAt: timestamptz, $widgetTypesLastServerRevAt: timestamptz, $widgetsForFieldsLastServerRevAt: timestamptz, $tileLayersLastServerRevAt: timestamptz, $projectTileLayersLastServerRevAt: timestamptz) {
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
            crs
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
            single_label
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
          tile_layers(where: {server_rev_at: {_gt: $tileLayersLastServerRevAt}}) {
            id
            label
            url_template
            subdomains
            max_zoom
            min_zoom
            opacity
            wms_base_url
            wms_format
            wms_layers
            wms_parameters
            wms_request
            wms_service
            wms_styles
            wms_transparent
            wms_version
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
          project_tile_layers(where: {server_rev_at: {_gt: $projectTileLayersLastServerRevAt}}) {
            id
            project_id
            label
            ord
            active
            url_template
            subdomains
            max_zoom
            min_zoom
            opacity
            wms_base_url
            wms_format
            wms_layers
            wms_parameters
            wms_request
            wms_service
            wms_styles
            wms_transparent
            wms_version
            client_rev_at
            client_rev_by
            server_rev_at
            deleted
          }
        }

      '''),
          variables: {
            'accountsLastServerRevAt':
                accountsLastServerRevAt.toIso8601String(),
            'fieldsLastServerRevAt': fieldsLastServerRevAt.toIso8601String(),
            'fieldTypesLastServerRevAt':
                fieldTypesLastServerRevAt.toIso8601String(),
            'filesLastServerRevAt': filesLastServerRevAt.toIso8601String(),
            'optionTypesLastServerRevAt':
                optionTypesLastServerRevAt.toIso8601String(),
            'projectsLastServerRevAt':
                projectsLastServerRevAt.toIso8601String(),
            'projectUsersLastServerRevAt':
                projectUsersLastServerRevAt.toIso8601String(),
            'rowsLastServerRevAt': rowsLastServerRevAt.toIso8601String(),
            'relTypesLastServerRevAt':
                relTypesLastServerRevAt.toIso8601String(),
            'roleTypesLastServerRevAt':
                roleTypesLastServerRevAt.toIso8601String(),
            'ctablesLastServerRevAt': ctablesLastServerRevAt.toIso8601String(),
            'usersLastServerRevAt': usersLastServerRevAt.toIso8601String(),
            'widgetTypesLastServerRevAt':
                widgetTypesLastServerRevAt.toIso8601String(),
            'widgetsForFieldsLastServerRevAt':
                widgetsForFieldsLastServerRevAt.toIso8601String(),
            'tileLayersLastServerRevAt':
                tileLayersLastServerRevAt.toIso8601String(),
            'projectTileLayersLastServerRevAt':
                projectTileLayersLastServerRevAt.toIso8601String()
          },
        ),
      );
      return result;
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error fetching server data',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
