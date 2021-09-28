import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex/app/repositories/user_repository/user_repository_interface.dart';

class UserRepository implements IUserRepositoryInterface {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserRepository(this.firestore, this.auth);

  @override
  Future<void> createUserIfNotExists() async {
    final users = firestore.collection('users');
    final currentUser = auth.currentUser;

    if (currentUser != null) {
      users.doc(currentUser.uid).set({'favorites': []});
    }
  }
}
