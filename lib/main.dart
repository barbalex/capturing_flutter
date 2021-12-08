import 'package:capturing/models/table.dart';
import 'package:flutter/material.dart';
import 'package:capturing/screens/initial.dart';
import 'package:capturing/screens/welcome.dart';
import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/registration.dart';
import 'package:capturing/screens/projects/router.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capturing/screens/project/router.dart';
import 'package:capturing/screens/table/router.dart';
import 'package:capturing/screens/rows/router.dart';
import 'package:capturing/screens/tables/index.dart';
import 'package:capturing/screens/fields/router.dart';
import 'package:capturing/screens/field/router.dart';
import 'package:capturing/screens/user/index.dart';
import 'package:capturing/screens/row/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import 'package:capturing/store.dart';
import 'package:capturing/screens/map/index.dart';
import 'package:capturing/screens/projectTileLayers/index.dart';
import 'package:capturing/screens/projectTileLayer/index.dart';
import 'package:capturing/models/store.dart';
import 'package:capturing/models/field.dart';
import 'package:isar/isar.dart';
import 'package:web_socket_channel/io.dart';
import 'isar.g.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:capturing/utils/translations.dart';
import 'package:capturing/utils/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

import 'models/dbOperation.dart';

void main() async {
  // without this Firebase errors when initializing app
  WidgetsFlutterBinding.ensureInitialized();

  // initialize isar
  final isar = await openIsar();
  Get.put(isar);

  Store? store = await isar.stores.get(1);
  if (store == null) {
    await isar.writeTxn((_) async {
      await isar.stores.put(
        Store(largeLayoutTreeColumnSize: 300),
      );
    });
  }
  largeLayoutTreeColumnSize.value = store?.largeLayoutTreeColumnSize ?? 300;

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

  // see: https://github.com/zino-app/graphql-flutter/issues/902#issuecomment-847869946
  final graphql.HttpLink httpLink = graphql.HttpLink(graphQlUri);

  final graphql.AuthLink authLink = graphql.AuthLink(
    getToken: () => "Bearer ${authController.value.token}",
  );
  final graphql.WebSocketLink wsLink = graphql.WebSocketLink(
    wsGraphQlUri,
    config: graphql.SocketClientConfig(
      //inactivityTimeout: Duration(minutes: 30),
      //delayBetweenReconnectionAttempts: Duration(seconds: 1),
      //autoReconnect: true,
      initialPayload: () => {
        'X-Hasura-Role': 'user',
        'Authorization': 'Bearer ${authController.value.token}'
      },
      connect: (url, protocols) => IOWebSocketChannel.connect(
        url,
        protocols: protocols,
        headers: {
          'X-Hasura-Role': 'user',
          'Authorization': 'Bearer ${authController.value.token}'
        },
      ),
    ),
  );
  //print('subscribing, token: ${authController.token}');
  final link = graphql.Link.split(
      (request) => request.isSubscription, wsLink, authLink.concat(httpLink));
  // see: https://github.com/zino-app/graphql-flutter/issues/692#issuecomment-751696782
  final policies = graphql.Policies(fetch: graphql.FetchPolicy.noCache);
  graphql.GraphQLClient graphqlClient = graphql.GraphQLClient(
    link: link,
    cache: graphql.GraphQLCache(store: graphql.InMemoryStore()),
    defaultPolicies: graphql.DefaultPolicies(
      watchQuery: policies,
      watchMutation: policies,
      query: policies,
      mutate: policies,
      subscribe: policies,
    ),
  );
  Get.put(graphqlClient);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final Rx<User?> user = authController.user ?? Rx<User?>(null);
    final Isar isar = Get.find<Isar>();
    final graphql.GraphQLClient graphqlClient =
        Get.find<graphql.GraphQLClient>();

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
      if (store != null && store.url != url) {
        previousUrl = store.url;
        await isar.writeTxn((_) async {
          store?.url = url;
          await isar.stores.put(store as Store);
        });
      }
      //print('main, previousUrl: $previousUrl');
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
      // if (isFieldsUrl(url) && previousUrl != null && isFieldsUrl(previousUrl)) {
      //   // do not navigate - PageView does that
      //   print('main not adding to the routing stack');
      //   return Get.offNamed(url.join(''));
      // }
      Get.toNamed(url.join(''));
    });

    ever(editingProject, (String? editingProject) async {
      // write url to isar
      Store? store = await isar.stores.get(1);
      if (store != null && store.editingProject != editingProject) {
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
    String initialRoute = authController.isLoggedIn
        ? !storeInitialized.value
            ? '/initial'
            : previousUrl?.join('') ?? '/projects/'
        : '/';

    return graphql.GraphQLProvider(
      client: ValueNotifier(graphqlClient),
      child: GetMaterialApp(
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
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple.shade900,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // this is ignored :-(
          // so need to repeat it in every AppBar
          iconTheme: IconThemeData(color: Colors.white),
        ),
        initialRoute: initialRoute,
        unknownRoute: GetPage(
          name: '/notfound',
          page: () => ProjectsRouter(),
          transitionDuration: Duration(seconds: 0),
        ),
        getPages: [
          GetPage(
            name: '/initial',
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
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name: '/projects/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name: '/projects/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          // first level tables:
          GetPage(
            name: '/projects/:projectId/tables/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TablesListRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/tables/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TablesListRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TableRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/fields/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/fields/:fieldId',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/tables/:tableId2',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TableRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/fields/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/fields/:fieldId',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TablesListRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TableRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/tables/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TablesListRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/fields/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/fields/:fieldId',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/tables/:tableId4',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TableRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/tables/:tableId4/tables/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return TablesListRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/tables/:tableId4/fields/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/tables/:tableId2/tables/:tableId3/tables/:tableId4/fields/:fieldId',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/fields/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/fields/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/fields/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/fields/:fieldId',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return FieldRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/fields/:fieldId/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/rows/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/rows/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/rows/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/rows/:rowId1',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name: '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowsRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return RowRouter();
            },
            transitionDuration: Duration(seconds: 0),
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4/map/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return MapContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4/map/layers/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayersContainer();
            },
          ),
          GetPage(
            name:
                '/projects/:projectId/tables/:tableId1/rows/:rowId1/tables/:tableId2/rows/:rowId2/tables/:tableId3/rows/:rowId3/tables/:tableId4/rows/:rowId4/map/layers/:layerId/',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return ProjectTileLayerContainer();
            },
          ),
          GetPage(
            name: '/user',
            page: () {
              if (!authController.isLoggedIn) return WelcomeWidget();
              return UserWidget();
            },
          ),
        ],
      ),
    );
  }
}
