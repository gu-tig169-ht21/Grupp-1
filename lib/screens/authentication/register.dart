import 'package:flutter/material.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/shared/constant.dart';
import 'package:quizapp/screens/shared/loading.dart';
import 'package:quizapp/screens/shared/logo.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String userName = "";
  String email = "";
  String password = "";
  bool isLoading = false;
  String error = "";
  final _formKey = GlobalKey<FormState>();
  final UserState _state = UserState();

  bool validEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Create Account"),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Logo(),
                      const SizedBox(height: 20),
                      TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Enter a username" : null,
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          decoration: textInputDecodartion.copyWith(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.orange,
                              ),
                              labelText: "Username")),
                      const SizedBox(height: 10),
                      TextFormField(
                          validator: (value) {
                            if (!validEmail(value!)) {
                              return "Enter a valid emal";
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: textInputDecodartion.copyWith(
                              icon: const Icon(
                                Icons.email,
                                color: Colors.orange,
                              ),
                              labelText: "Email")),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) => value!.length < 6
                            ? "Minimum 6 characters long password "
                            : null,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        decoration: textInputDecodartion.copyWith(
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.orange,
                            ),
                            labelText: "Password"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 70),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: elevatedButtonStyle.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.orange[800])),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                dynamic result = await _state.register(UserData(
                                    id: "",
                                    displayName: userName,
                                    email: email,
                                    password: password));
                                if (result == null) {
                                  setState(() {
                                    isLoading = false;
                                    error = "Could not register";
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                                // Navigator.pop(context);
                              }
                            },
                            child: const Text("Register"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
