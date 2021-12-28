import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';

//Model for Authenticated user
class AuthUser {
  String uid;

  AuthUser({required this.uid});

  @override
  String toString() {
    return uid;
  }
}

class UserData {
  String id;
  String displayName;
  String email;
  String password;
  int? score;

  UserData(
      {this.id = "",
      required this.displayName,
      required this.email,
      this.password = "",
      this.score = 0});
  @override
  String toString() {
    return "$displayName and Score: $score";
  }
}

class UserState extends ChangeNotifier {
  final AuthService _auth = AuthService();

  //Register new User
  Future register(UserData user) async {
    return await _auth.registerWithWEmail(user);
  }

  //Sign In With email
  Future signIn(email, password) async {
    return await _auth.signIn(email, password);
  }

  // Logga ut
  void signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
