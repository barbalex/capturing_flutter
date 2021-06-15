// see: https://www.youtube.com/watch?v=-H-T_BSgfOE (Firebase Auth with GetX | Todo App)
import 'package:capturing/models/store.dart';
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

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?>? _firebaseUser = Rx<User?>(null);
  Rx<String?> token = Rx<String?>(null);
  final Isar isar = Get.find<Isar>();

  Rx<User?>? get user => _firebaseUser;
  String? get userEmail => _firebaseUser?.value?.email;
  bool get isLoggedIn => _firebaseUser?.value != null;

  @override
  void onInit() {
    super.onInit();
    // make _firebaseUser update when auth state changes
    _firebaseUser?.bindStream(_auth.authStateChanges());
    FirebaseAuth.instance.authStateChanges().listen(onAuthStateChanges);
  }

  Future<Rx<String?>> onAuthStateChanges(event) async {
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
    print('auth controller, onAuthStateChanges, 1');
    try {
      token.value = await _firebaseUser?.value?.getIdToken() ?? '';
    } catch (e) {
      Get.snackbar(
        'Error getting id token',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    print('auth controller, onAuthStateChanges, 2, token: ${token.value}');
    activeUserEmail.value = _firebaseUser?.value?.email ?? '';
    print(
        'auth controller, onAuthStateChanges, 3, activeUserEmail: ${activeUserEmail.value}');
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
      final SyncController syncController = SyncController();
      Get.put(syncController); // only needed if manual sync is added
      syncController.init();
    }

    return token;
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
        authId: userCredential.user?.uid,
      );
      await user.save();
      // TODO: call add-hasura-claims
      //print('auth controller, userCredential: ${userCredential}');
      Uri url =
          Uri.parse('${authUri}/add-hasura-claims/${userCredential.user?.uid}');
      //print('auth controller, uid: ${userCredential.user?.uid}');
      var response = await get(url);
      if (response.statusCode != 200) {
        //print('http response status: ${response.statusCode}');
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
    print('auth controller, login, 1');
    final progress = ProgressHUD.of(context)!;
    print('auth controller, login, 2');
    progress.show();
    print('auth controller, login, 3');
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //print('auth controller, userCredential: ${userCredential}');
      Uri url =
          Uri.parse('${authUri}/add-hasura-claims/${userCredential.user?.uid}');
      //print('auth controller, uid: ${userCredential.user?.uid}');
      var response = await get(url);
      if (response.statusCode != 200) {
        //print('http response status: ${response.statusCode}');
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
    print('auth controller, login, 4');
    progress.dismiss();
    print('auth controller, login, 5');
    // use off so when user backs up, gets to welcome instead
    Get.off(() => ProjectsContainer());
    print('auth controller, login, 6');
  }

  void logOut(context) async {
    // TODO:
    // need to empty isar to:
    // 1. empty Store (url etc.)
    // 2. prevent next user from seing data not allowed
    // so check if operations queue is empty
    // if not: ask user if he wants to empty it AND POTENTIALLY LOOSE DATA
    //int dbOperationsCount = await isar.dbOperations.where().count();
    int fileOperationsCount = await isar.fileOperations.where().count();
    int dbOperationsCount = 2;
    if (dbOperationsCount > 0 || fileOperationsCount > 0) {
      // TODO:
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
              child: Text('Purge operations and log out'),
              onPressed: () async {
                Navigator.pop(context);
                // tried different solution deleting isar folder
                // but it resultet in app crash
                // https://github.com/isar/isar/discussions/74#discussioncomment-623306
                try {
                  await isar.writeTxn((isar) async {
                    dynamic rowIds =
                        await isar.crows.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(rowIds));
                    dynamic fileIds =
                        await isar.cfiles.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(fileIds));
                    dynamic fieldIds =
                        await isar.fields.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(fieldIds));
                    dynamic tableIds =
                        await isar.ctables.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(tableIds));
                    dynamic projectIds =
                        await isar.projects.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(projectIds));
                    dynamic projectUserIds = await isar.projectUsers
                        .where()
                        .isarIdProperty()
                        .findAll();
                    await isar.crows.deleteAll(List<int>.from(projectUserIds));
                    dynamic userIds =
                        await isar.cUsers.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(userIds));
                    dynamic accountIds =
                        await isar.accounts.where().isarIdProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(accountIds));
                    dynamic dbOperationIds =
                        await isar.dbOperations.where().idProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(dbOperationIds));
                    dynamic fileOperationIds = await isar.fileOperations
                        .where()
                        .idProperty()
                        .findAll();
                    await isar.crows
                        .deleteAll(List<int>.from(fileOperationIds));
                    dynamic storeIds =
                        await isar.stores.where().idProperty().findAll();
                    await isar.crows.deleteAll(List<int>.from(storeIds));
                  });
                } catch (e) {
                  print(e);
                  Get.snackbar(
                    'Error deleting local data',
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }
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
              },
            ),
          ],
        ),
      );
    }
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
