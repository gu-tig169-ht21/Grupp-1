import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:quizapp/models/quiz.dart';

class InitGame extends StatelessWidget {
  const InitGame();

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) =>
          state.startGameCountDown > 4 ? countDown(state) : getReady(),
    );
  }

  Widget getReady() {
    return Align(
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            'GET READY',
            textStyle: const TextStyle(
              fontSize: 40,
              fontFamily: 'Horizon',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        totalRepeatCount: 5,
      ),
    );
  }

  Widget countDown(state) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          ScaleAnimatedText(
            '${state.startGameCountDown}',
            duration: const Duration(seconds: 1),
            textStyle: const TextStyle(
              fontSize: 40,
              fontFamily: 'Horizon',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
