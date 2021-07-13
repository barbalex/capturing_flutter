import 'package:capturing/models/table.dart';
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
import 'package:capturing/screens/project/router.dart';
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
import 'package:capturing/screens/projectTileLayers/index.dart';
import 'package:capturing/screens/projectTileLayer/index.dart';
import 'package:capturing/models/store.dart';
import 'package:capturing/models/field.dart';
import 'package:isar/isar.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:capturing/utils/translations.dart';

import 'models/dbOperation.dart';

void main() async {
  // without this Firebase errors when initializing app
  WidgetsFlutterBinding.ensureInitialized();

  // initialize isar
  final isar = await openIsar();
  Get.put(isar);

  // initialize firebase
  await Firebase.initializeApp();
  authController.value = AuthController();
  Get.put(authController.value);

  String defLocale = Platform.localeName;
  Intl.defaultLocale = defLocale;
  initializeDateFormatting(defLocale, null);
  defaultLocale.value = defLocale;

  proj4.Projection.add(
    'EPSG:2056', // CH
    '+proj=somerc +lat_0=46.95240555555556 +lon_0=7.439583333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +towgs84=674.374,15.056,405.346,0,0,0,0 +units=m +no_defs',
  );
  proj4.Projection.add(
    'EPSG:3034', // EU https://epsg.io/3034
    '+proj=lcc +lat_1=35 +lat_2=65 +lat_0=52 +lon_0=10 +x_0=4000000 +y_0=2800000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
  );
  proj4.Projection.add(
    'EPSG:3035', // EU https://epsg.io/3035
    '+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
  );
  proj4.Projection.add(
    'EPSG:4839', // DE http://epsg.io/4839
    '+proj=lcc +lat_1=48.66666666666666 +lat_2=53.66666666666666 +lat_0=51 +lon_0=10.5 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
  );
  proj4.Projection.add(
    'EPSG:5243', // DE http://epsg.io/5243
    '+proj=lcc +lat_1=48.66666666666666 +lat_2=53.66666666666666 +lat_0=51 +lon_0=10.5 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
  );
  proj4.Projection.add(
    'EPSG:31287', // Austria http://epsg.io/31287
    '+proj=lcc +lat_1=49 +lat_2=46 +lat_0=47.5 +lon_0=13.33333333333333 +x_0=400000 +y_0=400000 +ellps=bessel +towgs84=577.326,90.129,463.919,5.137,1.474,5.297,2.4232 +units=m +no_defs',
  );

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

    Stream<List<Field>> fieldsStream =
        isar.fields.where().watch(initialReturn: false);
    fieldsStream.listen((event) {
      // happens every time a field is created
      // ensure a labelField is set
      List<Ctable> tables =
          isar.ctables.where().deletedEqualTo(false).findAllSync();
      List<Ctable> tablesWithoutLabelFields = tables
          .where((t) => t.labelFields == null || t.labelFields?.length == 0)
          .toList();
      tablesWithoutLabelFields.forEach((t) async {
        Field? field = isar.fields
            .where()
            .filter()
            .deletedEqualTo(false)
            .and()
            .tableIdEqualTo(t.id)
            .findFirstSync();
        if (field != null) {
          t.labelFields = [field.id];
          await isar.writeTxn((_) async {
            await isar.ctables.put(t);
            await isar.dbOperations
                .put(DbOperation(table: 'tables').setData(t.toMapFromModel()));
          });
        }
      });
    });

    List<String>? previousUrl = isar.stores.getSync(1)?.url;
    String initialRoute = isLoggedIn
        ? !storeInitialized.value
            ? 'initial'
            : previousUrl?.join('') ?? '/projects/'
        : '/';

    return GetMaterialApp(
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      theme: Theme.of(context).copyWith(
        brightness: Brightness.dark,
        primaryColor: Colors.purple.shade900,
        primaryColorLight: Colors.purple.shade300,
        accentColor: Colors.orange.shade700,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.purple.shade900),
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
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectsContainer();
          },
        ),
        GetPage(
          name: '/projects/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name: '/projects/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name: '/projects/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            //return ProjectRouter();
            return ProjectContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        // first level tables:
        GetPage(
          name: '/projects/:projectId/tables/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return TablesListRouter();
          },
        ),
        // first level tables:
        GetPage(
          name: '/projects/:projectId/tables/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return TableContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return FieldsListContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/fields/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/:fieldId',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return FieldContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return RowsListContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/:rowId1',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return RowContainer();
          },
        ),
        GetPage(
          name: '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return RowsListContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return RowContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return MapContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/layers/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayersContainer();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/layers/:layerId/',
          page: () {
            if (!isLoggedIn) return WelcomeWidget();
            return ProjectTileLayerContainer();
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
            if (isLoggedIn) return ProjectTileLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/map/layers/:layerId/',
          page: () {
            if (isLoggedIn) return ProjectTileLayerContainer();
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
            if (isLoggedIn) return ProjectTileLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/map/layers/:layerId/',
          page: () {
            if (isLoggedIn) return ProjectTileLayerContainer();
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
            if (isLoggedIn) return ProjectTileLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/map/layers/:layerId/',
          page: () {
            if (isLoggedIn) return ProjectTileLayerContainer();
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
            if (isLoggedIn) return ProjectTileLayersContainer();
            return WelcomeWidget();
          },
        ),
        GetPage(
          name:
              '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4/map/layers/:layerId/',
          page: () {
            if (isLoggedIn) return ProjectTileLayerContainer();
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
