import 'package:get/state_manager.dart';
import 'package:get/get.dart';
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
import 'package:capturing/controllers/sync/dbOperations/tileLayer.dart';
import 'package:capturing/controllers/sync/dbOperations/projectTileLayer.dart';
import 'package:capturing/controllers/sync/dbOperations/user.dart';

class DbOperationsController {
  final Isar isar = Get.find<Isar>();

  DbOperationsController();

  Future<void> run() async {
    List<DbOperation> operations =
        await isar.dbOperations.where().sortByTime().findAll();
    // clone list because need to delete items inside the loop
    [...operations].forEach((operation) async {
      switch (operation.table) {
        case 'accounts':
          AccountOperation(operation);
          break;
        case 'fields':
          FieldOperation(operation);
          break;
        case 'cfiles':
          FileMutation(operation);
          break;
        case 'fieldTypes':
          FieldTypeOperation(operation);
          break;
        case 'optionTypes':
          OptionTypeOperation(operation);
          break;
        case 'projects':
          ProjectOperation(operation);
          break;
        case 'projectUsers':
          ProjectUserOperation(operation);
          break;
        case 'relTypes':
          RelTypeOperation(operation);
          break;
        case 'roleTypes':
          RoleTypeOperation(operation);
          break;
        case 'rows':
          RowOperation(operation);
          break;
        case 'tables':
          TableOperation(operation);
          break;
        case 'users':
          UserOperation(operation);
          break;
        case 'widgetTypes':
          WidgetTypeOperation(operation);
          break;
        case 'widgetsForFields':
          WidgetsForFieldOperation(operation);
          break;
        case 'tileLayers':
          TileLayerOperation(operation);
          break;
        case 'projectTileLayers':
          ProjectTileLayerOperation(operation);
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
