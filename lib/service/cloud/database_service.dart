import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movich/model/user/user_data.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserData(String username, String fullName, String email) async {
    return await _userCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'fullName': fullName,
      'email': email,
    });
  }

  Future updateUserData(String username, String fullName, String email) async {
    return await _userCollection.doc(uid).update({
      'username': username,
      'fullName': fullName,
      'email': email,
    });
  }

  Stream<UserData> get userData {
    return _userCollection.doc(uid).snapshots().map(_userProfileFromSnapshot);
  }

  UserData _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fullName: snapshot['fullName'],
      username: snapshot['username'],
      email: snapshot['email'],
    );
  }
}
