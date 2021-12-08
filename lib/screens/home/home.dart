import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/auth_service.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Quiz Master', style: Theme.of(context).textTheme.headline1),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => _auth.signOut(), icon: Icon(Icons.person))
        ],
      ),
      body: Text(user!.uid),
    );
  }
}
