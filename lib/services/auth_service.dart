import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/models/user.dart';
import 'package:quizapp/services/user_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore databaseReference = FirebaseFirestore.instance;

class AuthService {
  //Create custom user from Firebase User
  AuthUser? _fromFirebaseUserTocustomUser(User? user) {
    return user != null
        ? AuthUser(
            uid: user.uid,
          )
        : null;
  }

  Stream<AuthUser?> get authUser {
    return _auth
        .authStateChanges()
        .map((user) => _fromFirebaseUserTocustomUser(user));
  }

  //Logga in

  Future signIn(email, password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
  }

  // Create a CollectionReference called users that references the firestore collection

  //Registrera mail + lösen
  Future registerWithWEmail(UserData customUser) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: customUser.email, password: customUser.password);

    User? user = result.user;
    customUser.id = user!.uid;

    await databaseReference.collection("users").doc(customUser.id).set({
      "id": customUser.id,
      "email": customUser.email,
      "UserName": customUser.displayName,
      "HighScore": customUser.score
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print("User signedOut");
  }
}
