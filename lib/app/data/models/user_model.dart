import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? nik;
  String? password;
  String? role;

  UserModel({this.uid, this.email, this.nik, this.password, this.role});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      email: doc['email'],
      nik: doc['nik'],
      password: doc['password'],
      role: doc['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nik': nik,
      'password': password,
      'role': role
    };
  }
}
