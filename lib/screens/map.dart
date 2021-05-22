// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:isar/isar.dart';
// import 'package:capturing/isar.g.dart';
// import 'package:capturing/models/project.dart';
// import 'package:capturing/components/formTitle.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapWidget extends StatelessWidget {
//   final Isar isar = Get.find<Isar>();
//   final String projectId = Get.parameters['projectId'] ?? '0';

//   @override
//   Widget build(BuildContext context) {
//     //print('project, id: $id');
//     return FutureBuilder(
//       //future: isar.projects.where().idEqualTo(id).findFirst(),
//       future: isar.projects
//           .where()
//           .filter()
//           .deletedEqualTo(false)
//           .sortByName()
//           .findAll(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             Get.snackbar(
//               'Error accessing local storage',
//               snapshot.error.toString(),
//               snackPosition: SnackPosition.BOTTOM,
//             );
//           } else {
//             List<Project> projects = snapshot.data;
//             Project project = projects.where((p) => p.id == projectId).first;
//             int ownIndex = projects.indexOf(project);
//             bool existsNextProject = projects.length > ownIndex + 1;
//             Project? nextProject =
//                 existsNextProject ? projects[ownIndex + 1] : null;
//             bool existsPreviousProject = ownIndex > 0;
//             Project? previousProject =
//                 existsPreviousProject ? projects[ownIndex - 1] : null;
//             var nameTxt = TextEditingController();
//             nameTxt.text = project.name ?? '';
//             var labelTxt = TextEditingController();
//             labelTxt.text = project.label ?? '';

//             return Scaffold(
//               appBar: AppBar(
//                 title: FormTitle(title: 'Project'),
//               ),
//               body: FlutterMap(
//                 options: MapOptions(
//                   center: LatLng(51.5, -0.09),
//                   zoom: 13.0,
//                 ),
//                 layers: [
//                   TileLayerOptions(
//                       urlTemplate:
//                           "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                       subdomains: ['a', 'b', 'c']),
//                   MarkerLayerOptions(
//                     markers: [
//                       Marker(
//                         width: 80.0,
//                         height: 80.0,
//                         point: LatLng(51.5, -0.09),
//                         builder: (ctx) => Container(
//                           child: FlutterLogo(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               bottomNavigationBar: Obx(() => BottomNavigationBar(
//                     type: BottomNavigationBarType.fixed,
//                     backgroundColor: Theme.of(context).primaryColor,
//                     selectedItemColor: Colors.white,
//                     unselectedItemColor: Colors.white,
//                     items: <BottomNavigationBarItem>[
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.map),
//                         label: 'Map',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(
//                           Icons.arrow_upward,
//                         ),
//                         label: 'List',
//                       ),
//                       existsPreviousProject
//                           ? BottomNavigationBarItem(
//                               icon: Icon(Icons.arrow_back),
//                               label: 'Previous',
//                             )
//                           : BottomNavigationBarItem(
//                               icon: Icon(Icons.add),
//                               label: 'New',
//                             ),
//                       existsNextProject
//                           ? BottomNavigationBarItem(
//                               icon: Icon(Icons.arrow_forward),
//                               label: 'Next',
//                             )
//                           : BottomNavigationBarItem(
//                               icon: Icon(Icons.add),
//                               label: 'New',
//                             ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.arrow_downward),
//                         label: 'Tables',
//                       ),
//                     ],
//                     currentIndex: 0,
//                     onTap: (index) async {
//                       switch (index) {
//                         case 0:
//                           print('TODO:');
//                           break;
//                         case 1:
//                           Get.toNamed('/projects/');
//                           break;
//                         case 2:
//                           {
//                             if (!existsPreviousProject) {
//                               Project newProject = Project();
//                               await newProject.save();
//                               Get.toNamed('/projects/${newProject.id}');
//                               break;
//                             }
//                             Get.toNamed('/projects/${previousProject?.id}');
//                             break;
//                           }
//                         case 3:
//                           {
//                             if (!existsNextProject) {
//                               Project newProject = Project();
//                               await newProject.save();
//                               Get.toNamed('/projects/${newProject.id}');
//                               break;
//                             }
//                             Get.toNamed('/projects/${nextProject?.id}');
//                             break;
//                           }
//                         case 4:
//                           Get.toNamed('/projects/${project.id}/tables/');
//                           break;
//                       }
//                     },
//                   )),
//             );
//           }
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }
