// see: https://www.youtube.com/watch?v=-H-T_BSgfOE (Firebase Auth with GetX | Todo App)
//import 'package:capturing/models/user.dart' as OwnUser;
import 'package:capturing/screens/projects/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:capturing/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:capturing/models/user.dart';

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
    print('auth controller, onAuthStateChanges, 2');
    activeUserEmail.value = _firebaseUser?.value?.email ?? '';
    setActiveCUser();
    setActiveUserHasAccount();
    return token;
  }

  void setActiveCUser() {
    if (_firebaseUser?.value?.email != null) {
      CUser? cuser = isar.cUsers
          .where()
          .filter()
          .emailEqualTo(_firebaseUser?.value?.email)
          .findFirstSync();
      if (cuser != null) activeCUser.value = cuser;
    }
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
      CUser user = CUser(email: email, authId: userCredential.user?.uid);
      await user.save();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error creating account',
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    progress.dismiss();
    // use off so when user backs up, gets to welcome instead
    Get.off(() => Projects());
  }

  void login(String email, String password, BuildContext context) async {
    print('auth controller, login, 1');
    final progress = ProgressHUD.of(context)!;
    print('auth controller, login, 2');
    progress.show();
    print('auth controller, login, 3');
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
    Get.off(() => Projects());
    print('auth controller, login, 6');
  }

  void signOut() {
    try {
      _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error signing out',
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
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
