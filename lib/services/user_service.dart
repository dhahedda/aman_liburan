import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password) async {}
  Future<bool> signIn(String user, String password) async {
    _auth.signInWithEmailAndPassword(email: user, password: password);
  }

  Future<String> jwt() async {
    return await _auth.currentUser().then((user) async {
      return await user.getIdToken().then((value) async {
        return value.token;
      });
    });
  }

  Future<bool> signOut() async {
    await _auth.signOut();
  }
}
