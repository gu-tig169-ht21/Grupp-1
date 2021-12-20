import 'package:flutter/material.dart';
import 'package:quizapp/services/auth_service.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = "";
    AuthService _auth = AuthService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Reset password"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    labelText: "Email",
                    fillColor: Colors.black,
                    filled: true),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    if (email.isNotEmpty) {
                      _auth.sendResetPasswordLink(email);
                      Navigator.pop(context, email);
                    }
                  },
                  child: const Text(
                    'Send Email',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
