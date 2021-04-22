import 'package:flutter/material.dart';
import 'package:capturing/screens/welcome.dart';
import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/registration.dart';
import 'package:capturing/screens/projects.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capturing/controllers/authController.dart';
import 'isar.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capturing/screens/project.dart';
import 'package:capturing/controllers/graphqlController.dart';

void main() async {
  // without this Firebase errors when initializing app
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();
  final AuthController authController = AuthController();
  Get.put(authController);

  // initialize isar
  final isar = await openIsar();
  Get.put(isar);

  // initialize graphql
  final GraphqlController graphqlController = GraphqlController();
  Get.put(graphqlController);
  graphqlController.initGraphql();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final Rx<User?> user = authController.user;
    bool isLoggedIn = authController.isLoggedIn;

    // always show welcome when logged out
    ever(user, (dynamic user) {
      if (user?.value?.email == null) {
        Get.to(() => Welcome());
      } else {
        Get.to(() => Projects());
      }
    });

    return GetMaterialApp(
      theme: Theme.of(context).copyWith(
        brightness: Brightness.dark,
        primaryColor: Colors.purple.shade900,
        accentColor: Colors.orange.shade700,
      ),
      initialRoute: isLoggedIn ? '/projects' : '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Welcome(),
        ),
        GetPage(
          name: '/login',
          page: () => Login(),
        ),
        GetPage(
          name: '/registration',
          page: () => Registration(),
        ),
        GetPage(
          name: '/projects',
          page: () {
            if (isLoggedIn) {
              return Projects();
            }
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:id',
          page: () {
            if (isLoggedIn) return ProjectWidget();
            return Welcome();
          },
        ),
      ],
    );
  }
}
