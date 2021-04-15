// see: https://www.youtube.com/watch?v=-H-T_BSgfOE (Firebase Auth with GetX | Todo App)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null);

  String? get userEmail => _firebaseUser.value?.email;
  Rx<User?> get user => _firebaseUser;

  @override
  void onInit() {
    super.onInit();
    // make user update when auth state changes
    _firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
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
