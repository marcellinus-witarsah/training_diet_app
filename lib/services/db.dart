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

  Stream<QuerySnapshot> getUserRecordsByID(uid) {
    return userRecords.where("uid", isEqualTo: uid).snapshots();
  }

  CollectionReference get users => _db.collection("users");

  CollectionReference get recipes => _db.collection('recipes');
  CollectionReference get userRecords => _db.collection('user_records');
}
