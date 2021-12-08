import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Registrera"),
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
                margin: const EdgeInsets.only(top: 5),
                child: TextButton(
                  onPressed: () {
                    _auth.registerWithWEmail(email, password);
                    Navigator.pop(context);
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
