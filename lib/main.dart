import 'package:capturing/models/project.dart';
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
    final Rx<User?> user = Get.find<AuthController>().user;
    final String? email = user.value?.email;
    print('main, email: $email');
    bool existsUser = email != null;

    // always show welcome when logged out
    ever(user, (dynamic user) {
      if (user.value?.email == null) {
        Get.to(() => Welcome());
      } else {
        Get.to(() => Projects());
      }
    });

    return GetMaterialApp(
      initialRoute: existsUser ? '/projects' : '/',
      routes: {
        '/': (context) => Welcome(),
        '/login': (context) => Login(),
        '/registration': (context) => Registration(),
        '/projects': (context) {
          if (existsUser) return Projects();
          return Welcome();
        },
      },
    );
  }
}
