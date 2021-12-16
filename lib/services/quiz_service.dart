
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizapp/models/quiz.dart';


class QuizService {
//Get a quiz question
  static Future<List<Question>> getQuiz(int category, String difficulty ) async {
var url =
    'https://opentdb.com/api.php?amount=3&category=$category&difficulty=$difficulty';

  
    var response = await http.get(
      Uri.parse(url),
    );

    var quest = jsonDecode(response.body)['results'] as List;
    List<Question> questList =
        quest.map((item) => Question.fromJson(item)).toList();

    return questList;
  }
}
