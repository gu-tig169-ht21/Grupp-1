import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  Stream<User?> get authChanges {
    return _auth.authStateChanges().map((user) => user);
  }

  //Logga in

  Future<User?> signIn(email, password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;

    //userState.signedIn(value: true);
    return user;
  }

  //Registrera mail + lösen

  Future registerWithWEmail(email, password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = result.user;
    print(user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print("User signedOut");
  }
}
