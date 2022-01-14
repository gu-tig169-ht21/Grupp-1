import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/shared/constant.dart';
import 'package:quizapp/screens/shared/loading.dart';
import 'package:quizapp/screens/shared/logo.dart';
import 'package:quizapp/services/auth_service.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String userName = "";
  String email = "";
  String password = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  bool validEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool validPassword(String password) {
    return RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9]).{6,}')
        .hasMatch(password);
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
              reverse: true,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Logo(),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextFormField(
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
                            ),
                            TextFormField(
                              validator: (value) {
                                if (!validPassword(value!)) {
                                  return "At least one upper, lower case, & digit is required";
                                }
                              },
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: elevatedButtonStyle.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.orange[800]),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  dynamic result = await widget._auth
                                      .registerWithWEmail(UserData(
                                          displayName: userName.trim(),
                                          email: email,
                                          password: password));

                                  if (result == null) {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Fluttertoast.showToast(
                                        msg: "Registration failed",
                                        gravity: ToastGravity.TOP);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  // Navigator.pop(context);
                                }
                              },
                              child: const Text("Register"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
