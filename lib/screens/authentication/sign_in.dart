import 'package:flutter/material.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/authentication/register.dart';
import 'package:quizapp/screens/authentication/reset_password.dart';
import 'package:quizapp/screens/shared/constant.dart';
import 'package:quizapp/screens/shared/loading.dart';
import 'package:quizapp/screens/shared/logo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";
  bool isLoading = false;
  String error = "";
  final _formKey = GlobalKey<FormState>();

  final UserState _state = UserState();

  @override
  Widget build(BuildContext context) {
    //final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return isLoading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
              reverse: true,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 120, right: 20, left: 20, bottom: 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Logo(),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) =>
                                    value!.isEmpty ? "Enter email" : null,
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                decoration: textInputDecodartion.copyWith(
                                    icon: const Icon(Icons.email,
                                        color: Colors.orange),
                                    labelText: "Email"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                  obscureText: true,
                                  validator: (value) =>
                                      value!.isEmpty ? "Enter password" : null,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  decoration: textInputDecodartion.copyWith(
                                      icon: const Icon(Icons.lock,
                                          color: Colors.orange),
                                      labelText: "Password")),
                            ),
                            TextButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResetPassword(),
                                  ),
                                );
                              },
                              child: const Text("Forgot password?", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  minimumSize: const Size.fromHeight(
                                    50,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    var result =
                                        await _state.signIn(email, password);
                                    if (result == null) {
                                      setState(() {
                                        isLoading = false;
                                        Fluttertoast.showToast(
                                            msg: "Could not sign in",
                                            gravity: ToastGravity.TOP);
                                      });
                                    }
                                  }
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 28),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ElevatedButton(
                                style: elevatedButtonStyle.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[600])),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: const Text("Register")),
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
