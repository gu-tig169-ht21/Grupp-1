// ignore_for_file: unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/user_service.dart';

class Highscore extends StatelessWidget {
  const Highscore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Quiz Master',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: UserService(uid: user.uid).getUserHighScore(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text("Loading...");
              }
              final data = snapshot.data!.docs;
              String currentUser = "";
              int currentUserScore = 0;

              for (var item in data) {
                if (item['id'] == user.uid) {
                  currentUser = item['UserName'];
                  currentUserScore = item['HighScore'];
                }
              }
              return Column(
                children: [
                  textHeader("HighScore"),
                  yourScore(currentUser, currentUserScore),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return highscore(snapshot.data!.docs[index]);
                        }),
                  ),
                ],
              );
            }));
  }

  Widget textHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }

  Widget yourScore(String currentUser, int currentUserScore) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            currentUser,
            style: const TextStyle(fontSize: 40, color: Colors.black),
          ),
          leading: const Icon(
            Icons.stars,
            color: Colors.orange,
            size: 40,
          ),
          trailing: Text(
            '$currentUserScore p',
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget highscore(DocumentSnapshot document) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      selected: true,
      selectedTileColor: Colors.orange,
      title: Text(
        '${document["UserName"]}',
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      trailing: Text(
        "${document["HighScore"]}",
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
