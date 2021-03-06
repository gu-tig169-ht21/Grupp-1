import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/models/user.dart';

class UserService {
  final String uid;

  UserService({required this.uid});

  final FirebaseFirestore databaseReference = FirebaseFirestore.instance;

  //Get user document by ID (Current user)
  Stream<DocumentSnapshot> getUserInformation() {
    return databaseReference.collection("users").doc(uid).snapshots();
  }

  //Get all users HighScore
  Stream<QuerySnapshot> getUserHighScore() {
    return databaseReference
        .collection("users")
        .orderBy('HighScore', descending: true)
        .snapshots();
  }

  Future getUserData() async {
    var snapshot = await databaseReference.collection("users").doc(uid).get();
    return snapshot.data();
  }

  //Update userData (DisplayName)
  Future<void> updateUserName(String displayName) {
    return databaseReference
        .collection("users")
        .doc(uid)
        .update({"UserName": displayName});
  }

  //Update userData (HighScore)
  Future<void> updateHighScore(int score) {
    return databaseReference
        .collection("users")
        .doc(uid)
        .update({"HighScore": score});
  }
}
