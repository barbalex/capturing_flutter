import 'package:capturing/models/project.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';

class UpdateFromServerController {
  dynamic result;
  final Isar isar = Get.find<Isar>();

  UpdateFromServerController({required this.result});

  Future<void> update() async {
    // projects
    List<dynamic> serverProjectsData = (result?['data']?['projects'] ?? []);
    List<Project> serverProjects = List.from(
      serverProjectsData.map((p) => Project.fromJson(p)),
    );
    await isar.writeTxn((isar) async {
      await Future.forEach(serverProjects, (Project serverProject) async {
        Project? localProjekt =
            await isar.projects.where().idEqualTo(serverProject.id).findFirst();
        if (localProjekt != null) {
          // unfortunately need to delete
          // because when updating this is not registered and ui does not update
          await isar.projects.delete(localProjekt.isarId ?? 0);
        }
        Project newProject = Project.fromJson(serverProject.toMap());
        await isar.projects.put(newProject);
      });
    });
    return;
  }
}
