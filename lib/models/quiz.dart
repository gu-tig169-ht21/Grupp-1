import 'package:flutter/material.dart';
import 'package:quizapp/services/quiz_service.dart';
import 'dart:async';

enum GameState {
  None,
  IsPlaying,
  AnsweredCorrectly,
  AnsweredInCorrectly,
}

class Answer {
  bool? isCorrect;

  Answer({required this.isCorrect});
}

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
  Color _color = Colors.grey;

  int counter = 0;
  Timer? nextQuestionTimer;
  Timer? questionTimer;
  var _timeCounter = 10;
  var _newGameCounter = 10;

  //Data from user for type of quiz to API
  String pickedCategory = 'Slumpa';
  var categoryList = ['Slumpa', 'Sports', 'Animals'];
  String? pickedDifficulty = 'Easy';
  var difficultyList = ['Easy', 'Medium', 'Hard'];

  //Getter for list
  List<Question> get getQuizList => questionList;
  Color get colors => _color;
  int get points => _points;
  int get timeCounter => _timeCounter;
  int get newGameCounter => _newGameCounter;

//Method to try choicePicker.
  void playGame() {
    print("{Categori: ${pickedCategory}, Difficulty: ${pickedDifficulty}}");
  }

//Metod för att anropa service
  Future<void> getQuiz() async {
    questionList = await QuizService.getQuiz();
    _countDown();

    for (var item in questionList) {
      item.answers.add(item.correct_answer);

      for (var i = 0; i < item.incorrect_answers.length; i++) {
        item.answers.add(item.incorrect_answers[i]);
      }
      item.answers.shuffle();
    }

    for (var item in questionList) {
      print(item.answers.toString());
    }

//Reset for new game
    counter = 0;
    _points = 0;
  }

//////////////////////////GAME LOGIC//////////////////////

  Question game() {
    //notifyListeners();
    return questionList[counter];
  }

  void checkAnswer(String value) {
    _timeCounter = 0;
    questionTimer?.cancel();
    _nextQuestionCountDown();

    if (value == questionList[counter].correct_answer) {
      _points += 1;
      _color = Colors.green;
    } else {
      _color = Colors.red;
    }
    notifyListeners();

    //nextQuestion();
  }

  void nextQuestion() {
    counter++;
    _color = Colors.grey;
  }

  void _countDown() {
    questionTimer = Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer timer) {
      if (_timeCounter == 0) {
        questionTimer?.cancel();
        _nextQuestionCountDown();
      } else {
        _timeCounter--;
      }
      notifyListeners();
    });
  }

  void _nextQuestionCountDown() {
    nextQuestionTimer = Timer.periodic(
        Duration(
          seconds: 1,
        ), (timer) {
      if (_newGameCounter == 0) {
        _color = Colors.grey;
        nextQuestion();
        nextQuestionTimer?.cancel();
        _newGameCounter = 10;
        _timeCounter = 10;
        _countDown();
      } else {
        _newGameCounter--;
      }
      notifyListeners();
    });
  }
}
