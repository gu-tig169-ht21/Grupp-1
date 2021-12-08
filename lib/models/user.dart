import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';

class UserModel {
  String id;
  String email;

  UserModel({required this.id, this.email = ''});
}

class UserState extends ChangeNotifier {
  User? user;
  bool _isSignedIn = false;

  AuthService _auth = AuthService();

  User? get users => user;
  bool get isSignedIn => _isSignedIn;

  //Logga in
  void signIn(email, password) async {
    User? result = await _auth.signIn(email, password);
    user = result;
    print(user);
    print("State");

    notifyListeners();
  }

// Logga ut

  void signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  void signedIn({required bool value}) {
    _isSignedIn = value;
  }
}
