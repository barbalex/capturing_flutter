import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/sync/operations/account.dart';
import 'package:capturing/controllers/sync/operations/field.dart';
import 'package:capturing/controllers/sync/operations/project.dart';
import 'package:capturing/controllers/sync/operations/projectUser.dart';
import 'package:capturing/controllers/sync/operations/ctable.dart';
import 'package:capturing/controllers/sync/operations/relType.dart';
import 'package:capturing/controllers/sync/operations/user.dart';

class OperationsController {
  HasuraConnect gqlConnect;
  final Isar isar = Get.find<Isar>();

  OperationsController({required this.gqlConnect});

  Future<void> run() async {
    List<Operation> operations =
        await isar.operations.where().sortByTime().findAll();
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
        case 'tables':
          {
            CtableOperation ctOp =
                CtableOperation(gqlConnect: gqlConnect, operation: operation);
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
        default:
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
