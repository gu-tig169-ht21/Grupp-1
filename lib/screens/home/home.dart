import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/quiz_service.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    QuizModel _model = QuizModel();
    var state = Provider.of<QuizModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Quiz Master', style: Theme.of(context).textTheme.headline1),
        actions: [
          TextButton.icon(
              onPressed: () => _auth.signOut(),
              icon: Icon(Icons.person),
              label: Text('Log out')),
          TextButton.icon(
              onPressed: () => state.getQuiz(),
              icon: Icon(Icons.person),
              label: Text('Get Quiz')),
        ],
      ),
      body: Consumer<QuizModel>(builder: (context, state, child) {
        List<Question> quizList = state.getQuizList;
        return ListView.builder(
            itemCount: quizList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(quizList[index].question),
                leading: Text(quizList[index].category),
              );
            });
      }),
    );
  }
}
