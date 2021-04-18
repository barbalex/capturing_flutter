// see: https://www.youtube.com/watch?v=-H-T_BSgfOE (Firebase Auth with GetX | Todo App)
import 'package:capturing/screens/projects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);
  String token = '';

  String? get userEmail => user.value?.email;
  bool get isLoggedIn => user.value != null;
  //Future<String> get token => _firebaseUser.value?.getIdToken();

  @override
  void onInit() {
    super.onInit();
    // make user update when auth state changes
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  void createUser(String email, String password, BuildContext context) async {
    final progress = ProgressHUD.of(context)!;
    progress.show();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error creating account',
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    progress.dismiss();
    // use off so when user backs up, gets to welcome instead
    Get.off(Projects());
  }

  void login(String email, String password, BuildContext context) async {
    final progress = ProgressHUD.of(context)!;
    progress.show();
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
    progress.dismiss();
    // use off so when user backs up, gets to welcome instead
    Get.off(Projects());
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
}
