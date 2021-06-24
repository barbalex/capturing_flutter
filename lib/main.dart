import 'package:flutter/material.dart';
import 'package:capturing/screens/initial.dart';
import 'package:capturing/screens/welcome.dart';
import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/registration.dart';
import 'package:capturing/screens/projects/index.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:intl/intl.dart';
import 'isar.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capturing/screens/project/index.dart';
import 'package:capturing/screens/table/index.dart';
import 'package:capturing/screens/rows/index.dart';
import 'package:capturing/screens/tables/index.dart';
import 'package:capturing/screens/fields/index.dart';
import 'package:capturing/screens/field/index.dart';
import 'package:capturing/screens/user/index.dart';
import 'package:capturing/screens/row/index.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import 'package:capturing/store.dart';
import 'package:capturing/screens/map/index.dart';
import 'package:capturing/screens/mapLayers/index.dart';
import 'package:capturing/models/store.dart';
import 'package:isar/isar.dart';

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

  String defaultLocale = Platform.localeName;
  Intl.defaultLocale = defaultLocale;
  initializeDateFormatting(defaultLocale, null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final Rx<User?> user = authController.user ?? Rx<User?>(null);
    bool isLoggedIn = authController.isLoggedIn;
    final Isar isar = Get.find<Isar>();

    // always show welcome when logged out
    // TODO: better to use stateful widget with ever in initState?
    ever(user, (User? user) {
      if (user?.email == null) {
        print('firebase user is null, navigating to welcome');
        url.value = ['/'];
      } else {
        print('firebase user changed, navigating to projects');
        url.value = ['/projects/'];
      }
    });

    ever(url, (List<String> url) async {
      print('main, url changed to: $url');
      List<String>? previousUrl;
      // write url to isar
      Store? store;
      try {
        store = await isar.stores.get(1);
      } catch (e) {
        print(e);
      }
      if (store == null) {
        print('main, putting new store');
        await isar.writeTxn((_) async {
          await isar.stores.put(Store(url: url));
        });
      } else if (store.url != url) {
        previousUrl = store.url;
        await isar.writeTxn((_) async {
          store?.url = url;
          await isar.stores.put(store as Store);
        });
      }
      //print('main, previousUrl: $previousUrl');
      //print('main, url: $url');
      if (previousUrl != null && previousUrl.contains('layers')) {
        // returning from map only possible with the back button
        // so do not add new items to the routing stack
        return Get.offNamed(url.join(''));
      }
      if (url.contains('layers')) {
        // returning from map only possible with the back button
        // so do not add new items to the routing stack
        return Get.offNamed(url.join(''));
      }
      Get.toNamed(url.join(''));
    });

    ever(editingProject, (String? editingProject) async {
      print('main, editingProject changed to: $editingProject');
      // write url to isar
      Store? store = await isar.stores.get(1);
      if (store == null) {
        await isar.writeTxn((_) async {
          await isar.stores.put(Store(editingProject: editingProject));
        });
      } else if (store.editingProject != editingProject) {
        await isar.writeTxn((_) async {
          store.editingProject = editingProject;
          await isar.stores.put(store);
        });
      }
    });

    List<String>? previousUrl = isar.stores.getSync(1)?.url;
    String initialRoute = isLoggedIn
        ? !storeInitialized.value
            ? 'initial'
            : previousUrl?.join('') ?? '/projects/'
        : '/';

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
      initialRoute: initialRoute,
      unknownRoute: GetPage(name: '/notfound', page: () => ProjectsContainer()),
      getPages: [
        GetPage(
          name: 'initial',
          page: () => Initial(),
        ),
        GetPage(
          name: '/',
          page: () => WelcomeWidget(),
        ),
        GetPage(
          name: '/login/',
          page: () => LoginWidget(),
        ),
        GetPage(
          name: '/registration/',
          page: () => RegistrationWidget(),
        ),
        GetPage(
          name: '/projects/',
          page: () {
            if (isLoggedIn) {
              return ProjectsContainer();
            }
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId',
          page: () {
            if (isLoggedIn) return ProjectContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        // first level tables:
        GetPage(
          name: '/projects/:projectId/tables/',
          page: () {
            if (isLoggedIn) return TablesListRouter();
            return WelcomeWidget();
          },
        ),
        // first level tables:
        GetPage(
          name: '/projects/:projectId/tables/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1',
          page: () {
            if (isLoggedIn) return TableContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/',
          page: () {
            if (isLoggedIn) return FieldsListContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/:fieldId',
          page: () {
            if (isLoggedIn) return FieldContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/',
          page: () {
            if (isLoggedIn) return RowsListContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/:rowId1',
          page: () {
            if (isLoggedIn) return RowContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/',
          page: () {
            if (isLoggedIn) return RowsListContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2',
          page: () {
            if (isLoggedIn) return RowContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/',
          page: () {
            if (isLoggedIn) return RowsListContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3',
          page: () {
            if (isLoggedIn) return RowContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/',
          page: () {
            if (isLoggedIn) return RowsListContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4',
          page: () {
            if (isLoggedIn) return RowContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4/map/',
          page: () {
            if (isLoggedIn) return MapContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4/map/layers/',
          page: () {
            if (isLoggedIn) return MapLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name: '/user',
          page: () {
            if (isLoggedIn) {
              return UserWidget();
            }
            return WelcomeWidget();
          },
        ),
      ],
    );
  }
}
