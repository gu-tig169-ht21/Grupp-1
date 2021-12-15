import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/screens/home/home.dart';
import 'package:quizapp/screens/quiz/game_score.dart';

class GameUI extends StatelessWidget {
  GameUI({Key? key}) : super(key: key);
  String selected = "";

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizModel>(context, listen: false);
    bool selected = false;
    return Consumer<QuizModel>(
      builder: (context, state, child) => state.currentQuestionIndex ==
              state.questionList.length
          ? GameScore()
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                actions: [
                  TextButton(
                    onPressed: () async {
                      await state.getQuiz();
                    },
                    child: Text('Press me!'),
                  )
                ],
                title: Text('Quiz Master',
                    style: Theme.of(context).textTheme.headline1),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  headerWidget(context),
                  Text(state.game().question),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.game().answers.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: ListTile(
                              title: Text(state.game().answers[index]),
                              tileColor: state.setColor(index),
                              onTap: () {
                                state.timeCounter != 0
                                    ? state.checkAnswer(
                                        state.game().answers[index])
                                    : null;
                              }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget headerWidget(context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          timerWidget(context),
          categoryWidget(context),
          scoreWidget(context),
        ],
      ),
    );
  }

  Widget timerWidget(context) {
    var state = Provider.of<QuizModel>(context, listen: false);

    Text setText() {
      if (state.timeCounter != 0) {
        return Text('Time left: ${state.timeCounter}');
      } else if (state.gameState == GameState.QuizDone) {
        return Text('Your score: ${state.newGameCounter}');
      } else {
        return Text('Next Question: ${state.newGameCounter}');
      }
    }

    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: setText(),
          //style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget categoryWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            state.pickedCategory,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget scoreWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Points: ${state.points}',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
