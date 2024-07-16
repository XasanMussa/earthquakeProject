import 'package:earthquake_app/helper/helper_function.dart';
import 'package:earthquake_app/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login

  Future loginWithUserNameAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //registeration

  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //database service
        await databaseService(uid: user.uid).saveUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await helperFunctions.saveUserLogedInStatus(false);
    await helperFunctions.saveEmail("");
    await helperFunctions.saveUserName("");
    await firebaseAuth.signOut();
  }
}
