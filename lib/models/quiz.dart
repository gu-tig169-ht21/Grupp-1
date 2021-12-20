import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/auth_service.dart';
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
  late int _startGameCountDown;

  GameState _gameState = GameState.ready;
  GameState get gameState => _gameState;

  void setGameState(GameState state) {
    _gameState = state;
    notifyListeners();
  }

  //Data from user for type of quiz to API
  String pickedCategory = 'Random';
  var categoryList = [
    'Random',
    'Sports',
    'Animals',
    'Movie',
    'Music',
    'Video Games',
    'Geography',
    'Computers'
  ];
  String? pickedDifficulty = 'easy';
  var difficultyList = ['easy', 'medium', 'hard'];

  //Getter for list
  List<Question> get getQuizList => questionList;

  int get points => _points;
  int get timeCounter => _timeCounter;
  int get nextQuestionCounter => _nextQuestionCounter;
  int get startGameCountDown => _startGameCountDown;
  int get getcurrentQuestionIndex => currentQuestionIndex;

//Method to get Quiz
  Future<void> getQuiz() async {
    int categoryId = 0;

    switch (pickedCategory) {
      case "Random":
        {
          categoryId = 0;
        }
        break;

      case "Sports":
        {
          categoryId = 21;
        }
        break;

      case "Animals":
        {
          categoryId = 27;
        }
        break;

      case "Movie":
        {
          categoryId = 11;
        }
        break;

      case "Music":
        {
          categoryId = 12;
        }
        break;

      case "Video Games":
        {
          categoryId = 15;
        }
        break;

      case "Geography":
        {
          categoryId = 22;
        }
        break;

      case "Computers":
        {
          categoryId = 18;
        }
        break;
      default:
    }

    questionList = await QuizService.getQuiz(categoryId, pickedDifficulty!);

    for (var item in questionList) {
      item.answers.add(item.correct_answer);

      for (var i = 0; i < item.incorrect_answers.length; i++) {
        item.answers.add(item.incorrect_answers[i]);
      }
      //item.answers.shuffle();
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
    if (value == questionList[currentQuestionIndex].correct_answer) {
      int timePoints = _timeCounter;

      if (pickedDifficulty == 'hard') {
        _points = _points + (timePoints * 3);
      } else if (pickedDifficulty == 'medium') {
        _points = _points + (timePoints * 2);
      } else {
        _points = _points + timePoints;
      }
    }

    _timeCounter = 0;
    questionTimer?.cancel();
    _nextQuestionCountDown();

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
    _startGameCountDown = 10;
    const oneSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(oneSec, (timer) {
      if (_startGameCountDown == 0) {
        timer.cancel();
        setGameState(GameState.showQuestion);
        _countDown(); // Activates counter for questions
      } else {
        _startGameCountDown--;
      }
      notifyListeners();
    });
  }

  void _countDown() {
    _timeCounter = 30;
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
      if (_nextQuestionCounter == 0) {
        nextQuestion();
        nextQuestionTimer?.cancel();
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
