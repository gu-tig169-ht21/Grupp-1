import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/quiz.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/quiz/game_score.dart';
import 'package:quizapp/screens/wrapper.dart';
import 'package:quizapp/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizModel>(create: (context) => QuizModel()),
        ChangeNotifierProvider<UserState>(create: (context) => UserState()),
        StreamProvider<AuthUser?>.value(
          value: AuthService().authUser,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        theme: ThemeData(
          // Theme settings
          brightness: Brightness.dark,
          backgroundColor: Colors.blue,
          fontFamily: 'Roboto',

          // Appbar icon theme
          appBarTheme: const AppBarTheme(
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
