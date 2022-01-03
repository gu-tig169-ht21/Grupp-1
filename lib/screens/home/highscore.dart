import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/shared/loading.dart';
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
            'Highscore',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: UserService(uid: user.uid).getUserHighScore(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Loading();
              }
              final data = snapshot.data!.docs;
              String currentUser = "";
              int currentUserScore = 0;
              String currentUserId = user.uid;

              for (var item in data) {
                if (item['id'] == user.uid) {
                  currentUser = item['UserName'];
                  currentUserScore = item['HighScore'];
                }
              }

              return Column(
                children: [
                  Center(child: yourScore(currentUser, currentUserScore)),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return highscore(snapshot.data!.docs[index], index,
                                currentUserId);
                          }),
                    ),
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

  Color? getListColor(int index) {
    if (index == 0) {
      return Colors.yellowAccent[400];
    } else if (index == 1) {
      return Colors.grey[200];
    } else if (index == 2) {
      return Colors.brown[200];
    }
    return Colors.orange;
  }

  Widget highscore(DocumentSnapshot document, int index, currentUserId) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: Card(
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          tileColor: getListColor(index),
          leading: Text(
            "${index + 1}",
            style: const TextStyle(fontSize: 22, color: Colors.black),
          ),
          title: document.id == currentUserId
              ? const Text("You",
                  style: TextStyle(fontSize: 22, color: Colors.black))
              : Text(
                  '${document["UserName"]}',
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
          trailing: Text(
            "${document["HighScore"]} points",
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
