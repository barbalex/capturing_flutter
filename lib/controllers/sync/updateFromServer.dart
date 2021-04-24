import 'package:capturing/models/project.dart';
import 'package:capturing/models/projectUser.dart';
import 'package:capturing/models/account.dart';
import 'package:capturing/models/table.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class UpdateFromServerController {
  dynamic result;
  final Isar isar = Get.find<Isar>();

  UpdateFromServerController({required this.result});

  Future<void> update() async {
    // accounts
    List<dynamic> serverAccountsData = (result?['data']?['accounts'] ?? []);
    List<Account> serverAccounts = List.from(
      serverAccountsData.map((p) => Account.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverAccounts, (Account serverAccount) async {
        Account? localAccount =
            await isar.accounts.where().idEqualTo(serverAccount.id).findFirst();
        if (localAccount != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.accounts.delete(localAccount.isarId ?? 0);
        }
        Account newAccount = Account.fromJson(serverAccount.toMap());
        await isar.accounts.put(newAccount);
      });
    });

    // projects
    List<dynamic> serverProjectsData = (result?['data']?['projects'] ?? []);
    List<Project> serverProjects = List.from(
      serverProjectsData.map((p) => Project.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverProjects, (Project serverProject) async {
        Project? localProject =
            await isar.projects.where().idEqualTo(serverProject.id).findFirst();
        if (localProject != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.projects.delete(localProject.isarId ?? 0);
        }
        Project newProject = Project.fromJson(serverProject.toMap());
        await isar.projects.put(newProject);
      });
    });

    // projectUsers
    List<dynamic> serverProjectUsersData =
        (result?['data']?['project_users'] ?? []);
    List<ProjectUser> serverProjectUsers = List.from(
      serverProjectUsersData.map((p) => ProjectUser.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverProjectUsers,
          (ProjectUser serverProjectUser) async {
        ProjectUser? localProjectUser = await isar.projectUsers
            .where()
            .idEqualTo(serverProjectUser.id)
            .findFirst();
        if (localProjectUser != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.projectUsers.delete(localProjectUser.isarId ?? 0);
        }
        ProjectUser newProjectUser =
            ProjectUser.fromJson(serverProjectUser.toMap());
        await isar.projectUsers.put(newProjectUser);
      });
    });

    // ctables
    List<dynamic> serverCtablesData = (result?['data']?['ctables'] ?? []);
    List<Ctable> serverCtables = List.from(
      serverCtablesData.map((p) => Ctable.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverCtables, (Ctable serverCtable) async {
        Ctable? localCtable =
            await isar.ctables.where().idEqualTo(serverCtable.id).findFirst();
        if (localCtable != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.ctables.delete(localCtable.isarId ?? 0);
        }
        Ctable newCtable = Ctable.fromJson(serverCtable.toMap());
        await isar.ctables.put(newCtable);
      });
    });

    return;
  }
}
