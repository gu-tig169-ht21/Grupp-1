import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:confetti/confetti.dart';
import 'package:quizapp/screens/shared/loading.dart';
import 'package:quizapp/services/user_service.dart';

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

  bool? newHighScore;
  int currentHigh = 0;

  Future<bool?> saveScore(String id, int points) async {
    // int currentHighScore = await getCurrentHighScore(id);
    if (newHighScore == null) {
      currentHigh = await getCurrentHighScore(id);
    }

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
    String id = stateUser.uid;

    return Consumer<QuizModel>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title:
              Text('Gamescore', style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: saveScore(id, state.points),
          builder: (context, newHigh) {
            if (newHigh.data == true) {
              return newHighscoreView(state.points, currentHigh);
            } else if (newHigh.data == null) {
              return const Loading();
            } else {
              return noNewHighscoreView(state.points, currentHigh);
            }
          },
        ),
      ),
    );
  }

  Widget newHighscoreView(var newHighscore, var currentScore) {
    const colorizeColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.white,
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 40.0,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          confetti(),
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText('NEW HIGHSCORE!',
                  speed: const Duration(seconds: 1),
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors)
            ],
            totalRepeatCount: 5,
          ),
          Container(height: 15),
          const Icon(
            Icons.emoji_emotions,
            size: 170,
          ),
          ListTile(
            title: const Text("Points received & your new highscore: ",
                style: TextStyle(fontSize: 20)),
            subtitle:
                Text("$newHighscore p", style: const TextStyle(fontSize: 15)),
          ),
          ListTile(
            title:
                const Text("Previous score: ", style: TextStyle(fontSize: 20)),
            subtitle:
                Text("$currentScore p", style: const TextStyle(fontSize: 15)),
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
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'No new highscore...',
                speed: const Duration(milliseconds: 150),
                textStyle: const TextStyle(
                    fontSize: 35,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold),
              ),
              TypewriterAnimatedText(
                'Good luck next time.',
                speed: const Duration(milliseconds: 150),
                textStyle: const TextStyle(
                    fontSize: 35,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(height: 15),
          const Icon(
            Icons.thumb_down,
            size: 170,
          ),
          ListTile(
            title: const Text(
              "Points received: ",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              "$points p",
              style: const TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: const Text(
              "Current highscore: ",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              "$currentScore p",
              style: const TextStyle(fontSize: 15),
            ),
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
  }
}
