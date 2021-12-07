import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrera'),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Namn",
                    hintText: "Namn",
                    fillColor: Colors.white,
                    filled: true)),
            SizedBox(height: 20),
            TextFormField(
                decoration: const InputDecoration(
                    labelText: "Namn", fillColor: Colors.white, filled: true)),
          ],
        ),
      ),
    );
  }
}
