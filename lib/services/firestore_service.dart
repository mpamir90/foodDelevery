import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(String username, String noHp) async {
    await firestore
        .collection("user")
        .add({"username": username, "no handphone": noHp});
  }
}
