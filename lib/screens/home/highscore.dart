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
          highscore(),
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
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text("Ellebasi",
              style: TextStyle(fontSize: 40, color: Colors.black)),
          leading: Icon(
            Icons.stars,
            color: Colors.orange,
            size: 40,
          ),
          trailing: Text('100 p',
              style: TextStyle(fontSize: 30, color: Colors.black)),
        ),
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

  Widget highscore() {
    final List<String> item = <String>[
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J'
    ];
    //final List<int> colorCodes = <int>[600, 500, 100, 600, 500, 100];
    int number = 0;

    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: item.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          selected: true,
          selectedTileColor: Colors.orange,
          title: Text('Item ${item[index]}',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          leading:
              Text('1', style: TextStyle(fontSize: 20, color: Colors.white)),
          trailing:
              Text('50 p', style: TextStyle(fontSize: 20, color: Colors.white)),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));
  }
}
