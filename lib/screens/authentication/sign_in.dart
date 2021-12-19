import 'package:flutter/material.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/authentication/register.dart';
import 'package:quizapp/screens/authentication/reset_password.dart';
import 'package:quizapp/services/auth_service.dart';

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
        title: const Text("Quiz Master"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  icon: Icon(Icons.lock, color: Colors.amber),
                  labelText: "Password",
                  fillColor: Colors.black,
                  filled: true,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                    print(email);
                  },
                  child: Text("Forgot password?")),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    _state.signIn(email, password);
                  },
                  child: const Text(
                    'Sign In',
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
                    'Register',
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
