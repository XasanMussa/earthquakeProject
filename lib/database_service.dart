import 'package:cloud_firestore/cloud_firestore.dart';

class databaseService {
  String? uid;
  databaseService({this.uid});

//halkan collection ka magacisa ku xus
//dadtabase iyo collection isku mid wye
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future saveUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "uid": uid,
    });
  }

  Future gettingUserData(email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
