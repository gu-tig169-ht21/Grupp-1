import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/screens/home/profile.dart';
import 'package:quizapp/screens/quiz/game_score.dart';
import 'package:quizapp/screens/quiz/new_game.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/quiz_service.dart';
import 'package:quizapp/services/user_service.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    QuizModel _model = QuizModel();
    var state = Provider.of<QuizModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title:
              Text('Quiz Master', style: Theme.of(context).textTheme.headline1),
          actions: [
            TextButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: Icon(Icons.person, color: Colors.orange),
                label: Text('Profile', style: TextStyle(color: Colors.orange))),
            TextButton.icon(
                onPressed: () => _auth.signOut(),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text('Log out', style: TextStyle(color: Colors.white))),
          ],
        ),
        body: Container(
            child: Column(
          children: [
            textButtonFormat(context, 'New Game', NewGame()),
            textButtonFormat(context, 'Highscore', Highscore()),
            textButtonFormat(context, 'GameScore', GameScore()),
          ],
        )));
  }

  Widget textButtonFormat(context, String title, var screen) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(
                40,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen));
            },
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
