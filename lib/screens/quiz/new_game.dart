// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/screens/quiz/game.dart';
import 'package:quizapp/screens/shared/logo.dart';

class NewGame extends StatelessWidget {
  String? category;
  String? difficulty;
  NewGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizModel>(context, listen: false);

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
        title: const Text("New Game"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Logo(),
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Category",
                      style: TextStyle(fontSize: 20),
                    )),
                QuizTypePicker(
                    pickedValue: state.pickedCategory,
                    valueList: state.categoryList,
                    setValue: setCategory),
                Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: const Text("Difficulty",
                        style: TextStyle(fontSize: 20))),
                QuizTypePicker(
                  pickedValue: state.pickedDifficulty,
                  valueList: state.difficultyList,
                  setValue: setDifficulty,
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () async {
                  //Initialize Quiz
                  await state.getQuiz();
                  state.setGameState(GameState.init);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Game()));
                },
                child: const Text(
                  'Start Game',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
          ],
        ),
      ),
    );
  }
}

class QuizTypePicker extends StatefulWidget {
  String? pickedValue;
  List<String> valueList;
  Function setValue;
  QuizTypePicker(
      {Key? key,
      required this.pickedValue,
      required this.valueList,
      required this.setValue})
      : super(key: key);

  @override
  _QuizTypePickerState createState() => _QuizTypePickerState();
}

class _QuizTypePickerState extends State<QuizTypePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
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
    );
  }
}
