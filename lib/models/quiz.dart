import 'package:flutter/cupertino.dart';
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
  List<Question> quizList = [];

  //Data from user for type of quiz to API
  String? pickedCategory = 'Slumpa';
  var categoryList = ['Slumpa', 'Sports', 'Animals'];
  String? pickedDifficulty = 'Easy';
  var difficultyList = ['Easy', 'Medium', 'Hard'];

  //Method to try choicePicker.
  void playGame() {
    print("{Categori: ${pickedCategory}, Difficulty: ${pickedDifficulty}}");
  }

  //Getter for list
  List<Question> get getQuizList => quizList;

//Metod för att anropa service
  void getQuiz() async {
    quizList = await QuizService.getQuiz();
    print("Get quiz ran");
    for (var item in quizList) {
      print(item.toString());
    }
    notifyListeners();
  }
}
