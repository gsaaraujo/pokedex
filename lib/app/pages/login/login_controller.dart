import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/services/auth_services.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn google = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isAuthFailed = false;
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    try {
      isLoading = true;

      isAuthFailed = false;
      notifyListeners();

      await AuthServices(_auth, google, _firestore).signInWithGoogle();
    } catch (e) {
      isAuthFailed = true;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
