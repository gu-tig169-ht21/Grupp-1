import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/services/quiz_service.dart';

class Question {
  String category;
  String type;
  String difficulty;
  String question;
  String correct_answer;
  List<dynamic> incorrect_answers;
  List<String> answers = [];

  Question(
      {required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.correct_answer,
      required this.incorrect_answers});

  // Converting from json to a question object
  static Question fromJson(dynamic json) {
    return Question(
        category: json['category'],
        type: json['type'],
        difficulty: json['difficulty'],
        question: json['question'],
        correct_answer: json['correct_answer'],
        incorrect_answers:
            (json['incorrect_answers'] as List).map((map) => map).toList());
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{${category} and ${question} +Fel  ${incorrect_answers[0]}, Fel ${incorrect_answers[1]}, Fel ${incorrect_answers[2]}, Rätt ${correct_answer}}";
  }
}

class QuizModel extends ChangeNotifier {
  //List of Question objects
  List<Question> questionList = [];
  int _points = 0;
  Color newColor = Colors.grey;

  //Data from user for type of quiz to API
  String pickedCategory = 'Slumpa';
  var categoryList = ['Slumpa', 'Sports', 'Animals'];
  String? pickedDifficulty = 'Easy';
  var difficultyList = ['Easy', 'Medium', 'Hard'];

  //Getter for list
  List<Question> get getQuizList => questionList;
  int get points => _points;
  Color get newColors => newColor;

//Method to try choicePicker.
  void playGame() {
    print("{Categori: ${pickedCategory}, Difficulty: ${pickedDifficulty}}");
  }

//Metod för att anropa service
  Future<void> getQuiz() async {
    questionList = await QuizService.getQuiz();

    for (var item in questionList) {
      item.answers.add(item.correct_answer);

      for (var i = 0; i < item.incorrect_answers.length; i++) {
        item.answers.add(item.incorrect_answers[i]);
      }
    }

    for (var item in questionList) {
      print(item.answers.toString());
    }

//Reset for new game
    counter = 0;
    _points = 0;
    newColor = Colors.black;
  }

//////////////////////////GAME LOGIC//////////////////////
  ///
  ///

//Index for consumer
  int counter = 0;
  Question game() {
    //notifyListeners();
    return questionList[counter];
  }

  void nextQuestion(String value) async {
    if (value == questionList[counter].correct_answer) {
      _points = _points + 1;
      newColor = Colors.green;
    } else {
      newColor = Colors.red;
    }

    print(_points);
    counter++;

    await Future.delayed(const Duration(seconds: 2));

//Timer
    //game();

    notifyListeners();

/*
    if (counter == questionList.length) {
      counter = 0;
      notifyListeners();
    }

    */
  }
}
