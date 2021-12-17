import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:confetti/confetti.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/services/user_service.dart';
import '';

class GameScore extends StatefulWidget {
  const GameScore({Key? key}) : super(key: key);

  @override
  State<GameScore> createState() => _GameScoreState();
}

class _GameScoreState extends State<GameScore> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Future<int> getCurrentHighScore(String id) async {
    var userData = await UserService(uid: id).getUserData();
    return userData["HighScore"];
  }

  bool? newHighScore = null;
  late int currentHigh;

  Future<bool?> saveScore(String id, int points) async {
    // int currentHighScore = await getCurrentHighScore(id);
    currentHigh = await getCurrentHighScore(id);
    print(currentHigh);
    //Save HighScore only if Score is bigger than current
    if (points > currentHigh) {
      UserService(uid: id).updateHighScore(points);
      _controllerCenter.play();
      newHighScore = true;
      return newHighScore;
    } else {
      newHighScore = false;
      return newHighScore;
    }
  }

  @override
  Widget build(BuildContext context) {
    var stateUser = Provider.of<AuthUser>(context);
    var quizState = Provider.of<QuizModel>(context, listen: false);
    String id = stateUser.uid;

    return Scaffold(
        appBar: AppBar(
          title:
              Text('Gamescore', style: Theme.of(context).textTheme.headline1),
        ),
        body: FutureBuilder(
          future: saveScore(id, quizState.points),
          builder: (context, newHigh) {
            if (newHigh.data == true) {
              return newHighscoreView(quizState.points, currentHigh);
            } else if (newHighScore == null) {
              return Text("Loading");
            } else {
              return noNewHighscoreView(quizState.points, currentHigh);
              //return newHighscoreView(quizState.points, currentHigh);
            }
          },
        ));
  }

  Widget newHighscoreView(var newHighscore, var currentScore) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          confetti(),
          Text('NEW HIGHSCORE!', style: TextStyle(fontSize: 20)),
          Container(height: 15),
          Icon(
            Icons.emoji_emotions,
            size: 170,
          ),
          ListTile(
            title: Text("Points received & your new highscore: "),
            subtitle: Text("$newHighscore p"),
          ),
          ListTile(
            title: Text("Previous score: "),
            subtitle: Text("$currentScore p"),
          ),
        ],
      ),
    );
  }

  Widget noNewHighscoreView(var points, var currentScore) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('No new highscore...', style: TextStyle(fontSize: 20)),
          Container(height: 15),
          Icon(
            Icons.thumb_down,
            size: 170,
          ),
          ListTile(
            title: Text("Points received: "),
            subtitle: Text("$points p"),
          ),
          ListTile(
            title: Text("Current highscore: "),
            subtitle: Text("$currentScore p"),
          ),
        ],
      ),
    );
  }

  Widget confetti() {
    return ConfettiWidget(
      confettiController: _controllerCenter,
      blastDirectionality: BlastDirectionality.explosive,
      particleDrag: 0.05,
      emissionFrequency: 0.05,
      numberOfParticles: 50,
      gravity: 0.05,
      shouldLoop: false,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ],
    );
  } // manually specify t
}
