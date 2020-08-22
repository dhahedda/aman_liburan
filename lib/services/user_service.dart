import 'package:aman_liburan/components/data_session.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<bool> signUp(String email, String password) async {}
  Future<bool> signIn(String user, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: user, password: password);
      // FirebaseUser firebaseUser = await _auth.currentUser();
      // print('_auth.currentUser()');
      // print(await _auth.currentUser());
      // print(await jwt());
      await jwt();
      DataSession().setEmail(user);
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
