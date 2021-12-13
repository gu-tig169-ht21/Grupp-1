import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/models/user.dart';

class UserService {
  final String uid;

  UserService({required this.uid});

  final FirebaseFirestore databaseReference = FirebaseFirestore.instance;

  //Create new user on register
  Future registerUser(UserData customUser) async {
    return await databaseReference.collection("users").doc(customUser.id).set({
      "id": customUser.id,
      "email": customUser.email,
      "UserName": customUser.displayName,
      "HighScore": customUser.score
    });
  }

  //Get User data
  Future<UserData> getUserInformation(String id) async {
    var result = await databaseReference.collection("users").doc(id).get();

    UserData user = UserData(
      id: result['id'],
      displayName: result['UserName'],
      email: result['email'],
    );
    return user;
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        id: uid,
        displayName: snapshot.data['name'],
        email: snapshot.data['email'],
        score: snapshot.data["ss"]);
  }

  Stream<UserData?> get userData {
    return databaseReference
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  //Update userData
  Future updateUserScore(UserData? user) async {
    return await databaseReference
        .collection("users")
        .doc(user!.id)
        .update({"HighScore": user.score});
  }

/*Future<void> updateUser(user) {
  return users
  .collection("users")
  .doc(user!.displayName)
  .update({'Username': value})
  .then((value) => print("User updated"))
  .catchError((error) => print("Failed to update user: $error"));
} */

  //Delete user?

}
