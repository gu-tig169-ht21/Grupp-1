import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizmaster', style: Theme.of(context).textTheme.headline4),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Colors.orange,
                size: 30,
              ),
              label: Text(
                'Scores',
                style: TextStyle(color: Colors.orange),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
    var state = Provider.of<User>(context);

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
            tileFormat('Full name:', 'Isabelle Löfvendahl'),
            tileFormat('Email address:', '${state.email}'),
            tileFormat('Password', obscureText('123456')),
          ],
        ),
      ),
    );
  }

  String obscureText(String text){
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
