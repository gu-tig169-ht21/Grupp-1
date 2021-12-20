///SPO

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/screens/quiz/game.dart';
import 'package:quizapp/screens/shared/logo.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                QuizTypePicker(
                    pickedValue: state.pickedCategory,
                    valueList: state.categoryList,
                    setValue: setCategory),
                QuizTypePicker(
                  pickedValue: state.pickedDifficulty,
                  valueList: state.difficultyList,
                  setValue: setDifficulty,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40), 
                        shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                    ),),
                        
                    onPressed: () async {
                      //Initialize Quiz
                      await state.getQuiz();
                      state.setGameState(GameState.init);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => GameUI()));
                    },
                    child: const Text(
                      'Start Game',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ],
            ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
        child: DropdownButton(
          dropdownColor: Colors.white,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
          menuMaxHeight: 150,
          isExpanded: true,
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
              child: Align(
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
