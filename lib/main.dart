import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/home/highscore.dart';
import 'package:quizapp/screens/home/home.dart';
import 'package:quizapp/screens/authentication/sign_in.dart';
import 'package:quizapp/screens/authentication/register.dart';
import 'package:quizapp/screens/home/profile.dart';
import 'package:quizapp/screens/wrapper.dart';
import 'package:quizapp/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizModel>(create: (context) => QuizModel()),
        StreamProvider<User?>.value(
          value: AuthService().authChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        home: Wrapper(),
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
      ),
    );
  }
}
