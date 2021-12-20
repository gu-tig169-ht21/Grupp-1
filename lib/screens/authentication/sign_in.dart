import 'package:flutter/material.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/authentication/register.dart';
import 'package:quizapp/screens/authentication/reset_password.dart';
import 'package:quizapp/screens/shared/constant.dart';
import 'package:quizapp/screens/shared/loading.dart';
import 'package:quizapp/screens/shared/logo.dart';

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
    return isLoading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Logo(),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter email" : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: textInputDecodartion.copyWith(
                            icon: const Icon(Icons.email, color: Colors.orange),
                            labelText: "Email"),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          obscureText: true,
                          validator: (value) =>
                              value!.isEmpty ? "Enter password" : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: textInputDecodartion.copyWith(
                              icon:
                                  const Icon(Icons.lock, color: Colors.orange),
                              labelText: "Password")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ),
                              );
                              //print(email);
                            },
                            child: const Text("Forgot password?"),
                          ),
                        ],
                      ),
                      Text(error),
                      const SizedBox(height: 100),
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
                                    error = "Wrong Credentials";
                                  });
                                }

                                dynamic result =
                                    await _state.signIn(email, password);
                                if (result == null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child: const Text("Sign In")),
                          ElevatedButton(
                              style: elevatedButtonStyle.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.indigo[800])),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: const Text("Register")),
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
