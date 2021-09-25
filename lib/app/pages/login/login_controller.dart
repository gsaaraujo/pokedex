import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/services/auth_services.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn google = GoogleSignIn();
  bool isAuthFailed = false;
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    try {
      isLoading = true;

      isAuthFailed = false;
      notifyListeners();

      await AuthServices(auth, google).signInWithGoogle();
    } catch (e) {
      isAuthFailed = true;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
