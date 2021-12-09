import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';

class GameUI extends StatelessWidget {
  const GameUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        children: [
          headerWidget(),
          questionWidget(),
          answerWidgets('???'),
          answerWidgets('European or African?'),
          answerWidgets('Hoppas ni fattar referensen'),
          answerWidgets('Något annat'),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              'Time: 28',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            child: Text(
              'Kategori: Sport',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            child: Text(
              'Score: 150',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget questionWidget() {
    return Container(
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
    );
  }

  Widget answerWidgets(text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          child: Text(text),
          style: ElevatedButton.styleFrom(
            primary: Colors.orangeAccent,
          ),
          onPressed: () {
            print(text);
          },
        ),
      ),
    );
  }
}
