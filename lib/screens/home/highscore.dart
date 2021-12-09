// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Highscore extends StatelessWidget {
  const Highscore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Quiz Master', style: Theme.of(context).textTheme.headline4),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.score, color: Colors.orange),
              label: Text(
                'TRYCK PÅ MAJ',
                style: TextStyle(color: Colors.orange),
              )),
        ],
      ),
      body: Column(
        children: [
          textHeaderOne(),
          yourScore(),
          textHeaderTwo(),
          highscore("Ellebasi"),
          highscore("Joel"),
          highscore("Jonas"),
          highscore("Viktor"),
          highscore("Anton"),
        ],
      ),
    );
  }

  Widget textHeaderOne() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('Your score', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }

  Widget yourScore() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text("1.Ellebasi",
                style: TextStyle(fontSize: 40, color: Colors.black))),
      ),
    );
  }

  Widget textHeaderTwo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('Highscore', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }

  Widget highscore(String namn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(namn,
                style: TextStyle(fontSize: 20, color: Colors.black))),
      ),
    );
  }
}
