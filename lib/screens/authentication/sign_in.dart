import 'package:flutter/material.dart';
import 'package:quizapp/screens/authentication/register.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.amber),
                    labelText: "Email",
                    fillColor: Colors.black,
                    filled: true),
              ),
              const SizedBox(height: 10),
              TextFormField(
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
                  onPressed: () {},
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register())),
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
