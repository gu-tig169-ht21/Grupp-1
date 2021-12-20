import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/screens/shared/loading.dart';
import 'package:quizapp/services/user_service.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayName = "";

    AuthUser user = Provider.of<AuthUser>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Profile', style: Theme.of(context).textTheme.headline4),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: UserService(uid: user.uid).getUserInformation(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              // Felhantering om inga data kommer
              if (!snapshot.hasData) {
                return const Loading();
              }

              final data = snapshot.requireData;
              final fieldText = TextEditingController();

              return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    informationHolder(context, data),
                    const SizedBox(height: 20),
                    const SizedBox(height: 5),
                    TextField(
                      controller: fieldText,
                      onChanged: (value) {
                        displayName = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(19.0)),
                        labelText: 'Change username',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: 'Enter new username',
                      ),
                    ),
                    const SizedBox(height: 9),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))),
                        onPressed: () {
                          if (displayName.isNotEmpty) {
                            UserService(uid: user.uid)
                                .updateUserName(displayName);
                          }
                          fieldText.clear();
                        },
                        child: const Text("Update"))
                  ],
                ),
              );
            }));
  }
}

Widget informationHolder(context, DocumentSnapshot documentSnapshot) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        tileFormat("Username:", documentSnapshot["UserName"]),
        tileFormat("Highscore:", documentSnapshot["HighScore"].toString()),
      ]));
}

Widget tileFormat(String title, String subtitle) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
    subtitle: Text(subtitle,
        style: const TextStyle(color: Colors.black, fontSize: 18)),
  );
}
