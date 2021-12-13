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

    return Consumer<QuizModel>(
      builder: (context, state, child) => state.counter ==
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
                  Text(state.game().question),
                  ListView.builder(
                    itemCount: state.game().answers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Ink(
                          color: state.newColor,
                          child: ListTile(
                              title: Text(state.game().answers[index]),
                              onTap: () {
                                state.newColor = Colors.blue;
                                state.nextQuestion(state.game().answers[index]);
                              }),
                        ),
                      );
                    },
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timerWidget(context),
          categoryWidget(context),
          scoreWidget(context),
        ],
      ),
    );
  }

  Widget timerWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Text(
            'Time: 28',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'Score: 280',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
