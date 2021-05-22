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
          {
            AccountOperation aOp =
                AccountOperation(gqlConnect: gqlConnect, operation: operation);
            aOp.run();
            break;
          }
        case 'fields':
          {
            FieldOperation fOp =
                FieldOperation(gqlConnect: gqlConnect, operation: operation);
            fOp.run();
            break;
          }
        case 'cfiles':
          {
            FileMutation fOp =
                FileMutation(gqlConnect: gqlConnect, operation: operation);
            fOp.run();
            break;
          }
        case 'fieldTypes':
          {
            FieldTypeOperation ftOp = FieldTypeOperation(
                gqlConnect: gqlConnect, operation: operation);
            ftOp.run();
            break;
          }
        case 'optionTypes':
          {
            OptionTypeOperation otOp = OptionTypeOperation(
                gqlConnect: gqlConnect, operation: operation);
            otOp.run();
            break;
          }
        case 'projects':
          {
            ProjectOperation pOp =
                ProjectOperation(gqlConnect: gqlConnect, operation: operation);
            pOp.run();
            break;
          }
        case 'projectUsers':
          {
            ProjectUserOperation puOp = ProjectUserOperation(
                gqlConnect: gqlConnect, operation: operation);
            puOp.run();
            break;
          }
        case 'relTypes':
          {
            RelTypeOperation rtOp =
                RelTypeOperation(gqlConnect: gqlConnect, operation: operation);
            rtOp.run();
            break;
          }
        case 'roleTypes':
          {
            RoleTypeOperation rtOp =
                RoleTypeOperation(gqlConnect: gqlConnect, operation: operation);
            rtOp.run();
            break;
          }
        case 'rows':
          {
            RowOperation rOp =
                RowOperation(gqlConnect: gqlConnect, operation: operation);
            rOp.run();
            break;
          }
        case 'tables':
          {
            TableOperation ctOp =
                TableOperation(gqlConnect: gqlConnect, operation: operation);
            ctOp.run();
            break;
          }
        case 'users':
          {
            UserOperation uOp =
                UserOperation(gqlConnect: gqlConnect, operation: operation);
            uOp.run();
            break;
          }
        case 'widgetTypes':
          {
            WidgetTypeOperation wtOp = WidgetTypeOperation(
                gqlConnect: gqlConnect, operation: operation);
            wtOp.run();
            break;
          }
        case 'widgetsForFields':
          {
            WidgetsForFieldOperation wffOp = WidgetsForFieldOperation(
                gqlConnect: gqlConnect, operation: operation);
            wffOp.run();
            break;
          }
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
