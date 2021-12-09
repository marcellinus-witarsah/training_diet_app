import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateUserCollection(uid, data) {
    return users.doc(uid).update(data);
  }

  void addData(uid, collection, data) {
    collection.doc(uid).set(data);
  }

  CollectionReference get users {
    return _db.collection("users");
  }
}
