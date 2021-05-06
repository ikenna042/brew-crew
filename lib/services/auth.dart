import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create new user object based on FirebaseUser
  UserDetail _userDetail(User user) {
    return user != null ? UserDetail(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserDetail> get user {
    return _auth.authStateChanges()
        .map(_userDetail);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userDetail(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userDetail(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new doc for the user with the uid
      await DatabaseService(uid: user.uid).updateuserData('0', 'New User', 100);
      return _userDetail(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}