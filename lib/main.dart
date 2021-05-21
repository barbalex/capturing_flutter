import 'package:flutter/material.dart';
import 'package:capturing/screens/welcome.dart';
import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/registration.dart';
import 'package:capturing/screens/projects.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:intl/intl.dart';
import 'isar.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capturing/screens/project/index.dart';
import 'package:capturing/screens/table/index.dart';
import 'package:capturing/screens/tables.dart';
import 'package:capturing/screens/fields.dart';
import 'package:capturing/screens/field/index.dart';
import 'package:capturing/screens/rows.dart';
import 'package:capturing/screens/user/index.dart';
import 'package:capturing/screens/row/index.dart';
import 'package:capturing/controllers/sync/index.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';

void main() async {
  // without this Firebase errors when initializing app
  WidgetsFlutterBinding.ensureInitialized();

  // initialize isar
  final isar = await openIsar();
  Get.put(isar);

  // initialize firebase
  await Firebase.initializeApp();
  final AuthController authController = AuthController();
  Get.put(authController);

  // initialize sync with db server and files
  final SyncController syncController = SyncController();
  Get.put(syncController); // only needed if manual sync is added
  syncController.init();

  String defaultLocale = Platform.localeName;
  Intl.defaultLocale = defaultLocale;
  initializeDateFormatting(defaultLocale, null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final Rx<User?> user = authController.user ?? Rx<User?>(null);
    bool isLoggedIn = authController.isLoggedIn;

    // always show welcome when logged out
    ever(user, (dynamic user) {
      if (user?.value?.email == null) {
        print('firebase user changed, navigating to welcome');
        Get.to(() => Welcome());
      } else {
        print('firebase user changed, navigating to projects');
        Get.to(() => Projects());
      }
    });

    return GetMaterialApp(
      theme: Theme.of(context).copyWith(
        brightness: Brightness.dark,
        primaryColor: Colors.purple.shade900,
        primaryColorLight: Colors.purple.shade300,
        accentColor: Colors.orange.shade700,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.purple.shade900,
          ),
        ),
      ),
      initialRoute: isLoggedIn ? '/projects/' : '/',
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
          name: '/projects/',
          page: () {
            if (isLoggedIn) {
              return Projects();
            }
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:projectId',
          page: () {
            if (isLoggedIn) return ProjectViewWidget();
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/',
          page: () {
            if (isLoggedIn) return Tables();
            return Welcome();
          },
        ),
        // GetPage(
        //   name: '/projects/:projectId/map/',
        //   page: () {
        //     if (isLoggedIn) return MapWidget();
        //     return Welcome();
        //   },
        // ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId',
          page: () {
            if (isLoggedIn) return TableViewWidget();
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId/fields/',
          page: () {
            if (isLoggedIn) return Fields();
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId/fields/:fieldId',
          page: () {
            if (isLoggedIn) return FieldViewWidget();
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId/rows/',
          page: () {
            if (isLoggedIn) return Rows();
            return Welcome();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId/rows/:rowId',
          page: () {
            if (isLoggedIn) return RowViewWidget();
            return Welcome();
          },
        ),
        GetPage(
          name: '/user',
          page: () {
            if (isLoggedIn) {
              return UserWidget();
            }
            return Welcome();
          },
        ),
      ],
    );
  }
}
