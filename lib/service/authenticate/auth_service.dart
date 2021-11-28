import 'package:firebase_auth/firebase_auth.dart';
import 'package:movich/service/cloud/user_service.dart';
import 'package:movich/service/cloud/database_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future register(
      String email, String password, String username, String fullName) async {
    try {
      bool isUserValid = await UserService().isUserValid(username, email);
      if (isUserValid) {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = result.user!;
        await DatabaseService(uid: user.uid)
            .addUserData(username, fullName, email);
      } else {
        throw Exception('User already exists');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
