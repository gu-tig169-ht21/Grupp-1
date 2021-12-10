import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';

class GameUI extends StatelessWidget {
  const GameUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = ['Hej', 'Då', 'Re', 'Hejdå'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Press me!'),
          )
        ],
        title:
            Text('Quiz Master', style: Theme.of(context).textTheme.headline1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          headerWidget(context),
          questionWidget(context),
          answerWidgets(context, list),
        ],
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
            'Category: Sport',
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

  Widget questionWidget(context) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 20,
            color: Colors.orangeAccent,
          ),
        ),
        child: Text(
          'What is the air speed velocity of an unladen swallow?',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget answerWidgets(context, list) {
    return Consumer<QuizModel>(
      builder: (context, state, child) => ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: ListTile(
              leading: Text('Index'),
              title: Text('Answer'),
              onTap: () => Provider.of(context, listen: false).doSomething,
            ),
          );
        },
      ),
    );
  }
}
