import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/models/user_model.dart';

class AuthServices {
  final FirebaseAuth auth;

  AuthServices(this.auth);

  Stream<UserModel?> authStateChanges() {
    return auth.authStateChanges().map((user) {
      if (user != null) {
        return UserModel(
            uid: user.uid, name: user.displayName, photoURL: user.photoURL);
      }

      return null;
    });
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        throw Exception('Error: $e');
      }
    }
  }
}
