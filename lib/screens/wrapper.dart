import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/authentication/register.dart';
import 'package:quizapp/screens/authentication/sign_in.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/screens/home/home.dart';
import 'package:quizapp/screens/home/profile.dart';
import 'package:quizapp/screens/quiz/new_game.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser?>(context);

    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
