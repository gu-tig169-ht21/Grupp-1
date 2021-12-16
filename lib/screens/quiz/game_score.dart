import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:confetti/confetti.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/user_service.dart';

class GameScore extends StatefulWidget {
  const GameScore({Key? key}) : super(key: key);

  @override
  State<GameScore> createState() => _GameScoreState();
}

class _GameScoreState extends State<GameScore> {
  late ConfettiController _controllerCenter;

  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var stateUser = Provider.of<AuthUser>(context);
    var state = Provider.of<QuizModel>(context, listen: false);
    String id = stateUser.uid;

    saveScore(id, state.points);
    return Scaffold(
        appBar: AppBar(title: Text("Game Score")),
        body: Container(
          child: Column(
            children: [
              ConfettiWidget(
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
              ),
            ],
          ),
        )); // manually specify t
  }

  void saveScore(String id, int points) {
    UserService(uid: id).updateHighScore(points);
  }
}
