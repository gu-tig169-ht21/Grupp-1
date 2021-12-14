import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/user_service.dart';

//Model for Authenticated user
class AuthUser {
  final String uid;

  AuthUser({required this.uid});
}

class UserData {
  String id;
  String displayName;
  String email;
  String password;
  int? score;

  UserData(
      {required this.id,
      required this.displayName,
      required this.email,
      this.password = "",
      this.score = 0});
  @override
  String toString() {
    // TODO: implement toString
    return "$displayName and Score: $score";
  }
}

class UserState extends ChangeNotifier {
  final AuthService _auth = AuthService();

  //Register new User
  void register(UserData user) async {
    await _auth.registerWithWEmail(user);
    notifyListeners();
  }

  //Sign In With email
  void signIn(email, password) async {
    User? result = await _auth.signIn(email, password);

    //notifyListeners();
  }

  // Logga ut
  void signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
