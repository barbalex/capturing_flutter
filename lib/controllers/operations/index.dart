import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/operation.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/controllers/operations/project.dart';

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
        case 'projects':
          {
            ProjectOperation pOp =
                ProjectOperation(gqlConnect: gqlConnect, operation: operation);
            pOp.run();
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
