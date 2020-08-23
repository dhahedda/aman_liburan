import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/repositories/account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserServices with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user;

  // Future<bool> signUp(String email, String password) async {}
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await jwt();
      DataSession().setEmail(email);
      DataSession().setPassword(password);
      DataSession().setStatusLogin(true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> jwt() async {
    return await _auth.currentUser().then((user) async {
      return await user.getIdToken().then((value) async {
        DataSession().setAuthToken(value.token);
        return value.token;
      });
    });
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
