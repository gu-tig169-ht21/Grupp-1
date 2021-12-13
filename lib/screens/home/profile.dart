import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/user_service.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);

    return StreamBuilder<UserData?>(
        stream: UserService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Quizmaster',
                    style: Theme.of(context).textTheme.headline4),
                actions: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        color: Colors.orange,
                        size: 30,
                      ),
                      label: const Text(
                        'Scores',
                        style: TextStyle(color: Colors.orange),
                      )),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(userData),
                    textHeader('Your profile'),
                    informationHolder(context),
                    textHeader('Update profile'),
                    nameBox(),
                    emailBox(),
                    passwordBox(),
                  ],
                ),
              ),
            );
          }

          return Text("HEj");
        });
  }

  Widget textHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(text, style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }

  Widget informationHolder(context) {
    var state = Provider.of<AuthUser?>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            tileFormat('User name:', ""),
            tileFormat('Email address:', ""),
            tileFormat('Password', obscureText('123456')),
          ],
        ),
      ),
    );
  }

  String obscureText(String text) {
    return text.replaceAll(RegExp(r"."), "*");
  }

  Widget tileFormat(String title, String subtitle) {
    return ListTile(
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.black)),
    );
  }

  Widget nameBox() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'New name',
          labelStyle: TextStyle(color: Colors.white),
          hintText: 'Enter new name',
        ),
      ),
    );
  }

  Widget emailBox() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'New email address',
          labelStyle: TextStyle(color: Colors.white),
          hintText: 'Enter new email address',
        ),
      ),
    );
  }

  Widget passwordBox() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'New password',
          labelStyle: TextStyle(color: Colors.white),
          hintText: 'Enter new password',
        ),
      ),
    );
  }
}
