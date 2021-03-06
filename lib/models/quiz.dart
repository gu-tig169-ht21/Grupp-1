import 'package:flutter/material.dart';
import 'package:quizapp/services/quiz_service.dart';
import 'dart:async';

class Quiz {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<dynamic> incorrectAnswers;
  List<String> answers = [];

  Quiz(
      {required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  static Quiz fromJson(dynamic json) {
    return Quiz(
        category: json['category'],
        type: json['type'],
        difficulty: json['difficulty'],
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers:
            (json['incorrect_answers'] as List).map((map) => map).toList());
  }
}

enum GameState {
  ready,
  init,
  showQuestion,
  showColors,
}

class QuizModel extends ChangeNotifier {
  List<Quiz> questionList = [];
  int _points = 0;
  int currentQuestionIndex = 0;
  Timer nextQuestionTimer = Timer(const Duration(seconds: 1), () {});
  Timer questionTimer = Timer(const Duration(seconds: 1), () {});
  Timer initTimer = Timer(const Duration(seconds: 1), () {});
  late int _timeCounter;
  int _nextQuestionCounter = 5;
  late int _startGameCountDown;
  String pickedCategory = 'Random';
  List<String> categoryList = [
    'Random',
    'Sports',
    'Animals',
    'Movie',
    'Music',
    'Video Games',
    'Geography',
    'Computers'
  ];
  String? pickedDifficulty = 'Easy';
  List<String> difficultyList = ['Easy', 'Medium', 'Hard'];
  GameState _gameState = GameState.ready;

  List<Quiz> get getQuizList => questionList;
  int get points => _points;
  int get timeCounter => _timeCounter;
  int get nextQuestionCounter => _nextQuestionCounter;
  int get startGameCountDown => _startGameCountDown;
  int get getcurrentQuestionIndex => currentQuestionIndex;
  GameState get gameState => _gameState;

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

    questionList =
        await QuizService.getQuiz(categoryId, pickedDifficulty!.toLowerCase());

    for (var item in questionList) {
      item.answers.add(item.correctAnswer);

      for (var i = 0; i < item.incorrectAnswers.length; i++) {
        item.answers.add(item.incorrectAnswers[i]);
      }
      item.answers.shuffle();
    }

    currentQuestionIndex = 0;
    _points = 0;

    initCountDown();
  }

  void setGameState(GameState state) {
    _gameState = state;
    notifyListeners();
  }

  Color? setColor(int index) {
    if (_gameState == GameState.showColors) {
      var question = questionList[currentQuestionIndex];

      String currentIndex = question.answers[index];

      if (currentIndex == question.correctAnswer) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.blueGrey[800];
    }
  }

  Quiz getQuestion() {
    return questionList[currentQuestionIndex];
  }

  void checkAnswer(String value) {
    if (value == questionList[currentQuestionIndex].correctAnswer) {
      int timePoints = _timeCounter;

      if (pickedDifficulty == 'Hard') {
        _points = _points + (timePoints * 3);
      } else if (pickedDifficulty == 'Medium') {
        _points = _points + (timePoints * 2);
      } else {
        _points = _points + timePoints;
      }
    }

    _timeCounter = 0;
    questionTimer.cancel();
    _nextQuestionCountDown();

    setGameState(GameState.showColors);

    notifyListeners();
  }

  void nextQuestion() {
    currentQuestionIndex++;

    setGameState(GameState.showQuestion);
    notifyListeners();
  }

  void initCountDown() {
    _startGameCountDown = 6;
    const oneSec = Duration(seconds: 1);
    initTimer = Timer.periodic(oneSec, (timer) {
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
        questionTimer.cancel();
        setGameState(GameState.showColors);
        _nextQuestionCountDown();
      } else if (questionList.length == currentQuestionIndex) {
        questionTimer.cancel();
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
        const Duration(
          seconds: 1,
        ), (timer) {
      if (_nextQuestionCounter == 0) {
        nextQuestion();
        nextQuestionTimer.cancel();
        _countDown();
      } else if (questionList.length == currentQuestionIndex) {
        nextQuestionTimer.cancel();
        setGameState(GameState.ready);
      } else {
        _nextQuestionCounter--;
      }
      notifyListeners();
    });
  }
}
