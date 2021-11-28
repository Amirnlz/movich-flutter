import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<bool> isUserValid(String username, String email) async {
    return await isUserExist(username, email) || isEmailValid(email);
  }

  Future<bool> isUserExist(String username, String email) async {
    return await isUsernameExist(username) || await isEmailExist(email);
  }

  Future<bool> isUsernameExist(String username) async {
    final QuerySnapshot result =
        await userCollection.where('username', isEqualTo: username).get();
    return result.docs.isNotEmpty;
  }

  Future<bool> isEmailExist(String email) async {
    final QuerySnapshot result =
        await userCollection.where('email', isEqualTo: email).get();
    return result.docs.isNotEmpty;
  }

  bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
