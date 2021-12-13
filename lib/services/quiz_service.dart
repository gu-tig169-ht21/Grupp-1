import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizapp/models/quiz.dart';

var url =
    'https://opentdb.com/api.php?amount=3&category=27&difficulty=easy&type=multiple';

class QuizService {
//Get a quiz question
  static Future<List<Question>> getQuiz() async {
    print(url);
    var response = await http.get(
      Uri.parse(url),
    );
    String bodyString = response.body;
    var json = jsonDecode(bodyString);

    var quest = jsonDecode(response.body)['results'] as List;
    List<Question> questList =
        quest.map((item) => Question.fromJson(item)).toList();

    return questList;
  }
}
