import 'package:flutter/material.dart';
import 'package:quizapp/screens/home/home.dart';
import 'package:quizapp/screens/authentication/sign_in.dart';
import 'package:quizapp/screens/authentication/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Master',
      home: const SignIn(),
      theme: ThemeData(
        // Theme settings
        brightness: Brightness.dark,
        backgroundColor: Colors.blue,
        fontFamily: 'Roboto',

        // Appbar icon theme
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),

        // Text themes
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 28.0,
              color: Colors.white,
              fontWeight: FontWeight.normal),
          bodyText1: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.normal),
        ),

        // ElevatedButton themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange[800],
            textStyle: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
