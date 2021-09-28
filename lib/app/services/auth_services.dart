import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/models/user_model.dart';
import 'package:pokedex/app/repositories/user_repository/user_repository.dart';

class AuthServices {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthServices(this._auth, this._googleSignIn, this._firestore);

  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      if (user != null) {
        return UserModel(
            uid: user.uid, name: user.displayName, photoURL: user.photoURL);
      }

      return null;
    });
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        await UserRepository(_firestore, _auth).createUserIfNotExists();
      } catch (e) {
        throw Exception('Error: $e');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
