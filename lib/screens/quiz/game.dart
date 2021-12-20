import 'package:flutter/material.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/screens/quiz/game_score.dart';
import 'package:quizapp/screens/quiz/init_game.dart';

class GameUI extends StatelessWidget {
  GameUI({Key? key}) : super(key: key);
  String selected = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => state.currentQuestionIndex ==
              state.questionList.length
          ? const GameScore()
          : Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Quiz Master',
                    style: Theme.of(context).textTheme.headline1),
              ),
              body: state.gameState == GameState.init
                  ? const InitGame()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        headerWidget(context),
                        progressIndicator(context),
                        question(context),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.getQuestion().answers.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: ListTile(
                                  title: Text(
                                    HtmlCharacterEntities.decode(
                                        state.getQuestion().answers[index]),
                                  ),
                                  tileColor: state.setColor(index),
                                  onTap: () {
                                    state.timeCounter != 0
                                        ? state.checkAnswer(
                                            state.getQuestion().answers[index])
                                        : null;
                                  },
                                ),
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          timerWidget(context),
          questionIndexWidget(context),
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
      } else if (state.getcurrentQuestionIndex + 1 ==
          state.getQuizList.length) {
        return Text('Loading Score: ${state.nextQuestionCounter}');
      } else {
        return Text('Next Question: ${state.nextQuestionCounter}');
      }
    }

    return setText();
  }

  Widget progressIndicator(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 10,
          width: 300,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
            value: state.timeCounter / 30,
            valueColor: state.timeCounter >= 20
                ? const AlwaysStoppedAnimation<Color>(Colors.green)
                : state.timeCounter >= 10
                    ? const AlwaysStoppedAnimation<Color>(Colors.yellow)
                    : const AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
      ),
    );
  }

  Widget questionIndexWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Text(
        "Question: ${state.getcurrentQuestionIndex + 1} of ${state.getQuizList.length}",
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget scoreWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Text(
        'Points: ${state.points}',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget question(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            HtmlCharacterEntities.decode(state.getQuestion().question),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
