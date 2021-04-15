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

void main() async {
  // without this Firebase errors when initializing app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  final isar = await openIsar();
  Get.put(isar);

  // TODO:
  // initialize graphql
  // start subscriptions
  // start syncing
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
      if (user.value?.email == null) {
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
      routes: {
        '/': (context) => Welcome(),
        '/login': (context) => Login(),
        '/registration': (context) => Registration(),
        '/projects': (context) {
          if (isLoggedIn) return Projects();
          return Welcome();
        },
      },
    );
  }
}
