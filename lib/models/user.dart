import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';

//Model for Authenticated user
class AuthUser {
  String uid;

  AuthUser({required this.uid});
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
}
