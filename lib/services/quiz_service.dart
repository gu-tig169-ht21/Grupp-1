import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizapp/models/quiz.dart';

class QuizService {
  static Future<List<Quiz>> getQuiz(int category, String difficulty) async {
    var url =
        'https://opentdb.com/api.php?amount=10&category=$category&difficulty=$difficulty';
    var response = await http.get(Uri.parse(url),
        headers: {'Content-type': 'application/json charset=utf-8'});

    var quest = json.decode(response.body)['results'] as List;

    List<Quiz> questList = quest.map((item) => Quiz.fromJson(item)).toList();

    return questList;
  }
}
