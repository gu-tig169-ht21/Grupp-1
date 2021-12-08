import 'package:flutter/material.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/authentication/register.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";

  UserState _state = UserState();

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Logga in"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.amber),
                    labelText: "Email",
                    fillColor: Colors.black,
                    filled: true),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.amber),
                  labelText: "Lösenord",
                  fillColor: Colors.black,
                  filled: true,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    _state.signIn(email, password);
                  },
                  child: const Text(
                    'Logga in',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 5),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: const Text(
                    'Registrera',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo[800])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
