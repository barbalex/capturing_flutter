import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/dbOperation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/sync/dbOperations/account.dart';
import 'package:capturing/controllers/sync/dbOperations/field.dart';
import 'package:capturing/controllers/sync/dbOperations/project.dart';
import 'package:capturing/controllers/sync/dbOperations/projectUser.dart';
import 'package:capturing/controllers/sync/dbOperations/row.dart';
import 'package:capturing/controllers/sync/dbOperations/file.dart';
import 'package:capturing/controllers/sync/dbOperations/table.dart';
import 'package:capturing/controllers/sync/dbOperations/relType.dart';
import 'package:capturing/controllers/sync/dbOperations/roleType.dart';
import 'package:capturing/controllers/sync/dbOperations/fieldType.dart';
import 'package:capturing/controllers/sync/dbOperations/optionType.dart';
import 'package:capturing/controllers/sync/dbOperations/widgetType.dart';
import 'package:capturing/controllers/sync/dbOperations/widgetsForField.dart';
import 'package:capturing/controllers/sync/dbOperations/user.dart';

class DbOperationsController {
  HasuraConnect gqlConnect;
  final Isar isar = Get.find<Isar>();

  DbOperationsController({required this.gqlConnect});

  Future<void> run() async {
    List<DbOperation> operations =
        await isar.dbOperations.where().sortByTime().findAll();
    // clone list because need to delete items inside the loop
    [...operations].forEach((operation) async {
      switch (operation.table) {
        case 'accounts':
          AccountOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'fields':
          FieldOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'cfiles':
          FileMutation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'fieldTypes':
          FieldTypeOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'optionTypes':
          OptionTypeOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'projects':
          ProjectOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'projectUsers':
          ProjectUserOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'relTypes':
          RelTypeOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'roleTypes':
          RoleTypeOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'rows':
          RowOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'tables':
          TableOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'users':
          UserOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'widgetTypes':
          WidgetTypeOperation(gqlConnect: gqlConnect, operation: operation);
          break;
        case 'widgetsForFields':
          WidgetsForFieldOperation(
              gqlConnect: gqlConnect, operation: operation);
          break;
        default:
          print('no operation found for table ${operation.table}');
          Get.snackbar(
            'Operation error',
            'There exits not operation for table ${operation.table}',
            snackPosition: SnackPosition.BOTTOM,
          );
      }
    });
    return;
  }
}
