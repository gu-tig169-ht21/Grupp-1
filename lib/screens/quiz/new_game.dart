import 'package:flutter/material.dart';

class NewGame extends StatelessWidget {
  NewGame({Key? key}) : super(key: key);

  String initialCategory = "Slumpa";
  List<String> category = ["Sports", "Animals", "Art"];
  List<String> difficulty = ["Easy", "Medium", "Hard"];

  void setChoices(String value) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DropdownPicker(
            initialValue: initialCategory,
            listItems: category,
            setChoices: setChoices,
          ),
        ],
      ),
    );
  }
}

class DropdownPicker extends StatelessWidget {
  List<String> listItems;
  String initialValue;
  Function setChoices;
  DropdownPicker(
      {Key? key,
      required this.initialValue,
      required this.listItems,
      required this.setChoices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: initialValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      onChanged: (newValue) {
        setChoices(newValue);
      },
      items: listItems.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
