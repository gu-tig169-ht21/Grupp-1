import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/screens/home/profile.dart';
import 'package:quizapp/screens/quiz/new_game.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/quiz_service.dart';

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
              onPressed: () => _auth.signOut(),
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Log out', style: TextStyle(color: Colors.white))),
          TextButton.icon(
              onPressed: () => state.getQuiz(),
              icon: Icon(Icons.quiz, color: Colors.orange),
              label: Text('Get Quiz', style: TextStyle(color: Colors.orange))),
        ],
      ),
      body: Consumer<QuizModel>(builder: (context, state, child) {
        List<Question> quizList = state.getQuizList;
        return Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewGame()));
              },
              child: Text("New Game"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Text("Profile"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Highscore()));
              },
              child: Text("Highscore"),
            )
          ],
        );
      }),
    );
  }
}
