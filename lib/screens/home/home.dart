import 'package:flutter/material.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/screens/home/profile.dart';
import 'package:quizapp/screens/quiz/new_game.dart';
import 'package:quizapp/screens/shared/logo.dart';
import 'package:quizapp/services/auth_service.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Quiz Master', style: Theme.of(context).textTheme.headline1),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _auth.signOut(),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 20,
          ),
          const Logo(),
          Container(
            height: 150,
          ),
          //highScore(),
          textButtonFormat(
            context,
            'New Game',
            NewGame(),
          ),
          textButtonFormat(
            context,
            'Highscore',
            const Highscore(),
          ),
        ],
      ),
    );
  }

  Widget textButtonFormat(context, String title, var screen) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minimumSize: const Size.fromHeight(
                70,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen));
            },
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget highScore() {
    return Stack(children: [
      Container(
        width: 500,
        height: 250,
        color: Colors.green,
      ),
    ]);
  }
}
