import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/screens/quiz/game.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizModel>(context, listen: false);

    String category;
    String difficulty;

    void setCategory(String value) {
      category = value;
      state.pickedCategory = value;
    }

    void setDifficulty(String value) {
      difficulty = value;
      state.pickedDifficulty = value;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("New Game"),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              QuizTypePicker(
                  pickedValue: state.pickedCategory,
                  valueList: state.categoryList,
                  setValue: setCategory),
              QuizTypePicker(
                pickedValue: state.pickedDifficulty,
                valueList: state.difficultyList,
                setValue: setDifficulty,
              ),
              TextButton(
                  onPressed: () async {
                    //Initialize Quiz
                    await state.getQuiz();
                    state.setGameState(GameState.init);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GameUI()));
                  },
                  child: const Text('Spela')),
            ],
          ),
        ));
  }
}

class QuizTypePicker extends StatefulWidget {
  QuizTypePicker(
      {Key? key,
      required this.pickedValue,
      required this.valueList,
      required this.setValue})
      : super(key: key);
  String? pickedValue;
  var valueList;
  Function setValue;

  @override
  _QuizTypePickerState createState() => _QuizTypePickerState();
}

class _QuizTypePickerState extends State<QuizTypePicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.pickedValue,
      onChanged: (String? newValue) {
        setState(() {
          widget.pickedValue = newValue;
          widget.setValue(newValue);
        });
      },
      items: widget.valueList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
