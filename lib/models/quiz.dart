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

enum GameState { ready, init, showQuestion, ShowColors, QuizDone }

class QuizModel extends ChangeNotifier {
  //List of Question objects
  List<Question> questionList = [];
  int _points = 0;

  int currentQuestionIndex = 0;
  Timer? nextQuestionTimer;
  Timer? questionTimer;
  late int _timeCounter;
  late int _nextQuestionCounter;

  GameState _gameState = GameState.ready;
  GameState get gameState => _gameState;

  void setGameState(GameState state) {
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
  int get nextQuestionCounter => _nextQuestionCounter;
  int get getcurrentQuestionIndex => currentQuestionIndex;

//Method to get Quiz
  Future<void> getQuiz() async {
    questionList = await QuizService.getQuiz();

    for (var item in questionList) {
      item.answers.add(item.correct_answer);

      for (var i = 0; i < item.incorrect_answers.length; i++) {
        item.answers.add(item.incorrect_answers[i]);
      }
      item.answers.shuffle();
    }

    //Reset for new game
    currentQuestionIndex = 0;
    _points = 0;

    initCountDown();
  }

//////////////////////////GAME LOGIC//////////////////////

//Set Colors for Right and Wrong Ansers
  Color? setColor(int index) {
    if (_gameState == GameState.ShowColors) {
      var question = questionList[currentQuestionIndex];

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

  Question getQuestion() {
    return questionList[currentQuestionIndex];
  }

  void checkAnswer(String value) {
    _timeCounter = 0;
    questionTimer?.cancel();
    _nextQuestionCountDown();

    if (value == questionList[currentQuestionIndex].correct_answer) {
      _points += 1;
    }
    setGameState(GameState.ShowColors);

    notifyListeners();
  }

  void nextQuestion() {
    currentQuestionIndex++;

    setGameState(GameState.showQuestion);
    notifyListeners();
  }

//Init countDown for user to Get ready
  void initCountDown() {
    int countDown = 3;
    const oneSec = const Duration(seconds: 1);
    Timer timer = Timer.periodic(oneSec, (timer) {
      if (countDown == 0) {
        timer.cancel();
        setGameState(GameState.showQuestion);
        _countDown(); // Activates counter for questions
      } else {
        countDown--;
      }
    });
  }

  void _countDown() {
    _timeCounter = 10;
    questionTimer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (Timer timer) {
      if (_timeCounter == 0) {
        questionTimer?.cancel();
        setGameState(GameState.ShowColors);
        _nextQuestionCountDown();
      } else if (questionList.length == currentQuestionIndex) {
        questionTimer?.cancel();
        setGameState(GameState.ready);
      } else {
        _timeCounter--;
      }
      notifyListeners();
    });
  }

  void _nextQuestionCountDown() {
    _nextQuestionCounter = 5;
    nextQuestionTimer = Timer.periodic(
        Duration(
          seconds: 1,
        ), (timer) {
      if (_nextQuestionCounter == 0 &&
          (currentQuestionIndex - 1) < questionList.length) {
        nextQuestion();
        nextQuestionTimer?.cancel();
        _nextQuestionCounter = 5;
        _timeCounter = 5;
        _countDown();
      } else if (questionList.length == currentQuestionIndex) {
        nextQuestionTimer?.cancel();
        setGameState(GameState.ready);
      } else {
        _nextQuestionCounter--;
      }
      notifyListeners();
    });
  }
}
