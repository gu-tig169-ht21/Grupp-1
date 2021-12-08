import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizapp/models/quiz.dart';

const url =
    "https://opentdb.com/api.php?amount=2&category=21&difficulty=easy&type=multiple";

class QuizService {
  //Länk:

//Get a quiz question
  static Future<List<Question>> getQuiz() async {
    var response = await http.get(Uri.parse(url));
    String bodyString = response.body;
    print(bodyString);
    var json = jsonDecode(bodyString);

    var quest = jsonDecode(response.body)['results'] as List;
    List<Question> questList =
        quest.map((item) => Question.fromJson(item)).toList();

    return questList;
  }
}
