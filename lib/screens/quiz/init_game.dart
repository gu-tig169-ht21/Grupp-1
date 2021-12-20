// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:quizapp/models/quiz.dart';

class InitGame extends StatelessWidget {
  const InitGame();

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => getReady(),
    );
  }

  Widget getReady() {
    return Align(
      child: AnimatedTextKit(
        isRepeatingAnimation: true,
        animatedTexts: [
          FadeAnimatedText(
            'GET READY',
            textStyle: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        totalRepeatCount: 5,
      ),
    );
  }
}
