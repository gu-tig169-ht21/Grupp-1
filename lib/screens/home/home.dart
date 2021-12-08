import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/quiz_service.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    QuizModel _model = QuizModel();
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Quiz Master', style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
          actions: [
            TextButton.icon(
                onPressed: () => _auth.signOut(),
                icon: Icon(Icons.person),
                label: Text('Log out')),
          ],
        ),
        body: TextButton(
            onPressed: () {
              QuizService.getQuiz();
            },
            child: Text("Hej")));
  }
}
