import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';

class GameScore extends StatefulWidget {
  const GameScore({Key? key}) : super(key: key);

  @override
  State<GameScore> createState() => _GameScoreState();
}

class _GameScoreState extends State<GameScore> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(title: Text("Game Score")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textFieldFormat(state),
          ],
        ));
  }

  Widget textFieldFormat(state) {
    return Align(
      child: Text(
        'Your score: \n ${state.points}',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  int getHighScoreFromDatabase(BuildContext context) {
    return 1;
  }
}
