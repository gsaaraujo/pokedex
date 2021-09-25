import 'dart:convert';

class UserModel {
  final String uid;
  final String? name;
  final String? photoURL;

  UserModel({
    required this.uid,
    required this.name,
    required this.photoURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'photoURL': photoURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
