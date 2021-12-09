import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateUserCollection(uid, data) {
    return users.doc(uid).update(data);
  }

  void addData(uid, collection, data) {
    collection.doc(uid).set(data).then;
  }

  Future<DocumentSnapshot> getUserData(uid) {
    return users.doc(uid).get();
  }

  CollectionReference get users => _db.collection("users");

  CollectionReference get recipes => _db.collection('recipes');
}
