import 'package:flutter/material.dart';

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
      ),
      body: Container(
        //Style later on

        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.amber),
                    labelText: "Email",
                    hintText: "Skriv din emailadress här",
                    hintStyle: TextStyle(color: Colors.red),
                    fillColor: Colors.black,
                    filled: true),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.amber),
                  labelText: "Lösenord",
                  hintText: "Skriv ditt lösenord här",
                  fillColor: Colors.black,
                  filled: true,
                ),
              ),
              loggaInButton(),
              Container(
                  width: double.infinity,
                  child: TextButton(
                    child: Text('Registrera'),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget loggaInButton() {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Logga in'),
        style: ElevatedButton.styleFrom(),
      ),
    );
  }

  Widget registreraButton() {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Registrera'),
        style: ElevatedButton.styleFrom(),
      ),
    );
  }
}
