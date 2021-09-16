// see: https://www.youtube.com/watch?v=-H-T_BSgfOE (Firebase Auth with GetX | Todo App)
import 'dart:async';
import 'package:capturing/models/store.dart';
import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/projects/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/user.dart';
import 'package:capturing/controllers/sync/index.dart';
import 'package:http/http.dart';
import 'package:capturing/utils/constants.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:capturing/screens/welcome.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<User?>? authStream;
  Rx<User?>? _firebaseUser = Rx<User?>(null);
  Rx<String?> token = Rx<String?>(null);
  final Isar isar = Get.find<Isar>();
  late SyncController syncController;

  Rx<User?>? get user => _firebaseUser;
  String? get userEmail => _firebaseUser?.value?.email;
  bool get isLoggedIn => _firebaseUser?.value != null;

  @override
  void onInit() {
    super.onInit();
    // make _firebaseUser update when auth state changes
    _firebaseUser?.bindStream(_auth.authStateChanges());
    authStream = _auth.authStateChanges().listen(onAuthStateChanges);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authStream?.cancel();
  }

  void onAuthStateChanges(event) {
    // Problem: authState changes way too often
    // see: https://stackoverflow.com/a/40436769/712005
    EasyDebounce.debounce('authStateChange', Duration(milliseconds: 200),
        () async {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        try {
          await user.sendEmailVerification();
          Get.snackbar(
            'Please verify email address',
            'We have sent you an email, please check your email app',
            snackPosition: SnackPosition.BOTTOM,
          );
          // TODO: not open app? Only when verified?
        } catch (e) {
          print(e);
        }
      }
      try {
        token.value = await _firebaseUser?.value?.getIdToken() ?? '';
      } catch (e) {
        Get.snackbar(
          'Error getting id token',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      //print('authController, token: ${token.value}');
      activeUserEmail.value = _firebaseUser?.value?.email ?? '';
      setActiveUserHasAccount();
      if (_firebaseUser?.value?.email != null) {
        Store? store = isar.stores.getSync(1);
        List<String> initialRoute = ['/'];
        if (isLoggedIn) {
          if (store?.url?[0] != null && store?.url?[0] != '/login/') {
            initialRoute = store?.url as List<String>;
          } else {
            initialRoute = ['/projects/'];
          }
        }
        url.value = initialRoute;
        editingProject.value = store?.editingProject ?? '';
        if (!storeInitialized.value) storeInitialized.value = true;
        setActiveCUser();
        // initialize sync with db server and files
        syncController = SyncController();
        Get.put(syncController); // only needed if manual sync is added
        syncController.init();
      }
    });
  }

  Future<void> reloadData(BuildContext context) async {
    await checkOperationsThenRun(
        context: context,
        run: () async {
          await emptyIsar();
          await syncController.serverQueryController.fetch();
          Navigator.pop(context);
        });
    return;
  }

  Future<void> emptyIsar() async {
    try {
      await isar.writeTxn((isar) async {
        dynamic rowIds = await isar.crows.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(rowIds));
        dynamic fileIds = await isar.cfiles.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(fileIds));
        dynamic fieldIds = await isar.fields.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(fieldIds));
        dynamic tableIds =
            await isar.ctables.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(tableIds));
        dynamic projectIds =
            await isar.projects.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(projectIds));
        dynamic projectUserIds =
            await isar.projectUsers.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(projectUserIds));
        dynamic userIds = await isar.cUsers.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(userIds));
        dynamic accountIds =
            await isar.accounts.where().isarIdProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(accountIds));
        dynamic dbOperationIds =
            await isar.dbOperations.where().idProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(dbOperationIds));
        dynamic fileOperationIds =
            await isar.fileOperations.where().idProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(fileOperationIds));
        dynamic storeIds = await isar.stores.where().idProperty().findAll();
        await isar.crows.deleteAll(List<int>.from(storeIds));
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error deleting local data',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return;
  }

  void logMeOut(BuildContext context) async {
    Navigator.pop(context);
    // tried different solution deleting isar folder
    // but it resultet in app crash
    // https://github.com/isar/isar/discussions/74#discussioncomment-623306
    await emptyIsar();
    // this does not help as the navigation to welcome
    // closes the snackbar immediately
    // Get.snackbar(
    //   'local data removed successfully',
    //   '',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar(
        'Error logging out',
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error logging out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setActiveCUser() {
    CUser? cuser = isar.cUsers
        .where()
        .filter()
        .emailEqualTo(_firebaseUser?.value?.email)
        .findFirstSync();
    if (cuser != null) activeCUser.value = cuser;
  }

  void setActiveUserHasAccount() {
    String? accountId = isar.cUsers
        .where()
        .filter()
        .emailEqualTo(activeUserEmail.value)
        .accountIdProperty()
        .findFirstSync();
    activeUserHasAccount.value = accountId != null;
  }

  void createUser(String email, String password, BuildContext context) async {
    final progress = ProgressHUD.of(context)!;
    progress.show();
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // create user in db
      CUser user = CUser(
        email: email,
        // uid is long lived firebase authentication session = refresh token
        // https://firebase.google.com/docs/auth/admin/manage-sessions
        authId: userCredential.user?.uid,
      );
      await user.save();
      Uri url =
          Uri.parse('${authUri}/add-hasura-claims/${userCredential.user?.uid}');
      // This call makes firebase add hasura user claims
      // to the header of each network call (setCustomUserClaims)
      // which enables authenticated calls to the backend
      // These claims (ID token) are valid for only one hour
      // How does this work?
      // It seems that the backend sends the user claims to a firebase server
      // and client side firebase fetches them from there
      var response = await get(url);
      if (response.statusCode != 200) {
        return Get.snackbar(
          'Error logging in',
          response.body,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error creating account',
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    progress.dismiss();
    // use off so when user backs up, gets to welcome instead
    Get.off(() => ProjectsContainer());
  }

  void login(String email, String password, BuildContext context) async {
    final progress = ProgressHUD.of(context)!;
    progress.show();
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Uri url =
          Uri.parse('${authUri}/add-hasura-claims/${userCredential.user?.uid}');
      var response = await get(url);
      if (response.statusCode != 200) {
        return Get.snackbar(
          'Error logging in',
          response.body,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error logging in',
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    progress.dismiss();
    // use off so when user backs up, gets to welcome instead
    Get.off(() => ProjectsContainer());
  }

  void reLogin() async {
    // got errors: code: 'auth/quota-exceeded', message: 'Operation too fast.'
    // probably because every subscription would call this
    EasyDebounce.debounce(
      'authStateChange',
      Duration(milliseconds: 500),
      () async {
        print(
            'auth, reLogin. User\'s uid from store: ${activeCUser.value.authId}');
        if ((activeCUser.value.authId) == null) {
          // need to log in
          Get.off(() => LoginWidget());
        }
        try {
          Uri url = Uri.parse(
              '${authUri}/add-hasura-claims/${activeCUser.value.authId}');
          var response = await get(url);
          print('auth, reLogin. response.body: ${response.body}');
          print('auth, reLogin. response.statusCode: ${response.statusCode}');
          if (response.statusCode != 200) {
            Get.snackbar(
              'Error logging in',
              response.body,
              snackPosition: SnackPosition.BOTTOM,
            );
            return Get.off(() => LoginWidget());
          }
        } on FirebaseAuthException catch (e) {
          Get.snackbar(
            'Error logging in',
            e.message ?? '',
            snackPosition: SnackPosition.BOTTOM,
          );
          return Get.off(() => LoginWidget());
        }
      },
    );
  }

  Future<void> checkOperationsThenRun({
    required BuildContext context,
    required Function run,
  }) async {
    // need to empty isar to:
    // 1. empty Store (url etc.)
    // 2. prevent next user from seing data not allowed
    // so check if operations queue is empty
    // if not: ask user if he wants to empty it AND POTENTIALLY LOOSE DATA
    int dbOperationsCount = await isar.dbOperations.where().count();
    //int dbOperationsCount = 2;
    int fileOperationsCount = await isar.fileOperations.where().count();
    if (dbOperationsCount > 0 || fileOperationsCount > 0) {
      // ask user if he wants to empty it AND POTENTIALLY LOOSE DATA
      // TODO: offer ui to manage operations
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Text('$dbOperationsCount outstanding operations'),
              SizedBox(width: 8),
              Icon(Icons.warning, color: Colors.red),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'When you edit data the change is immediately written to your device.'),
              SizedBox(height: 8),
              Text('An operation is created to sync it to our servers.'),
              SizedBox(height: 8),
              Text(
                  'Usually operations sync as soon as your device is (re-)connected to the internet.'),
              SizedBox(height: 8),
              Text(
                  'We remove your local data on logout to ensure the next person logging in can\'t see it!'),
              SizedBox(height: 8),
              Text('Thus if you log out now, you will loose unsynced data.'),
              SizedBox(height: 8),
              Text(
                  'We suggest cancelling and waiting for a successfull sync before logging out.'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Purge operations and go on'),
              onPressed: () {
                run();
              },
            ),
          ],
        ),
      );
    } else {
      run();
    }
  }

  Future<void> logOut(context) async {
    checkOperationsThenRun(
      context: context,
      run: () => logMeOut(context),
    );
  }

  void sendPasswordResetEmail() {
    try {
      _auth.sendPasswordResetEmail(email: _firebaseUser?.value?.email ?? '');
    } catch (e) {
      Get.snackbar(
        'Error sending password reset email',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
