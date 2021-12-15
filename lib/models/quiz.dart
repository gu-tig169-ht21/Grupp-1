import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/quiz_service.dart';
import 'dart:async';

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
  Color colors = Colors.grey;

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
}

enum GameState { None, IsPlaying, ShowColors, QuizDone }

class QuizModel extends ChangeNotifier {
  //List of Question objects
  List<Question> questionList = [];
  int _points = 0;

  int counter = 0;
  Timer? nextQuestionTimer;
  Timer? questionTimer;
  var _timeCounter = 5;
  var _newGameCounter = 5;

  GameState _gameState = GameState.None;
  GameState get gameState => _gameState;

  void _setGameState(GameState state) {
    _gameState = state;
    notifyListeners();
  }

  //Data from user for type of quiz to API
  String pickedCategory = 'Slumpa';
  var categoryList = ['Slumpa', 'Sports', 'Animals'];
  String? pickedDifficulty = 'Easy';
  var difficultyList = ['Easy', 'Medium', 'Hard'];

  //Getter for list
  List<Question> get getQuizList => questionList;

  int get points => _points;
  int get timeCounter => _timeCounter;
  int get newGameCounter => _newGameCounter;

//Metod för att anropa service
  Future<void> getQuiz() async {
    questionList = await QuizService.getQuiz();
    _setGameState(GameState.IsPlaying);
    _countDown();

    for (var item in questionList) {
      item.answers.add(item.correct_answer);

      for (var i = 0; i < item.incorrect_answers.length; i++) {
        item.answers.add(item.incorrect_answers[i]);
      }
      item.answers.shuffle();
    }

//Reset for new game
    counter = 0;
    _points = 0;
    _setGameState(GameState.IsPlaying);
  }

//////////////////////////GAME LOGIC//////////////////////

//Set Colors for Right and Wrong Ansers
  Color? setColor(int index) {
    if (_gameState == GameState.ShowColors) {
      var question = questionList[counter];

      String currentIndex = question.answers[index];

      if (currentIndex == question.correct_answer) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }

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
      _setGameState(GameState.ShowColors);
    } else {
      _setGameState(GameState.ShowColors);
    }

    notifyListeners();
  }

  void nextQuestion() {
    counter++;

    if (questionList.length == counter) {
      _setGameState(GameState.QuizDone);
      notifyListeners();
    } else {
      _setGameState(GameState.IsPlaying);
      notifyListeners();
    }
  }

  void _countDown() {
    questionTimer = Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer timer) {
      if (_timeCounter == 0) {
        questionTimer?.cancel();
        _setGameState(GameState.ShowColors);
        _nextQuestionCountDown();
      } else if (questionList.length == counter) {
        questionTimer?.cancel();
        _setGameState(GameState.QuizDone);
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
        nextQuestion();
        nextQuestionTimer?.cancel();
        _newGameCounter = 5;
        _timeCounter = 5;
        _countDown();
      } else if (questionList.length == counter) {
        nextQuestionTimer?.cancel();
        _setGameState(GameState.QuizDone);
      } else {
        _newGameCounter--;
      }
      notifyListeners();
    });
  }
}
