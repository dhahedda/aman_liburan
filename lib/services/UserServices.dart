import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserServices {
  var _baseUrl = 'http://192.168.1.11:3000';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> signIn(String user, String password) async {
    _auth
        .signInWithEmailAndPassword(email: user, password: password)
        .then((value) => print(value));
  }

  Future<bool> signOut() async {
    _auth.signOut();
  }
}
